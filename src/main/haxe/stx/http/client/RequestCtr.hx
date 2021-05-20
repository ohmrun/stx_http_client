package stx.http.client;

class RequestCtr extends Clazz{
  public function make<C:FetchModelConfigDef>(config:C,method:HttpMethod,node:String,headers:Headers,?body:Content<Dynamic>){
    return Request.make(
      '${config.base}/$node',
      method,
      config.options.headers.concat(headers),
      body
    );
  } 
}