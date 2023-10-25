package stx.http.client;

using stx.Nano;
using stx.Test;
using stx.Log;

class Test{
  static macro function boot(){
    __.logger().global().configure(
          logger -> logger.with_logic(
            logic -> logic.or(
              logic.tags([])
            )
          )
        );
    return macro {};
  }
  static public function main(){
    __.test().run([],[]);
  }
}