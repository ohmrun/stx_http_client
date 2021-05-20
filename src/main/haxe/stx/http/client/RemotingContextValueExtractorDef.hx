package stx.http.client;

typedef RemotingContextValueExtractorDef<T,E> = {
  public function extract(dyn:Dynamic):Option<Outcome<T,Defect<E>>>;
}