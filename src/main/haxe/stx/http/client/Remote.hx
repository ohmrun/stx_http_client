package stx.http.client;

typedef RemoteDef<T,E> = Pledge<RemotingContext<T,E>,Either<HttpClientFailure,E>>;

abstract Remote<T,E>(RemoteDef<T,E>) from RemoteDef<T,E> to RemoteDef<T,E>{
  static public var _(default,never) = RemoteLift;
  public function new(self) this = self;
  static public function lift<T,E>(self:RemoteDef<T,E>):Remote<T,E> return new Remote(self);

  public function prj():RemoteDef<T,E> return this;
  private var self(get,never):Remote<T,E>;
  private function get_self():Remote<T,E> return lift(this);
}
class RemoteLift extends Clazz{
  static public function make(){
    return new RemoteLift();
  }
  //public function fromRemotingContext<T,E>
  static public function flat_map<T,Ti,E>(self:RemoteDef<T,E>,fn:T->Remote<Ti,E>):Remote<Ti,E>{
    return self.flat_map(
      (ctx:RemotingContext<T,E>) -> ctx.map(fn).map(
        (nxt:RemotingContext<Remote<Ti,E>>) -> nxt.res().fold(
          ok -> ok.map(
            
          )
        )
      )
    )
  }
}