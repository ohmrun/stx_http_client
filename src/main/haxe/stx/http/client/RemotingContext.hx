package stx.http.client;

typedef RemotingContextDef      = { request : Request, response : Option<Response> };

interface RemotingContextApi {
  public final request  : Request;
  public final response : Option<Response>;
}
class RemotingContextCls implements RemotingContextApi{
  public final request  : Request;
  public final response : Option<Response>;
  public function new(request,response){
    this.request  = request;
    this.response = response;
  }
}
@:using(stx.http.client.RemotingContext.RemotingContextLift)
@:forward abstract RemotingContext(RemotingContextApi) from RemotingContextApi to RemotingContextApi{
  public function new(self) this = self;
  @:noUsing static public function lift(self:RemotingContextApi):RemotingContext return new RemotingContext(self);
  static public inline function make(request,response){
    return lift(new RemotingContextCls(request,response));
    
  }
  public function prj():RemotingContextApi return this;
  private var self(get,never):RemotingContext;
  private function get_self():RemotingContext return lift(this);
}
class RemotingContextLift{
  
}