package stx.http.client;

class Fetch{
  static public function apply<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request):Pledge<RemotingContext<T,E>,StxHttpClientFailure>{
    var freq = req.toNodeFetchRequest();
    return node_fetch.Fetch.call(freq).toPledge().flat_map(
      (res:node_fetch.Response) -> new RemotingContextCtr().pull0(extractor,req,res)
    );
  }
}