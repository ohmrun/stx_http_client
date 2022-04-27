package stx.http.client.fetch.term;

#if hxnodejs
  class NodeJs implements ClientApi extends StxMemberCls{
    public function get_stx_tag(){
      return throw 'unimplemented';
    }
    static public function unit(){
      return new NodeJs();
    }
    public function defer(state:RemotingPayload<Noise>,cont:Terminal<RemotingPayload<Noise>,Noise>):Work{
      final request = state.asset.request.toNodeFetchRequest();
      return cont.receive(
        cont.later(
          Pledge.fromJsPromise(NodeFetch.default_(request)).fold(
            ok -> 
              state.mapi(
                context -> RemotingContext.make(
                  context.request,
                  Some(Response.fromNodeFetchResponse(ok))
                )
              ),
            no -> state.defect( 
              no.errate(E_HttpClient_Unknown)
            ) 
          ).map(__.success)
        )
      );
    }
  }
#end