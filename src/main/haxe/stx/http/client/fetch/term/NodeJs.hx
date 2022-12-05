package stx.http.client.fetch.term;

#if nodejs
  class NodeJs implements ClientApi extends StxMemberCls{
    public function get_stx_tag(){
      return throw 'unimplemented';
    }
    static public function unit(){
      return new NodeJs();
    }
    public function defer(state:RemotingPayload<Noise>,cont:Terminal<RemotingPayload<Noise>,Noise>):Work{
      __.log().debug('request');
      final request = state.asset.request.toNodeFetchRequest();
      final result  = NodeFetch.default_(request);
      return cont.receive(
        cont.later(
          Pledge.fromJsPromise(result)
          .fold(
            ok -> 
              state.mapi(
                context -> RemotingContext.make(
                  context.request,
                  Some(Response.fromNodeFetchResponse(ok))
                )
              ),
            no -> 
            {
              return state.defect(
                switch(no.data){
                  case Some(INTERNAL(x)) : __.fault().decline(INTERNAL(x));
                  case Some(EXTERNAL(x)) : no.errate(E_HttpClient_Unknown);
                  case None              : __.fault().explain(_ -> _.e_undefined());
                } 
              );
            }            
          ).map(
            x -> {
              __.log().debug('$x');
              return __.success(x);
          })
        )
      );
    }
  }
#end