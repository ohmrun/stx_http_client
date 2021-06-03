package stx.http.client;

class Fetch{
  #if hxnodejs
  static public function apply<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request):Pledge<RemotingContext<T,E>,StxHttpClientFailure>{
    var freq = req.toNodeFetchRequest();
    return node_fetch.Fetch.call(freq).toPledge().flat_map(
      (res:node_fetch.Response) -> new RemotingContextCtr().pull0(extractor,req,res)
    );
  }
  #elseif js
  static public function apply<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request):Pledge<RemotingContext<T,E>,StxHttpClientFailure>{
    return js.Lib.global.fetch(req.toJsRequest()).toPledge().flat_map(
      (res:js.html.Response) -> new RemotingContextCtr().pull0(extractor,req,res)
    );
  }
  #end
}