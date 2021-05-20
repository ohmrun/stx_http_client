package stx.http.client;

abstract Content<T>(T){
  static public function lift<T>(self:T){
    return new Content(self);
  }
  public function new(self) this = self;

  @:noUsing @:from static public function fromT<T>(v:T):Content<T>{
    return new Content(v);
  }
  // public function toJsonString(?replacer){
  //   return haxe.Json.stringify(this,replacer);
  // }
} 