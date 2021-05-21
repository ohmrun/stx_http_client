package stx.http.client;

class HeadersCtr extends Clazz implements HeadersCtrApi{
  public function unit():Headers{
    var headers = new Headers(  
      [
        tuple2(HeaderId.Accept,"*/*"),
        tuple2(HeaderId.Connection,"keep-alive")
      ]
    );
    return headers;
  }
  public function json():Headers{
    return unit().snoc(tuple2(HeaderId.ContentType,"application/json"));
  }
  public function conf(data:Array<Couple<HeaderId,String>>):Headers{
    var headers = unit();
    for(v in data){
      headers.push(tuple2(v.fst(),v.snd()));
    }
    return headers;
  }
}