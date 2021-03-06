package stx.http.client;

class Module extends Clazz{
  public function extractor<E>():RemotingContextExtractor<Dynamic,E>{
    return RemotingContextExtractor.unit();
  }
  public function ctx<T>(ext,req,res){
    return new stx.http.client.RemotingContextCtr().pull0(ext,req,res);
  }
  #if hxnodejs
  public function fetch<T,E>(req:Request,?extractor:RemotingContextExtractor<T,E>):Pledge<RemotingContext<T,E>,HttpClientFailure>{
    __.log().debug(_ -> _.show(req));
    __.option(extractor).def(
      () -> extractor = RemotingContextExtractor.unitI()
    );
    var freq = req.toNodeFetchRequest();
    return node_fetch.Fetch.call(freq).toPledge().flat_map(
      (res:node_fetch.Response) -> new RemotingContextCtr().pull0(extractor,req,res)
    );
  }
  #elseif js
  public function fetch<T,E>(req:Request,?extractor:RemotingContextExtractor<T,E>):Pledge<RemotingContext<T,E>,HttpClientFailure>{
    __.log().debug(_ -> _.show(req));
    __.option(extractor).def(
      () -> extractor = RemotingContextExtractor.unitI()
    );
    return (js.Lib.global.fetch(req.toJsRequest()):js.lib.Promise<js.html.Response>)
      .then(
        (x) -> {
          //trace(x);
          return x;
        }
      ).toPledge()
       .errate(
        (e) -> {
          //trace(e);
          return e;
        }
       ).flat_map(
        (res:js.html.Response) -> {
          //trace(res);
          return new RemotingContextCtr().pull0(extractor,req,res);
        }
      );
  }
  #else
  public function fetch<T,E>(req:Request,?extractor:RemotingContextExtractor<T,E>):Pledge<RemotingContext<T,E>,HttpClientFailure>{
    __.log().debug(_ -> _.pure(req));
    __.option(extractor).def(
      () -> extractor = RemotingContextExtractor.unitI()
    );
    return stx.http.client.fetch.term.Haxe.fetch(req).adjust(
      (res:Response<Res<Dynamic,HttpClientFailure>>) -> {
        return new RemotingContextCtr().pull(extractor,req,res);
      }
    );
  }
  #end
}