package stx.http.client.fetch.term;

#if (!hxnodejs)
  class Js implements ClientApi extends StxMemberCls{
    static public function unit(){
      return new Js();
    }
    public function defer(state:RemotingContext,cont:Terminal<RemotingContext,Noise>):Work{
      final request = state.asset.toJsRequest();
      return cont.receive(
        cont.later(
          js.Browser.window.fetch(request).toPledge().fold(
            ok -> state.map(_ -> Response.fromJsResponse(ok)),
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
    public function get_stx_tag(){
      return throw 'unimplemented';
    }
  }
#end