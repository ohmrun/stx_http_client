package stx.http.client;

#if js
import haxe.extern.EitherType;
import js.lib.ArrayBufferView;
import js.lib.ArrayBuffer;
import js.html.FormData;
import js.html.URLSearchParams;
#end
enum ContentSum{
  ContentString(string:String);
}
abstract Content(Null<ContentSum>) from Null<ContentSum>{
  @:noUsing static public function lift<T>(self:ContentSum){
    return new Content(self);
  }
  static public function unit():Content{
    return lift(null);
  }
  public function new(self) this = self;

  #if js
  public function toBody():Null<EitherType<Blob, EitherType<EitherType<ArrayBufferView, ArrayBuffer>, EitherType<FormData, EitherType<URLSearchParams, String>>>>>{
    return switch(this){
      case ContentString(string)  : string;
      case null                   : null; 
    }
  }
  #end
} 