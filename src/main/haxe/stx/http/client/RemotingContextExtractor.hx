package stx.http.client;

@:using(stx.http.client.RemotingContextExtractorLift)
@:forward abstract RemotingContextExtractor<T,E>(RemotingContextExtractorDef<T,E>) from RemotingContextExtractorDef<T,E> to RemotingContextExtractorDef<T,E>{
  public function new(self) this = self;
  static public function lift<T,E>(self:RemotingContextExtractorDef<T,E>):RemotingContextExtractor<T,E> return new RemotingContextExtractor(self);

  public function prj():RemotingContextExtractorDef<T,E> return this;
  private var self(get,never):RemotingContextExtractor<T,E>;
  private function get_self():RemotingContextExtractor<T,E> return lift(this);

  static public function unit<E>():RemotingContextExtractor<Dynamic,E>{
    return ({
      value : ({
        extract : (dyn:Dynamic) -> (__.option(__.success((dyn:Dyn))):Option<Outcome<Dynamic,Defect<E>>>)
      }:RemotingContextValueExtractorDef<Dynamic,E>),
      error : ({
          extract : (res:Response<Dynamic>) -> Defect.unit()
        }:RemotingContextErrorExtractorDef<Dynamic,E>)
      }:RemotingContextExtractorDef<Dynamic,E>
    );
  }
}
class RemotingContextExtractorLift{
  static public function map<T,Ti,E>(self:RemotingContextExtractor<T,E>,fn:T->Ti){
    return adjust(
      self,
      (t:T) -> __.accept(fn(t))
    );
  }
  static public function adjust<T,Ti,E>(self:RemotingContextExtractor<T,E>,fn:T->Outcome<Ti,Defect<E>>):RemotingContextExtractor<Ti,E>{
    return lift({
      value : {
        extract : (dyn:Dynamic) -> this.value.extract(dyn).map( oc -> oc.flat_map(fn) )
      },
      error : {
        extract : this.error.extract
      }
    });
  }
}