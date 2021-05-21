package stx.http.client;

typedef RemotingContextErrorExtractorDef<T,E> = {
  public function extract(response:Response<Dynamic>,t:Option<T>):Defect<E>;
}