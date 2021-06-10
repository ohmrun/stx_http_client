package stx.http.client;

enum abstract HeaderId(String){
  var ContentType     = "Content-Type";
  var Accept          = "Accept";
  var Connection      = "Connection";
  var Authorization   = "Authorization";
  public function toString(){
    return this;
  }
  private function new(self){
    this = self;
  }
  static public function fromString(self:String):HeaderId{
    return new HeaderId(self);
  }
}