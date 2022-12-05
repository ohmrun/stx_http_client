package stx.http.client;

@:using(stx.http.client.RemotingPayload.RemotingPayloadLift)
typedef RemotingPayload<T> = Equity<RemotingContext,T,HttpClientFailure>;

class RemotingPayloadLift{
  /**
    Dumps the req/res into an error for inspection if there is one.
  **/
  public function toRes<T>(self:RemotingPayload<T>):Res<T,HttpClientFailure>{
    return if(self.has_error()){
      __.reject(self.error.concat(__.fault().of(E_HttpClient_Context(self.asset))));
    }else{
      __.accept(self.value);
    }
  }
}