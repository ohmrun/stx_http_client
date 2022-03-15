package stx.http.client.fetch.term;

#if hxnodejs
  class NodeJs implements ClientApi extends StxMemberCls{
    public function get_stx_tag(){
      return throw 'unimplemented';
    }
    static public function unit(){
      return new NodeJs();
    }
    public function defer(state:RemotingContext,cont:Terminal<RemotingContext,Noise>):Work{
      final request = state.asset.toNodeFetchRequest();
      return cont.receive(
        cont.later(
          Pledge.fromJsPromise(NodeFetch.default_(request)).fold(
            ok -> state.relate(Response.fromNodeFetchResponse(ok)),
            no -> state.defect( 
              [
                no.fold(
                  e   -> E_HttpClient_Unknown(e),
                  f   -> E_HttpClient_Unknown(f),
                  ()  -> E_HttpClient_Unknown(null)
                )
              ]
            ) 
          ).map(__.success)
        )
      );
    }
  }
#end