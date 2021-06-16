package stx.http.client;

interface HeadersCtrApi{
  public function unit():Headers;
  public function json():Headers;
  public function conf(data:Cluster<Couple<HeaderId,String>>):Headers;
}