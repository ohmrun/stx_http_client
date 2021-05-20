package stx.http.client;

class RemotingContext<T,E>{
  public function new(internal,request,response,extract){
    this.internal   = internal;
    this.request    = request;
    this.response   = response;  
    this.extract    = extract;  
  }
  private final extract  : Dynamic;

  public final request   : Request; 
  public final response  : Response;

  public final internal  : RemotingContextExtractorApi<T,E>;

  public var error(get,null) : Defect<E>;
  public function get_error(){
    var payload       = try_get_payload();
    var value_error   = payload.flat_map(internal.value.extract).fold(
      res -> res.fold(
        ok -> Defect.unit(),
        er -> er
      ),
      () -> Defect.unit()//TODO
    );
    var error_error   = internal.error.extract(response,value);

    return value_error.concat(error_error);
  }

  public var value(get,null) : Option<T>;
  public function get_value() : Option<T>{
    return try_get_payload().flat_map(internal.value.extract).fold(
      res -> res.fold(
        ok -> __.option(ok),
        no -> Option.unit()
      ),
      () -> Option.unit()
    );
  }
  private final function try_get_payload():Option<Dynamic>{
    try{
      return __.option(extract);
    }catch(e:Dynamic){  
      return stx.Option.unit();
    }
  }
}