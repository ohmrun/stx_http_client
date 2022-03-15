package stx.http.client;

class Module extends Clazz{
  public function ctr(){
    return new Ctr();
  }
  #if (!macro)
    #if (hxnodejs)
      public function fetch():Client{
        return Sequent.lift(stx.http.client.fetch.term.NodeJs.unit());
      }
    #elseif js
      public function fetch():Client{
        return Sequent.lift(stx.http.client.fetch.term.Js.unit());
      }
    #else
      public function fetch():Client{
        return Sequent.lift(stx.http.client.fetch.term.Haxe.unit());
      }
    #end    
  #else
    public function fetch():Client{
      return Sequent.lift(stx.http.client.fetch.term.Haxe.unit());
    }
  #end
}
private class Ctr extends Clazz{
  public function RemotingContext(){
    return new RemotingContextCtr();
  }
  public function Request(){
    return new RequestCtr();
  }
}