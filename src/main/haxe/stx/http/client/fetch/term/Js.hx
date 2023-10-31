package stx.http.client.fetch.term;

#if (!nodejs && js)
class Js implements ClientApi extends FletcherCls<RemotingPayload<Nada>,RemotingPayload<Nada>,Nada>{
    static public function unit(){
      return new Js();
    }
    public function defer(state:RemotingPayload<Nada>,cont:Terminal<RemotingPayload<Nada>,Nada>):Work{
      final request = state.asset.request.toJsRequest();
      return cont.receive(
        cont.later(
          js.Browser.window.fetch(request).toPledge().fold(
            ok -> state.mapi(
              context -> RemotingContext.make(
               context.request,
               Some(Response.fromJsResponse(ok))
              )
            ),
            no -> state.errata(
              _ -> 
                Refuse.make(
                  Some(EXTERNAL(no.usher(
                    opt -> 
                        opt.fold(
                          E_HttpClient_Unknown,
                          () -> E_HttpClient_Unknown(null)
                        )
                  ))),
                  None,
                  Some(__.here())
                )
            ) 
          ).map(__.success)
        )
      );
    }
  }
#end