package stx.http.client;

class RequestCtr extends Clazz{
  public function make<C:FetchConfigDef>(config:C,method:HttpMethod,node:String,headers:Headers,?body:Content){
    return Request.make(
      method,
      '${config.base}/$node',
      config.options.headers.concat(headers),
      body
    );
  } 
}