package stx.http.client.fetch.term;

private enum HttpData{
  HttpData(dat:String);
  HttpStatus(dat:Int);
  HttpError(err:String);
} 
class Haxe{
  private final request   : Request;

  public function new(request:Request){
    this.request            = request;
  }
  static public function fetch<T,E>(req:Request):Pledge<Response<Res<Dynamic,HttpClientFailure>>,HttpClientFailure>{
    var http = new Haxe(req);
    return http.reply();
  }
  public function reply():Pledge<Response<Res<Dynamic,HttpClientFailure>>,HttpClientFailure>{
    __.log().debug('fetch: ${request}');
    final delegate  = new sys.Http(request.url);
    final complete  : FutureTrigger<Res<Response<Res<Dynamic,HttpClientFailure>>,HttpClientFailure>> = Future.trigger();
    final stream    = Stream.make(
      (cb:Chunk<HttpData,HttpClientFailure>->Void) ->{
        delegate.onError   = (err:String)-> {
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
              __.log().debug(_ -> _.pure(request));
              return __.reject(__.fault().of(E_HttpClient_Error('$str at ${request.url}')));
            }
            case Right(str)   : () -> __.accept(haxe.Json.parse(str)); 
          }
          complete.trigger(__.accept(
            ({
              code      : int,
              decode    : decode,
              messages  : [],
              headers   : Headers.unit()
            }:Response<Res<Dynamic,HttpClientFailure>>)
          ));
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
    final is_post = switch(request.method){
      case POST : true;
      default   : false;
    }
    
    for(header in __.option(request.headers).defv(Headers.unit())){
      __.log().debug(_ -> _.pure(header));
      delegate.addHeader(header.fst().toString(),header.snd());
    }
    if(is_post){
      //TODO other forms of Content
      var value = Json.stringify(request.body);
      __.log().trace(value);
      delegate.setPostBytes(haxe.io.Bytes.ofString(value));
    }
    delegate.request(is_post);

    return Pledge.lift(complete);
  }
}