package stx.http.client;

class RemotingContextCtr extends Clazz{
  public function pull0<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request,res:Response<Pledge<Dynamic,Dynamic>>):Pledge<RemotingContext<T,E>,HttpClientFailure>{
    function rectifier(err:Err<HttpClientFailure>):Res<RemotingContext<T,E>,HttpClientFailure>{
      return switch(err.data){
        case Some(ERR_OF(E_HttpClient_CantDecode("json")))  : 
          __.accept(new RemotingContextCls(extractor,req,res,null).asRemotingContext());
        default                                             : 
          __.reject(err);
      }
    }
    return res.decode().fold(
      pledge   -> pledge.map(
        (dyn:Dyn) -> {
          //trace('here: $dyn');
          return new RemotingContextCls(extractor,req,res,dyn).asRemotingContext();
        }
      ).rectify(rectifier),
      rectifier.fn().then(Pledge.make)  
    );
  }
  public function pull<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request,res:Response<Res<Dynamic,HttpClientFailure>>):Res<RemotingContext<T,E>,HttpClientFailure>{
    var data = res.decode();
    return data.map(data -> new RemotingContextCls(extractor,req,res,data).asRemotingContextDef());
  }
}