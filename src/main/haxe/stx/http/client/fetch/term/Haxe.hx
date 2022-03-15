package stx.http.client.fetch.term;

private enum HttpData{
  HttpData(dat:String);
  HttpStatus(dat:Int);
  HttpError(err:String);
} 
class Haxe implements ClientApi extends eu.ohmrun.fletcher.term.Fun1Future<RemotingContext,RemotingContext,Noise>{
  static public function unit(){
    return new Haxe();
  }
  public function future(state:RemotingContext):Future<RemotingContext>{
    final delegate                                    = new sys.Http(state.asset.url);
    final complete  : FutureTrigger<RemotingContext>  = Future.trigger();
    final stream    = Stream.make(
      (cb:Chunk<HttpData,HttpClientFailure>->Void) ->{
        delegate.onError   = (err:String)-> {
          __.log().error(err);
          cb(Val(HttpError(err)));
        } 
        delegate.onStatus  = (status:Int) -> {
          __.log().debug(_ -> _.pure(status));
          cb(Val(HttpStatus(status)));
        }
        delegate.onData    = (data:String) -> {
          __.log().debug(_ -> _.pure(data));
          cb(Val(HttpData(data)));
        }   
        return () -> {};
      }
    );
    var status    = None;
    var response  = None; 
    function completer(){
      switch([status,response]){
        case [Some(int),Some(data)] :
          final decode = switch(data){
            case Left(str)    : () -> {
              __.log().debug(_ -> _.pure(state.asset));
              return __.reject(__.fault().of(E_HttpClient_Error('$str at ${state.asset.url}')));
            }
            case Right(str)   : () -> __.accept(str); 
          }
          complete.trigger(
            state.map(
              _ ->  ({
                code      : int,
                body      : decode().fold(ok -> Emiter.pure(Bytes.ofString(ok)),e -> Emiter.lift(__.quit(e))),
                messages  : [],
                headers   : Headers.unit()
              }:Response)
            )
          );
        default : 
      }
    }
    stream.handle(
      (x) -> {
        switch(x){
          case Val(HttpStatus(data)) :
            status   = Some(data);
          case Val(HttpData(data))     :
            response = Some(Right(data));
          case Val(HttpError(data))     :
            response = Some(Left(data));
          default:
        }
        completer();
      }
    );
    final is_post = switch(state.asset.method){
      case POST : true;
      default   : false;
    }
    
    __.log().blank("headers to add");
    for(header in __.option(state.asset.headers).defv(Headers.unit())){
      __.log().debug(_ -> _.pure(header));
      delegate.addHeader(header.fst().toString(),header.snd());
    }
    __.log().blank("headers added");
    if(is_post){
      //TODO other forms of Content
      var value = haxe.Json.stringify(state.asset.body);
      __.log().trace(value);
      delegate.setPostBytes(haxe.io.Bytes.ofString(value));
    }
    __.log().blank('to request');
    delegate.request(is_post);
    __.log().blank('requested');
    return complete.asFuture();
  }
}