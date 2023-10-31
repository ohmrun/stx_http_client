
package stx.http.client;

enum abstract HeaderId(String){
  // var ContentType                = "Content-Type";
  // var Accept                     = "Accept";
  var CONNECTION                    = "connection";
  // var Authorization             = "Authorization";
  // var Origin                    = "Origin";
  // var AccessControlAllowOrigin  = "Access-Control-Allow-Origin"; 

  var REFERER                          = 'referer';
  var HOST                             = 'host';

  var SET_COOKIE                       = 'set-cookie';
  var COOKIE                           = 'cookie';

  var CONTENT_TYPE                     = 'content-type';
  var CONTENT_LENGTH                   = 'content-length';
  var CONTENT_DISPOSITION              = 'content-disposition';
  var CONTENT_RANGE                    = 'content-range';

  var ACCEPT                           = 'accept';
  var ACCEPT_ENCODING                  = 'accept-encoding';

  var TRANSFER_ENCODING                = 'transfer-encoding';
  
  var RANGE                            = 'range';

  var LOCATION                         = 'location';
  var AUTHORIZATION                    = 'authorization';

  var ORIGIN                           = 'origin';
  var VARY                             = 'vary';

  var CACHE_CONTROL                    = 'cache-control';
  var EXPIRES                          = 'expires';

  var ACCESS_CONTROL_REQUEST_METHOD    = 'access-control-request-method';
  var ACCESS_CONTROL_REQUEST_HEADERS   = 'access-control-request-headers';
  var ACCESS_CONTROL_ALLOW_ORIGIN      = 'access-control-allow-origin';
  var ACCESS_CONTROL_ALLOW_CREDENTIALS = 'access-control-allow-credentials';
  var ACCESS_CONTROL_EXPOSE_HEADERS    = 'access-control-expose-headers';
  var ACCESS_CONTROL_MAX_AGE           = 'access-control-max-age';
  var ACCESS_CONTROL_ALLOW_METHODS     = 'access-control-allow-methods';
  var ACCESS_CONTROL_ALLOW_HEADERS     = 'access-control-allow-headers';
  
  var USER_AGENT                       = 'user-agent';
  public function toString(){
    return this;
  }
  private function new(self){
    this = self;
  }
  static public function fromString(self:String):HeaderId{
    return new HeaderId(self);
  }
}