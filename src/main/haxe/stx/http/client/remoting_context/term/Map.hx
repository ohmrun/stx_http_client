package stx.http.client.remoting_context.term;

class Map<P,Pi,E> extends FlatMap<P,Pi,E>{
  public function new(delegate,fn:P->Pi){
    super(
      delegate,
      (p:P) -> new Unit(fn(p),[])
    ); 
  }
}
