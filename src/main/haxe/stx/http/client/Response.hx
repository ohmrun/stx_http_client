package stx.http.client;

typedef ResponseDef<T> = {
  final code        : HttpStatusCode;
  function decode() : Res<T,StxHttpClientFailure>;

  final headers     : Headers;
  final messages    : Cluster<ResponseMessage>;  
}
@:forward abstract Response<T>(ResponseDef<T>) from ResponseDef<T> to ResponseDef<T>{
  public function new(self) this = self;
  static public function lift<T>(self:ResponseDef<T>):Response<T> return new Response(self);

  static public function make<T>(code:HttpStatusCode,decode:Void->Res<T,StxHttpClientFailure>,?headers:Headers,?messages:Cluster<ResponseMessage>){
    return lift({
      code      : code,
      decode    : decode,
      headers   : __.option(headers).def(() -> Headers.unit()),
      messages  : __.option(messages).def(() -> [])
    });
  }
  #if js
  @:from static public function fromJsResponse(self:js.html.Response):Response<Pledge<Dynamic,StxHttpClientFailure>>{
    return make(
      self.status,
      () -> {
          return try{
            __.accept(
              self.json().toPledge().rectify(
                err -> switch(__.tracer()(err.data)){
                  case Some(ERR(str)) :
                    var match = Chars.lift(str.toString()).starts_with("FetchError:");
                    trace('"$str" $match');
                    return if (str.toString().startsWith("FetchError: invalid json")){
                      trace("JERE");
                      __.reject(__.fault().of(E_HttpClient_CantDecode('json')));
                    }else{
                      __.reject(err);
                    }
                  default :
                    __.reject(err);
                }
              )
            );
          }catch(e:Dynamic){
            __.reject(__.fault().of(E_HttpClient_CantDecode('json')));
          } 
      },
      Headers.fromJsHeaders(self.headers),
      Cluster.unit().snoc(({ message : self.statusText }:ResponseMessageDef))      
    );
  }
  #end
  #if hxnodejs
  @:from static public function fromNodeFetchResponse(self:node_fetch.Response):Response<Pledge<Dynamic,StxHttpClientFailure>>{
    return make(
      Math.round(self.status),
      () -> {
        return try{
          __.accept(
            self.json().toPledge().rectify(
              err -> switch(__.tracer()(err.data)){
                case Some(ERR(str)) :
                  var match = Chars.lift(str.toString()).starts_with("FetchError:");
                  //trace('"$str" $match');
                  return if (str.toString().startsWith("FetchError: invalid json")){
                    //trace("JERE");
                    __.reject(__.fault().of(E_HttpClient_CantDecode('json')));
                  }else{
                    __.reject(err);
                  }
                default :
                  __.reject(err);
              }
            )
          );
        }catch(e:Dynamic){
          __.reject(__.fault().of(E_HttpClient_CantDecode('json')));
        }
      },
      Headers.fromNodeFetchHeaders(self.headers),
      [ { message : self.statusText } ]
    );
  }
  #end
  public function prj():ResponseDef<T> return this;
  private var self(get,never):Response<T>;
  private function get_self():Response<T> return lift(this);
}