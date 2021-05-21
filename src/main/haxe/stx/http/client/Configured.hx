package stx.http.client;

class Configured<C:FetchModelConfigDef> extends Clazz{
  private final config : C; 

  public function new(config){
    super();
    this.config = config;
  }

  
}