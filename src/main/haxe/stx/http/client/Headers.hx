package stx.http.client;

typedef HeadersDef = Array<Tup2<HeaderId,String>>;

@:forward abstract Headers(HeadersDef) from HeadersDef{
  public function new(?self) this = __.option(self).defv([]);
  static public function unit(){ return lift([]); }
  static public function lift(self:HeadersDef):Headers return new Headers(self);

  #if hxnodejs
  @:to public function toNodeFetchHeaders(){
    var next = new node_fetch.Headers();
    for(tp in this){
      switch(tp){
        case tuple2(a,b) : next.set(a.toString(),b); 
      }
    }
    return next;
  }
  #end
  
  #if js
    @:from static public function fromJsHeaders(self:js.html.Headers){
      var res = [];
      self.forEach(
        (value,name) -> {
          res.push(tuple2(cast name,value));
        }
      );
      return lift(res);
    }
  #end
  #if hxnodejs
    @:from static public function fromNodeFetchHeaders(self:node_fetch.Headers){
      var res = [];
      self.forEach(
        (value,name) -> {
          res.push(tuple2(cast name,value));
        }
      );
      return lift(res);
    }
  #end
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