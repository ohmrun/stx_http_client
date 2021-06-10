package stx.http.client.fetch.term;

class Haxe extends haxe.http.Http{
  public function fetch<T,E>(extractor:RemotingContextExtractorDef<T,E>,req:Request):Pledge<RemotingContext<T,E>,StxHttpClientFailure>{
    return null;
  }
  public function new(url:String){
    super(url);
  }
  public function onError(error){

  }
  public function onStatus(status){

  }
  public function 
}