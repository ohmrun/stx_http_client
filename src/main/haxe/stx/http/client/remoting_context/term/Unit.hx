package stx.http.client.remoting_context.term;

class Unit<P,E> extends RemotingContextAbs<P,E>{
  var _value : Option<P>;
  var _error : Defect<E>;

  public function new(_value,_error){
    this._value = _value;
    this._error = _error;
  }
  public function get_value(){
    return _value;
  }
  public function get_error(){
    return _error;
  }
}