package stx.http.client;

class RemotingPayloadCtr extends Clazz{
  public function pure(request:Request):RemotingPayload<Nada>{
    return Equity.make(RemotingContext.make(request,None),Nada);
  }
}