package stx.http.client;

interface RemotingContextValueExtractorApi<T,E>{
  public function extract(dyn:Dynamic):Option<Outcome<T,Defect<E>>>;
}