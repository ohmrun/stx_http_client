package stx.http.client;

class Module extends Clazz{
  public function ctr(){
    return new Ctr();
  }
  #if (!macro)
    #if (nodejs)
      public function fetch():Client{
        __.log().debug('nodejs');
        return Scenario.lift(stx.http.client.fetch.term.NodeJs.unit());
      }
    #elseif js
      public function fetch():Client{
        __.log().debug('js');
        return Scenario.lift(stx.http.client.fetch.term.Js.unit());
      }
    #else
      public function fetch():Client{
        __.log().debug('haxe');
        return Scenario.lift(stx.http.client.fetch.term.Haxe.unit());
      }
    #end    
  #else
    public function fetch():Client{
      return Scenario.lift(stx.http.client.fetch.term.Haxe.unit());
    }
  #end
}
private class Ctr extends Clazz{
  public function RemotingPayload(){
    return new RemotingPayloadCtr();
  }
  public function Request(){
    return new RequestCtr();
  }
}