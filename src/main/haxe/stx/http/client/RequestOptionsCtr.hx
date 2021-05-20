package stx.http.client;

class RequestOptionsCtr extends Clazz implements RequestOptionsCtrApi{
  public function pure(headers:Headers):RequestOptions{
    return {
      headers : headers,
      agent   : "vanguardia/ov8" 
    };
  }
  public function make(headers:Headers,url:String,body:Content<Dynamic>,method : HttpMethod = GET){
    var request = pure(headers);
    return request.fill(url,body,method);
  } 
}