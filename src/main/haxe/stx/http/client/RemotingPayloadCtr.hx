package stx.http.client;

class RemotingPayloadCtr extends Clazz{
  public function Make(request:Request):RemotingPayload<Nada>{
    return Equity.make(RemotingContext.make(request,None),Nada);
  }
}