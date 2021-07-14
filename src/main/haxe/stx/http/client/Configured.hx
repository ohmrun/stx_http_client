package stx.http.client;

class Configured<C:FetchConfigDef> extends Clazz{
  private final config : C; 

  public function new(config){
    super();
    this.config = config;
  } 
}