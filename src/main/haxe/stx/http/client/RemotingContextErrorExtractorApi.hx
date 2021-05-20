package stx.http.client;

interface RemotingContextErrorExtractorApi<T,E>{
  public function extract(response:Response,t:Option<T>):Defect<E>;
}