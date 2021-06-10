package stx.http.client;

abstract class Fetch<C:FetchConfigDef,P,R,E> extends ClientCls<P,R,E>{

  private final config    : C; 
  public final extractor  : RemotingContextExtractor<R,E>;

  public function new(config:C,extractor:RemotingContextExtractor<R,E>){
    this.config     = config;
    this.extractor  = extractor;
  }
  public function request(method:HttpMethod,path:String,headers:Headers,body:Option<P>):Request{
    return Request.make(method,'${this.config.base}$path',this.config.options.headers.concat(headers),body.defv(null));
  }
}