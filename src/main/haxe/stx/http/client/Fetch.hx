package stx.http.client;

abstract class Fetch<C:FetchConfigDef>{

  private final config    : C; 

  public function new(config:C){
    this.config     = config;
  }
  public function request(method:HttpMethod,path:String,headers:Headers,body:Option<Content>):RemotingPayload<Nada>{
    return 
      Equity.make(
        RemotingContext.make(
          Request.make(method,'${this.config.base}$path',this.config.options.headers.concat(headers),body.defv(null)),
          None
        ),
        Nada,
        null
      );
  }
}