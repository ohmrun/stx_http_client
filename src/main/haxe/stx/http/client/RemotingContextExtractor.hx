package stx.http.client;

abstract RemotingContextExtractor<T,E>(RemotingContextExtractorDef<T,E>) from RemotingContextExtractorDef<T,E> to RemotingContextExtractorDef<T,E>{
  public function new(self) this = self;
  static public function lift<T,E>(self:RemotingContextExtractorDef<T,E>):RemotingContextExtractor<T,E> return new RemotingContextExtractor(self);

  public function prj():RemotingContextExtractorDef<T,E> return this;
  private var self(get,never):RemotingContextExtractor<T,E>;
  private function get_self():RemotingContextExtractor<T,E> return lift(this);

  static public function unit<E>():RemotingContextExtractorDef<Dynamic,E>{
    return ({
      value : ({
        extract : (dyn:Dynamic) -> (__.option(__.success((dyn:Dyn))):Option<Outcome<Dynamic,Defect<E>>>)
      }:RemotingContextValueExtractorDef<Dynamic,E>),
      error : ({
          extract : (res:Response<Dynamic>,val:Option<Dynamic>) -> Defect.unit()
        }:RemotingContextErrorExtractorDef<Dynamic,E>)
      }:RemotingContextExtractorDef<Dynamic,E>
    );
  }
}