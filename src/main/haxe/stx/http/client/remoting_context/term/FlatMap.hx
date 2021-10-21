package stx.http.client.remoting_context.term;

class FlatMap<P,Pi,E> extends RemotingContextAbs<Pi,E>{
  var delegate       : RemotingContext<P,E>;  
  public final inner : P-> RemotingContext<Pi,E>;

  public function new(delegate,inner){
    this.delegate = delegate;
    this.inner    = inner;
  }
  private function other():Option<RemotingContext<Pi,E>>{
    return delegate.value.flat_map(x -> inner(x));
  }
  public function get_value():Option<Pi>{
    return other().flat_map(x -> x.value);
  }
  public function get_error():Defect<E>{
    return delegate.error.concat(other().map(x -> x.error).defv(Defect.unit()));
  }
}