package stx.http.client;

class Module extends Clazz{
  public function ctx<T>(ext,req,res){
    return new stx.http.client.RemotingContextCtr().pull0(ext,req,res);
  }
  public function fetch<T,E>(ext:RemotingContextExtractorDef<T,E>,req:Request):Pledge<RemotingContext<T,E>,StxHttpClientFailure>{
    return Fetch.apply(ext,req);
  }
}