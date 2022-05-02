package stx.http.client;

#if (nodejs)
  import node_fetch.RequestInit;
#end

@:using(stx.http.client.RequestOptions.RequestOptionsLift)
@:forward abstract RequestOptions(RequestOptionsDef) from RequestOptionsDef{
  public function new(self:RequestOptionsDef){ this = self;}
  static public function unit():RequestOptions{
    return new RequestOptions({
      { headers : Headers.unit() }
    });
  }
  #if (nodejs)
    @:to public function toRequestInit():RequestInit{
      return {
        headers : this.headers.toNodeFetchHeaders()
      };
    }
  #end
  public function copy(?headers,?agent):RequestOptions{
    return {
      headers : __.option(headers).defv(this.headers),
      agent   : __.option(agent).defv(this.agent),
    }
  }
  public function with_header(header:Tup2<HeaderId,String>){
    return copy(this.headers.snoc(header));
  }
}
class RequestOptionsLift{
  static public function fill(self:RequestOptions,url:String,body:Option<Content>,method : HttpMethod = GET):stx.http.client.Request{
    return (
      {
        url     : url,
        headers : self.headers,
        body    : body.fold(ok -> ok, () -> Content.unit()),
        method  : method 
      } : RequestCls
    );
  }
}