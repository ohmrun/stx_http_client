package stx.http.client;

abstract class Fetch<C:FetchConfigDef,P,R,E> implements ClientApi<P,R,E> extends Configured<C>{

  public final extractor : RemotingContextExtractor<R,E>;
  
  public function new(config:C,extractor:RemotingContextExtractor<R,E>){
    super(config);
    this.extractor = extractor;
  }
  public function request(method:HttpMethod,path:String,headers:Headers,body:Option<P>):Request{
    return Request.make(method,'${this.config.base}$path',this.config.options.headers.concat(headers),body.defv(null));
  }
  public function asClientDef():ClientDef<P,R,E>{
    return cast this;//TODO bug?`gi
  }
}