package stx.http.client;

class RemotingPayloadCtr extends Clazz{
  public function pure(request:Request):RemotingPayload<Noise>{
    return Equity.make(RemotingContext.make(request,None),Noise);
  }
}