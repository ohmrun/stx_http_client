package stx.http.client;

typedef RemotingContextErrorExtractorDef<T,E> = {
  public function extract(response:Response,t:Option<T>):Defect<E>;
}