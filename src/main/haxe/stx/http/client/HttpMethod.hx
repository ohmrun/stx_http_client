package stx.http.client;

import tink.http.Method in TinkMethod;

enum abstract HttpMethod(String) to String{
  var POST;
  var GET;
  var HEAD;
  var DELETE;
  var PATCH;
  var PUT;
  //var LIST;
  var OPTIONS;
    
  public function equals(str:String){
    //trace('$str $this');
    return str == this;
  }
  public function toString(){
    return this;
  }
  @:noUsing static public function fromString(str:String):Option<HttpMethod>{
    return switch(str){
      case "POST"       : __.option(POST);
      case "GET"        : __.option(GET);
      case "HEAD"       : __.option(HEAD);
      case "DELETE"     : __.option(DELETE);
      case "PATCH"      : __.option(PATCH);
      case "PUT"        : __.option(PUT);
      //case "LIST"       : __.option(LIST);
      case "OPTIONS"    : __.option(OPTIONS);
      default           : stx.Option.unit();
    }
  }
  
  @:to public function toTinkMethod(){
    return switch(this){
      case POST     : TinkMethod.POST;
      case GET      : TinkMethod.GET;
      case HEAD     : TinkMethod.HEAD;
      case DELETE   : TinkMethod.DELETE;
      case PATCH    : TinkMethod.PATCH;
      case PUT      : TinkMethod.PUT;
    //case LIST     : TinkMethod.ofString(LIST,;
      case OPTIONS  : TinkMethod.OPTIONS;
      default       : throw UNIMPLEMENTED;
    }
  }
}