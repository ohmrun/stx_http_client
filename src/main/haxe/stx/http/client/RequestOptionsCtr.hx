package stx.http.client;

class RequestOptionsCtr extends Clazz{
  public function Make(headers:Headers,?agent:String){
    return RequestOptions.make(
      __.option(headers).defv(Headers.unit()),
      agent ?? "stx" 
    );
  } 
}