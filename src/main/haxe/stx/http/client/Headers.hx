package stx.http.client;

typedef HeadersDef = Cluster<Tup2<HeaderId,String>>;

@:forward abstract Headers(HeadersDef) from HeadersDef{
  public function new(?self) this = __.option(self).defv(Cluster.unit());
  static public function unit(){ return lift([]); }
  static public function lift(self:HeadersDef):Headers return new Headers(self);

  @:from static public function fromHeaderIdMap(self:haxe.ds.Map<HeaderId,String>){
    var arr = [];
    for( key => val in self){
    arr.push(tuple2(key,val));
    }
    return lift(arr);
  }
  @:from static public function fromHeaderIdCtrMap(self:haxe.ds.Map<{ toHeaderId : Void -> HeaderId } ,String>){
    var arr = [];
    for( key => val in self){
    arr.push(tuple2(key.toHeaderId(),val));
    }
    return lift(arr);
  }
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
  public function toCluster(){
    return this;
  }
  public function concat(rhs:Headers){
    return lift(this.concat(rhs.toCluster()));
  }
  //public function get()
}