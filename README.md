# stx_http_client

```haxe
using stx.http.Client;
function main(){
  //returns an instance of `eu.ohmrun.fletcher.Scenario`
  final headers = Headers.unit();
  final agent   = 'me';
  final url     = "https://example.com";
  final method  = GET;
  final fletcher = __.client().fetch(options_ctr -> options_ctr.Make(headers,agent),url,Some('body'),method)
        fletcher.environment(
          (result:stx.RemotingPayload<Nada>) -> {
            //stx.Equity<RemotingContext,Nada,HttpClientFailure>
            //...
            result.asset.response;//Option<Response>
            //Can use `result.value` to place decoded values from `result.asset`
          }
        ).submit();
}
``` 
### Remoting Payload  
```haxe
typedef RemotingPayload<T> = stx.nano.Equity<RemotingContext,T,HttpClientFailure>
```
### Request  
```haxe
@:publicFields @:structInit class RequestCls{
  
  final method                : HttpMethod;
  final url                   : String;
  
  final headers               : Headers;
  
  @:optional final body       : Content;  
}
```
### Response
```haxe
typedef ResponseDef = {
  final code        : HttpStatusCode;
  final body        : Emiter<Bytes,HttpClientFailure>;// see https://github.com/ohmrun/stx_coroutine

  final headers     : Headers;
  final messages    : Cluster<ResponseMessage>;  
}
```

## Tasks 

### hello
```
echo "hello"
```

### wm.server

```
cd $PRJ_DIR/vendor/wiremock && java -jar wiremock.jar --enable-stub-cors
```

### wm.reload

```
 xh  POST http://localhost:8080/__admin/mappings/reset  

```

### hello world

```
echo hello
```