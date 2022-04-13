package stx.http.client;

typedef ResponseMessageDef = {
  final message : String;
  final ?id     : String;
} 
abstract ResponseMessage(ResponseMessageDef) from ResponseMessageDef to ResponseMessageDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:ResponseMessageDef):ResponseMessage return new ResponseMessage(self);

  public function prj():ResponseMessageDef return this;
  private var self(get,never):ResponseMessage;
  private function get_self():ResponseMessage return lift(this);
}