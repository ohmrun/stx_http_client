using stx.http.Client;

using stx.Pico;
using stx.Nano;

class Main{
  static public function main(){
    var url = "https://jsonplaceholder.typicode.com/todos";
    var req = Request.make(GET,url);
    var ext : RemotingContextExtractorDef<Dynamic,Dynamic> =({
      value : ({
        extract : (dyn:Dynamic) -> (__.option(__.success((dyn:Dyn))):Option<Outcome<Dynamic,Defect<Dynamic>>>)
      }:RemotingContextValueExtractorDef<Dynamic,Dynamic>),
      error : ({
        extract : (res:Response,val:Option<Dynamic>) -> (Defect.unit():Defect<Dynamic>)
      }:RemotingContextErrorExtractorDef<Dynamic,Dynamic>)
    }:RemotingContextExtractorDef<Dynamic,Dynamic>);
    
    __.client().fetch(ext,req).handle(__.trace());
  }
}