package stx.http.client;

@:publicFields @:structInit class RequestCls{
  
  final method                : HttpMethod;
  final url                   : String;
  
  final headers               : Headers;
  
  @:optional final body       : Content;  

  public function toString(){
    return '$method $url $headers ${haxe.Json.stringify(body," ")}';
  }
}
@:forward abstract Request(RequestCls) from RequestCls to RequestCls{
  public function new(self) this = self;
  @:noUsing static public function lift(self:RequestCls):Request return new Request(self);
  @:noUsing static public function make(method:HttpMethod,url:String,?headers:Headers,?body:Option<Content>){
    return __.option(body).is_defined().if_else(
      () -> 
      ({
        url     : url,
        method  : method,
        headers : headers,
        body    : body.defv(Content.unit())
      }:Request),
      () -> ({
          url     : url,
          method  : method,
          headers : headers
      }:Request)
    );
  }
  #if (js && !nodejs)
  public function toJsRequest():js.html.Request{
    var headers = new haxe.DynamicAccess();
      for(i in __.option(this.headers).defv(new Headers())){
        headers.set(i.fst().toString(),i.snd());
      }
      return switch(this.method){
        case POST : 
          new js.html.Request(this.url,
          {
            body    : this.body.toBody(),
            headers : headers,
            method  : this.method
          });
        default : 
          new js.html.Request(this.url,
          {
            headers : headers,
            method  : this.method
          });
      }
  }  
  #end
  #if (nodejs)
    @:to public function toNodeFetchRequest(){
      var headers = new node_fetch.Headers();
      for(i in __.option(this.headers).defv(new Headers())){
        headers.set(i.fst().toString(),i.snd());
      }
      return switch(this.method){
        case POST : return new node_fetch.Request((this.url:String),
          ({
            body    : this.body.toBody(),
            headers : headers,
            method  : this.method
          }:node_fetch.RequestInit));
        default : 
          new node_fetch.Request((this.url:String),
          ({
            headers : headers,
            method  : this.method
          }:node_fetch.RequestInit));
      }
    }
  #end
  public function copy(?method:HttpMethod,?url:String,?headers:Headers,?body:Dynamic){
    return make(
      __.option(method).defv(this.method),
      __.option(url).defv(this.url),
      __.option(headers.copy()).defv(this.headers.copy()),
      __.option(body).defv(this.body)
    );
  }
  public function prj():RequestCls return this;
  private var self(get,never):Request;
  private function get_self():Request return lift(this);
}