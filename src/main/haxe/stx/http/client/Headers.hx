package stx.http.client;

typedef HeadersDef = Array<Pair<HeaderId,String>>;

@:forward abstract Headers(HeadersDef) from HeadersDef{
  public function new(self) this = self;
  static public function unit(){ return lift([]); }
  static public function lift(self:HeadersDef):Headers return new Headers(self);
  
  @:to public function toNodeFetchHeaders(){
    var next = new node_fetch.Headers();
    for(tp in this){
      next.set(tp.a.toString(),tp.b);
    }
    return next;
  }
  public function prj():HeadersDef return this;
  private var self(get,never):Headers;
  private function get_self():Headers return lift(this);

  public function copy():Headers{
    return this.copy();
  }
  public function toArray(){
    return this;
  }
  public function concat(rhs:Headers){
    return lift(this.concat(rhs.toArray()));
  }
}