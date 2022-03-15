package stx.http.client;

typedef RemotingContextDef      = EquityDef<Request,Response,HttpClientFailure>;
typedef RemotingContextApi      = EquityApi<Request,Response,HttpClientFailure>;
typedef RemotingContextCls      = EquityCls<Request,Response,HttpClientFailure>;

@:using(stx.http.client.RemotingContext.RemotingContextLift)
typedef RemotingContext         = Equity<Request,Response,HttpClientFailure>;

// @:forward abstract RemotingContext(RemotingContextDef) from RemotingContextDef to RemotingContextDef{
//   static public var _(default,never) = RemotingContextLift;
//   public function new(self) this = self;
//   static public function lift(self:RemotingContextDef):RemotingContext return new RemotingContext(self);

//   public function prj():RemotingContextDef return this;
//   private var self(get,never):RemotingContext;
//   private function get_self():RemotingContext return lift(this);

//   @:to public function toEquity():Equity<Request,Response,HttpClientFailure>{
//     return Equity.lift(this);
//   }
//   @:from static public function fromEquity(self:Equity<Request,Response,HttpClientFailure>):RemotingContext{
//     return lift(self.prj());
//   }
//   public function map(fn){
//     return lift(Equity._.map(this,fn));
//   }
//   public function errata(fn){
//     return lift(Equity._.errata(this,fn));
//   }
// }
class RemotingContextLift{
  
}