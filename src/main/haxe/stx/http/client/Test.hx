package stx.http.client;

using stx.Test;
using stx.Bake;
class Test{
  static macro function boot(){
    final log = __.log().global;
          log.includes.push("**/*");
    final bake = __.bake();
    trace(bake);
    return macro {};
  }
  static public function main(){
    boot();

    __.test([],[]);
  }
}