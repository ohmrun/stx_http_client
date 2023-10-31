package stx.http.client.fetch.term;


import tink.Chunk in TinkChunk;
import tink.http.*;
import tink.http.Client;
import tink.http.Header;
import tink.http.Request;
import tink.http.Fetch;
import tink.streams.Stream;

using eu.ohmrun.Fletcher;
using eu.ohmrun.fletcher.Core;

using stx.Nano;
using stx.Assert;

using stx.Coroutine;
using stx.coroutine.Core;

class Tink implements ClientApi extends FletcherCls<Equity<RemotingContext,Nada,HttpClientFailure>,Equity<RemotingContext,Nada,HttpClientFailure>, Nada>{
  static public function unit(){
    return new Tink();
  }
  public final delegate : ClientObject;
  public function new(?delegate){
    super();
    this.delegate = __.option(delegate).def(() -> @:privateAccess Fetch.getClient(Default));
  }
  public function defer(state:RemotingPayload<Nada>,cont:Terminal<RemotingPayload<Nada>,Nada>):Work{
    final req_header = new OutgoingRequestHeader(
      state.asset.request.method.toTinkMethod(),
      state.asset.request.url,
      null,
      state.asset.request.headers.map(__.detuple((x,y) -> new HeaderField(cast x,y))).prj()
    );
    __.assert().that().exists(state?.asset);
    __.assert().that().exists(state?.asset.request);
    final request = new OutgoingRequest(
      req_header,
      __.option(state.asset.request.body).map(x -> x.toIdealSource()).defv(tink.io.Source.EMPTY)
    );
    final trigger           = Signal.trigger(); 
    final client            = delegate;
    trace('here');
    final response          = 
      client.request(request).map(
        (r) -> {
          return switch(__.tracer()(r)){
            case Success(ok) : __.accept(ok);
            case Failure(no) : __.reject(f -> f.of(E_HttpClient_Error('$no')));
          }
        }
      ).toPledge();
    final emiter    = __.hold(Held.Pause(
      () -> {
        return __.hold(Held.Guard(response.fold(
            function(ok){
              trace(ok);
              final future_step = ok.body.chunked().next();
              final emiter      = future_step.flatMap(
                function rec(step){
                  return switch(step){
                    case Link(t_chunk, next) : 
                      final bytes = Bytes.alloc(Iter.fromIterator(t_chunk.iterator()).size());
                      var idx     = 0;
                      for(byte in t_chunk){
                        bytes.set(idx,byte);
                        idx++;
                      }
                      if(next.depleted || bytes.length == 0){
                        __.emit(bytes,__.stop());
                      }else{
                        __.emit(bytes,__.hold(Held.Guard(next.next().flatMap(rec))));
                      }
                        //__.stop();      
                    case Fail(e) : 
                      __.exit(__.fault().of(E_HttpClient_Error('$e')));
                    case End : 
                      __.stop();
                  }
                }
              );
              return __.hold(Held.Guard(emiter));
            },
            no -> __.exit(no)
        )));
      }
    ));
    $type(emiter);
    final together = response.map(
      response -> {
        return RemotingContext.make(
          state.asset.request,
          Response.make(
            response.header.statusCode,
            emiter,
            @:privateAccess response.header.fields.map(x -> tuple2(cast x.name,x.value)).toCluster()
          )
        );       
      },
    );
    return cont.receive(
        cont.later(
          together.fold(
            x-> x,
            e -> RemotingContext.make(
              state.asset.request,Response.make(
                500,__.term(e)
              )
            )
          ).map(x -> __.success(RemotingPayload.make(x,Nada)))
        )
    );
    //return cont.receive(cont.value(state));
  }
}