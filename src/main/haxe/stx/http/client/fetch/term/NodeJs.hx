package stx.http.client.fetch.term;

class NodeJs implements ClientApi extends StxMemberCls{
  public function get_stx_tag(){
    return throw 'unimplemented';
  }
  static public function unit(){
    return new Js();
  }
  public function defer(state:RemotingContext,cont:Terminal<RemotingContext,Noise>):Work{
    final request = state.asset.toNodeFetchRequest();
    return cont.receive(
      cont.later(
        NodeFetch.default_(request).toPledge().fold(
          ok -> state.map(_ -> Response.fromNodeFetchResponse(ok)),
          no -> state.errata( 
            _ -> 
            Error.make(
              no.usher(
                opt -> 
                    opt.fold(
                      E_HttpClient_Unknown,
                      () -> E_HttpClient_Unknown(null)
                    )
              )
            )
          ) 
        ).map(__.success)
      )
    );
  }
}