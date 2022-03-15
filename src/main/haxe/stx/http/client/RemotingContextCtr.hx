package stx.http.client;

class RemotingContextCtr extends Clazz{
  public function pure(request:Request):RemotingContext{
    return Equity.make(request,null);
  }
}