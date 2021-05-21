package stx.http.client;

using stx.lift.ArrayLift;

class RemotingContextCtr extends Clazz{
  public function pull0<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request,res:Response<Pledge<Dynamic,Dynamic>>):Pledge<RemotingContext<T,E>,StxHttpClientFailure>{
    function rectifier(err:Err<StxHttpClientFailure>):Res<RemotingContext<T,E>,StxHttpClientFailure>{
      return switch(err.data){
        case Some(ERR_OF(E_HttpClient_CantDecode("json")))  : 
          __.accept(new RemotingContext(extractor,req,res,null));
        default                                             : 
          __.reject(err);
      }
    }
    return res.decode().fold(
      pledge   -> pledge.map(
        (dyn:Dyn) -> new RemotingContext(extractor,req,res,dyn)
      ).rectify(rectifier),
      rectifier.fn().then(Pledge.make)  
    );
  }
}