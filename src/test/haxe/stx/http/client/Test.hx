package stx.http.client;

import stx.http.client.fetch.term.Tink;
using stx.Nano;
using stx.Test;
using stx.Log;
using stx.http.Client;
using eu.ohmrun.Fletcher;

class Test extends TestCase{
  static function init(){
    final loop = tink.RunLoop.current;
          loop.onError = function(e, t, w, stack){
            trace(w);
            trace(stack);
            throw e;
          }
          
    __.logger().global().configure(
      logger -> logger.with_logic(
        logic -> logic.or(
          logic.tags(['stx/stream/scheduler'])
        )
      )
    );
  }
  static macro function boot(){
    init();
    return macro {};
  }
  static public function main(){
    init();
    __.test().run([new Test()],[]);
  }
  @stx.test.async
  public function test(async:Async){
    final config = __.client().FetchConfig.Make(
      'http://localhost:8080',
      __.client().RequestOptions.Make(Headers.unit())
    );
    final request = __.client().Request.Make(config,GET,'minions/f',Headers.unit());
    final payload = __.client().RemotingPayload.Make(request);

    Scenario.lift(stx.http.client.fetch.term.Tink.unit()).provide(payload)
      .environment(
        (x) -> {
          trace('done');
          trace(x.asset.response);
          for(res in x.asset.response){
            res.body.derive(x -> Cluster.pure(x),(x,y) -> x.concat(y),[].imm()).complete(
              x -> {
                trace(x);
                async.done();    
              }
            ).submit();
          }
          if(!x.asset.response.is_defined()){
            //fail('no body');
            async.done();
          }
          
        }
      ).submit();
  }
  //function test_simple()
}