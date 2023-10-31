package stx.http.client;

class HeadersCtr extends Clazz implements HeadersCtrApi{
  public function unit():Headers{
    var headers = new Headers(  
      [
        tuple2(HeaderId.ACCEPT,"*/*"),
        tuple2(HeaderId.CONNECTION,"keep-alive")
      ]
    );
    return headers;
  }
  public function json():Headers{
    return unit().snoc(tuple2(HeaderId.CONTENT_TYPE,"application/json"));
  }
  public function conf(data:Cluster<Couple<HeaderId,String>>):Headers{
    var headers = unit();
    for(v in data){
      headers = headers.cons(tuple2(v.fst(),v.snd()));
    }
    return headers;
  }
}