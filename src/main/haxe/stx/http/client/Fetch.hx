package stx.http.client;

class Fetch{
  static public function apply<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request):Pledge<RemotingContext<T,E>,StxHttpClientFailure>{
    return node_fetch.Fetch.call(req.toNodeFetchRequest()).toPledge().flat_map(new RemotingContextCtr().pull0.bind(extractor,req));
  }
}