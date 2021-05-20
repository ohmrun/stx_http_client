package stx.http.client;

using stx.lift.ArrayLift;

class RemotingContextCtr extends Clazz{
  public function pull0<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request,res:Response):Pledge<RemotingContext<T,E>,StxHttpClientFailure>{
    return try{
      var pledge = res.json().toPledge();
      pledge.map(
        (dyn:Dyn) -> new RemotingContext(extractor,req,res,dyn)
      );
    }catch(e){
      Pledge.accept(new RemotingContext(extractor,req,res,null));
    }
  }
}