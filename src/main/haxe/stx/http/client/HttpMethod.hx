package stx.http.client;

enum abstract HttpMethod(String) to String{
  var POST;
  var GET;
  var HEAD;
  var DELETE;
  var PATCH;
  var PUT;
  var LIST;
    
  public function equals(str:String){
    //trace('$str $this');
    return str == this;
  }
  public function toString(){
    return this;
  }
  @:noUsing static public function fromString(str:String):Option<HttpMethod>{
    return switch(str){
      case "POST"   : __.option(POST);
      case "GET"    : __.option(GET);
      case "HEAD"   : __.option(HEAD);
      case "DELETE" : __.option(DELETE);
      case "PATCH"  : __.option(PATCH);
      default       : stx.Option.unit();
    }
  }
}