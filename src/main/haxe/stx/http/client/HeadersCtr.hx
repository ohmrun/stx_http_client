package stx.http.client;

class HeadersCtr extends Clazz implements HeadersCtrApi{
  public function unit():Headers{
    var headers = new Headers(  
      [
        new Pair(HeaderId.Accept,"*/*"),
        new Pair(HeaderId.Connection,"keep-alive")
      ]
    );
    return headers;
  }
  public function json():Headers{
    return unit().snoc(new Pair(HeaderId.ContentType,"application/json"));
  }
  public function conf(data:Array<Couple<HeaderId,String>>):Headers{
    var headers = unit();
    for(v in data){
      headers.push(new Pair(v.fst(),v.snd()));
    }
    return headers;
  }
}