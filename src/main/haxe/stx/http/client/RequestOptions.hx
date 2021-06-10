package stx.http.client;

#if hxnodejs
  import node_fetch.RequestInit;
#end

@:using(stx.http.client.RequestOptions.RequestOptionsLift)
@:forward abstract RequestOptions(RequestOptionsDef) from RequestOptionsDef{
  #if hxnodejs
    @:to public function toRequestInit():RequestInit{
      return {
        headers : this.headers.toNodeFetchHeaders()
      };
    }
  #end
}
class RequestOptionsLift{
  static public function fill(self:RequestOptions,url:String,body:Content<Dynamic>,method : HttpMethod = GET):stx.http.client.Request{
    return ({
      url     : url,
      headers : self.headers,
      body    : body,
      method  : method 
    }:RequestCls);
  }
}