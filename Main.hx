using stx.http.Client;

using stx.Pico;
using stx.Nano;

class Main{
  static public function main(){
    trace('main');
    var url = "https://jsonplaceholder.typicode.com/todos";
    var req = Request.make(GET,url);
    var ext = RemotingContextExtractor.unit();
    
    __.client().fetch(req).handle(__.trace());
  }
}