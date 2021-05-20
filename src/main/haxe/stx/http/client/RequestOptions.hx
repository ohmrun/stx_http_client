package stx.http.client;
@:using(stx.http.client.RequestOptions.RequestOptionsLift)
@:forward abstract RequestOptions(RequestOptionsDef) from RequestOptionsDef{
  @:to public function toRequestInit():RequestInit{
    return {
      headers : this.headers.toNodeFetchHeaders()
    };
  }
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