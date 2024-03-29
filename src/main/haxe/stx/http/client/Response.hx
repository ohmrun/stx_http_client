package stx.http.client;

typedef ResponseDef = {
  final code        : HttpStatusCode;
  final body        : Emiter<Bytes,HttpClientFailure>;

  final headers     : Headers;
  final messages    : Cluster<ResponseMessage>;  
}
@:forward abstract Response(ResponseDef) from ResponseDef to ResponseDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:ResponseDef):Response return new Response(self);

  @:noUsing static public function make(code:HttpStatusCode,body:Emiter<Bytes,HttpClientFailure>,?headers:Headers,?messages:Cluster<ResponseMessage>){
    return lift({
      code      : code,
      body      : body,
      headers   : __.option(headers).def(() -> Headers.unit()),
      messages  : __.option(messages).def(() -> [])
    });
  }
  #if js
  @:from static public function fromJsResponse(self:js.html.Response):Response{
    return make(
      self.status,
      Emiter.lift(
       __.tran(
        (_:Nada) -> {
          return try{
            __.hold(
                self.text().toPledge().rectify(
                  (err:Refuse<stx.fail.HttpClientFailure>) -> switch(err.data){
                    case Some(EXTERNAL(E_HttpClient_Error(ee))) :
                      var match = Chars.lift(ee.toString()).starts_with("FetchError:");
                      __.log().debug(_ -> _.pure({ ee : ee, match : match }));
                      return if (ee.toString().startsWith("FetchError: invalid json")){
                        __.reject(__.fault().of(E_HttpClient_CantDecode('json')));
                      }else{
                        __.reject(err);
                      }
                    default :
                      __.reject(err);
                  }
                ).fold(
                  ok -> __.emit(Bytes.ofString(ok),__.stop()),
                  no -> __.quit(no)
                )
            );
          }catch(e:haxe.Exception){
            __.quit(Error.Caught(None,None,Some(__.here()),e));
          }
        }
      )),
      Headers.fromJsHeaders(self.headers),
      Cluster.unit().snoc(({ message : self.statusText }:ResponseMessage))      
    );
  }
  #end
  #if (nodejs && !macro)
  @:from static public function fromNodeFetchResponse(self:node_fetch.Response):Response{
    return make(
      Math.round(self.status),
      Emiter.lift(
        __.tran(
         (_:Nada) -> {
            return try{
              __.hold(
                Provide.fromFuture(
                  self.text().toPledge().rectify(
                    err -> switch(err.data){
                      case Some(INTERNAL(ee)) :
                        var match = Chars.lift(ee.toString()).starts_with("FetchError:");
                        __.log().debug(_ -> _.pure({ ee : ee, match : match }));
                        return if (ee.toString().startsWith("FetchError: invalid json")){
                          __.reject(__.fault().of(E_HttpClient_CantDecode('json')));
                        }else{
                          __.reject(err);
                        }
                      default :
                        __.reject(err);
                    }
                  ).fold(
                    ok -> __.emit(Bytes.ofString(ok),__.stop()),
                    no -> __.quit(no)
                  )
                )
              );
            }catch(e:haxe.Exception){
              __.quit(Error.Caught(None,None,__.option(__.here()),e).toRefuse());
            }
          }
      )),
      Headers.fromNodeFetchHeaders(self.headers),
      Cluster.unit().snoc(({ message : self.statusText }:ResponseMessage))
    );
  }
  #end
  public function prj():ResponseDef return this;
  private var self(get,never):Response;
  private function get_self():Response return lift(this);
}