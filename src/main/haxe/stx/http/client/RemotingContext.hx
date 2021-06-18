package stx.http.client;

import stx.http.client.remoting_context.term.Unit;
import stx.http.client.remoting_context.term.FlatMap;
import stx.http.client.remoting_context.term.Map;

interface RemotingContextApi<T,E>{
  public var value(get,null)          : Option<T>;
  public function get_value():Option<T>;
  public var error(get,null)          : Defect<E>;
  public function get_error():Defect<E>; 

  public function asRemotingContextDef():RemotingContextDef<T,E>;
  public function asRemotingContext():RemotingContext<T,E>;
}
typedef RemotingContextDef<T,E> = {
  var value(get,null)          : Option<T>;
  function get_value():Option<T>;
  var error(get,null)          : Defect<E>;
  function get_error():Defect<E>;
  
  public function asRemotingContextDef():RemotingContextDef<T,E>;
  public function asRemotingContext():RemotingContext<T,E>;
}
abstract class RemotingContextAbs<T,E> implements RemotingContextApi<T,E>{
  public var value(get,null)          :  Option<T>;
  abstract public function get_value():  Option<T>;
  public var error(get,null)          :  Defect<E>;
  abstract public function get_error():  Defect<E>; 

  public function asRemotingContextDef():RemotingContextDef<T,E>{
    return this;
  }
  public function asRemotingContext():RemotingContext<T,E>{
    return this;
  }
}
class PureRemotingContextCls<T,E> extends RemotingContextAbs<T,E>{
  final extract : T;
  public function new(extract){
    this.extract = extract;
  }
  public function get_value():Option<T>{
    return __.option(extract);
  }
  public function get_error():Defect<E>{
    return [];
  }
}
class RemotingContextCls<T,E> implements RemotingContextApi<T,E> extends RemotingContextAbs<T,E>{
  public function new(internal,request,response,extract){
    this.internal   = internal;
    this.request    = request;
    this.response   = response;  
    this.extract    = extract;  
  }
  private final extract  : Dynamic;

  public final request   : Request; 
  public final response  : Response<Dynamic>;

  public final internal  : RemotingContextExtractorDef<T,E>;

  public function get_error(){
    var payload       = try_get_payload();
    var value_error   = payload.flat_map(internal.value.extract).fold(
      res -> res.fold(
        ok -> Defect.unit(),
        er -> er
      ),
      () -> Defect.unit()//TODO
    );
    var error_error   = internal.error.extract(response);

    return value_error.concat(error_error);
  }

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

@:using(stx.http.client.RemotingContext.RemotingContextLift)
@:forward abstract RemotingContext<T,E>(RemotingContextDef<T,E>) from RemotingContextDef<T,E> to RemotingContextDef<T,E>{
  static public var _(default,never) = RemotingContextLift;
  public function new(self) this = self;
  static public function lift<T,E>(self:RemotingContextDef<T,E>):RemotingContext<T,E> return new RemotingContext(self);

  public function prj():RemotingContextDef<T,E> return this;
  private var self(get,never):RemotingContext<T,E>;
  private function get_self():RemotingContext<T,E> return lift(this);

  @:noUsing static public function pure(extract:T){
    return lift(new PureRemotingContextCls(extract));
  }
  @:from static public function fromRemotingContextCls<T,E>(self:RemotingContextCls<T,E>){
    return lift(self.asRemotingContextDef());
  }
  @:from static public function fromRemotingContextApi<T,E>(self:RemotingContextApi<T,E>){
    return lift(self.asRemotingContextDef());
  }
  public function outcome(){
    return this.error.is_defined().if_else(
      ()  ->  __.failure(this.error),
      ()  ->  __.success(this.value)
    );
  }
  public function res(){
    return this.error.is_defined().if_else(
      ()  ->  __.reject(this.error.toErr()),
      ()  ->  __.accept(this.value)
    );
  }
}
class RemotingContextLift{
  static public function flat_map<P,Pi,E>(self:RemotingContextDef<P,E>,fn:P->RemotingContext<Pi,E>):RemotingContext<Pi,E>{
    return new FlatMap(self,fn).asRemotingContextDef();
  }
  static public function map<P,Pi,E>(self:RemotingContextDef<P,E>,fn:P->Pi):RemotingContext<Pi,E>{
    return new Map(self,fn).asRemotingContextDef();
  }
}