package stx.http.client;

class Module extends Clazz{
  public function ctx<T>(ext,req,res){
    return new stx.http.client.RemotingContextCtr().pull0(ext,req,res);
  }
  #if hxnodejs
  public function fetch<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request):Pledge<RemotingContext<T,E>,StxHttpClientFailure>{
    var freq = req.toNodeFetchRequest();
    return node_fetch.Fetch.call(freq).toPledge().flat_map(
      (res:node_fetch.Response) -> new RemotingContextCtr().pull0(extractor,req,res)
    );
  }
  #elseif js
  public function fetch<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request):Pledge<RemotingContext<T,E>,StxHttpClientFailure>{
    return js.Lib.global.fetch(req.toJsRequest()).toPledge().flat_map(
      (res:js.html.Response) -> new RemotingContextCtr().pull0(extractor,req,res)
    );
  }
  #end
}