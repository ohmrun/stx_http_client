package stx.http.client;

class Module extends Clazz{
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
      // public function fetch():Client{
      //   __.log().debug('haxe');
      //   return Scenario.lift(stx.http.client.fetch.term.Haxe.unit());
      // }
      public function fetch():Client{
        __.log().debug('haxe');
        return Scenario.lift(stx.http.client.fetch.term.Tink.unit());
      }
    #end    
  #else
    public function fetch():Client{
      return Scenario.lift(stx.http.client.fetch.term.Haxe.unit());
    }
  #end
  @:isVar public var RemotingPayload(get,null):RemotingPayloadCtr;
  private function get_RemotingPayload():RemotingPayloadCtr{
    return __.option(this.RemotingPayload).def(() -> this.RemotingPayload = new RemotingPayloadCtr());
  }
  @:isVar public var Request(get,null):RequestCtr;
  private function get_Request():RequestCtr{
    return __.option(this.Request).def(() -> this.Request = new RequestCtr());
  }
  @:isVar public var FetchConfig(get,null):FetchConfigCtr;
  private function get_FetchConfig():FetchConfigCtr{
    return __.option(this.FetchConfig).def(() -> this.FetchConfig = new FetchConfigCtr());
  }
  @:isVar public var RemotingContext(get,null):RemotingContextCtr;
  private function get_RemotingContext():RemotingContextCtr{
    return __.option(this.RemotingContext).def(() -> this.RemotingContext = new RemotingContextCtr());
  }
  @:isVar public var RequestOptions(get,null):RequestOptionsCtr;
  private function get_RequestOptions():RequestOptionsCtr{
    return __.option(this.RequestOptions).def(() -> this.RequestOptions = new RequestOptionsCtr());
  }
}