package stx.http.client;

typedef FetchConfigDef = { 
  public final base                 : String;
  public final options              : RequestOptions;
}
@:forward abstract FetchConfig(FetchConfigDef) from FetchConfigDef to FetchConfigDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:FetchConfigDef):FetchConfig return new FetchConfig(self);
  @:noUsing static public function make(base:String,options:RequestOptions):FetchConfig {
    return lift({base : base, options:options});
  }

  public function prj():FetchConfigDef return this;
  private var self(get,never):FetchConfig;
  private function get_self():FetchConfig return lift(this);

  public function copy(?base:String,?options:RequestOptions){
    return lift({
      base    : __.option(base).defv(this.base),
      options : __.option(options).defv(this.options)
    });
  }
  public function with_options(options:RequestOptions){
    return copy(null,options);
  }
}