package stx.http.client;

class RequestOptionsCtr extends Clazz implements RequestOptionsCtrApi{
  public function pure(headers:Headers):RequestOptions{
    return {
      headers : headers,
      agent   : "stx" 
    };
  }
  public function make(headers:Headers,url:String,body:Option<Content>,method : HttpMethod = GET){
    var request = pure(headers);
    return request.fill(url,body,method);
  } 
}