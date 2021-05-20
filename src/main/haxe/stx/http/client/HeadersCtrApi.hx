package stx.http.client;

interface HeadersCtrApi{
  public function unit():Headers;
  public function json():Headers;
  public function conf(data:Array<Couple<HeaderId,String>>):Headers;
}