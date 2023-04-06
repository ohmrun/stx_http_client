package stx.http.client;

using stx.Test;
using Bake;
class Test{
  static macro function boot(){
    final log = __.log().global.with_logic(
      l -> l.or(l.pack("**/*"))
    );
    final bake = Bake.pop();
    trace(bake);
    return macro {};
  }
  static public function main(){
    boot();

    __.test().run([],[]);
  }
}