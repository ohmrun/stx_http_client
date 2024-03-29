package stx.http.client;

typedef HeadersDef = Cluster<Tup2<HeaderId,String>>;

@:forward abstract Headers(HeadersDef) from HeadersDef{
  public function new(?self) this = __.option(self).defv(Cluster.unit());
  static public function unit():Headers{ return lift([]); }
  @:noUsing static public function lift(self:HeadersDef):Headers return new Headers(self);

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
  #if (nodejs)
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
  #if (nodejs)
    @:from static public function fromNodeFetchHeaders(self:node_fetch.Headers){
      var res = [];
      self.forEach(
        (value:String,name:String,parent:node_fetch.Headers) -> {
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
  public function set(key:HeaderId,val:String){
    return this.snoc(tuple2(key,val));
  }
  public function plug(v:Tup2<HeaderId,String>){
    return exists(v.fst()).if_else(
      () -> lift(this),
      () -> this.snoc(v)
    );
  }
  public function exists(key:HeaderId){
    return this.any(
      (x) -> x.fst() == key
    );
  }
  @:to public function toString(){
    return this.map(tp -> switch(tp) { case tuple2(x,y) : '$x => $y'; }).lfold1((n,m) -> '$m,$n');
  }
  @:arrayAccess
  public function get(i:Int){
    return this[i];
  }
}