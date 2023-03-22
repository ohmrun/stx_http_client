package stx.http.client;

using stx.Test;
using stx.Bake;
class Test{
  static macro function boot(){
    final log = __.log().global.with_logic(
      l -> l.or(l.pack("**/*"))
    );
    final bake = __.bake();
    trace(bake);
    return macro {};
  }
  static public function main(){
    boot();

    __.test().run([],[]);
  }
}