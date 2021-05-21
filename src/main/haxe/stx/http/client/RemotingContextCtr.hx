package stx.http.client;

using stx.lift.ArrayLift;

class RemotingContextCtr extends Clazz{
  public function pull0<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request,res:Response<Pledge<Dynamic,Dynamic>>):Pledge<RemotingContext<T,E>,StxHttpClientFailure>{
    return res.decode().fold(
      fut   -> Pledge.fromTinkFuture(fut).map(
        (dyn:Dyn) -> new RemotingContext(extractor,req,res,dyn)
      ),
      (err) -> switch(err.data){
        case Some(ERR_OF(E_HttpClient_CantDecode("json")))  : 
          Pledge.accept(new RemotingContext(extractor,req,res,null));
        default                                             : Pledge.reject(err);
      } 
    );
  }
}