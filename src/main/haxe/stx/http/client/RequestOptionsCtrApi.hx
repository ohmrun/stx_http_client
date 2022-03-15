package stx.http.client;

interface RequestOptionsCtrApi {
  
  public function pure(headers:Headers):RequestOptions;
  public function make(headers:Headers,url:String,body:Option<Content>,method : HttpMethod = GET):Request;
}