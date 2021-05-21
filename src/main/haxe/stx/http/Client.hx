package stx.http;

typedef Configured<T:FetchModelConfigDef>       = stx.http.client.Configured<T>;
typedef Content<T>                              = stx.http.client.Content<T>;
typedef Fetch                                   = stx.http.client.Fetch;
typedef FetchModelConfigDef                     = stx.http.client.FetchModelConfigDef;
typedef Headers                                 = stx.http.client.Headers;
typedef HeadersCtr                              = stx.http.client.HeadersCtr;
typedef HeadersCtrApi                           = stx.http.client.HeadersCtrApi;
typedef RemotingContext<T,E>                    = stx.http.client.RemotingContext<T,E>;
typedef RemotingContextCtr                      = stx.http.client.RemotingContextCtr;
typedef RequestCtr                              = stx.http.client.RequestCtr;
typedef Request                                 = stx.http.client.Request;
typedef RemotingContextExtractorDef<T,E>        = stx.http.client.RemotingContextExtractorDef<T,E>;
typedef RemotingContextExtractor<T,E>           = stx.http.client.RemotingContextExtractor<T,E>;
typedef RemotingContextValueExtractorDef<T,E>   = stx.http.client.RemotingContextValueExtractorDef<T,E>;
typedef RemotingContextErrorExtractorDef<T,E>   = stx.http.client.RemotingContextErrorExtractorDef<T,E>;
typedef RequestCls                              = stx.http.client.Request.RequestCls;
typedef RequestOptions                          = stx.http.client.RequestOptions;
typedef RequestOptionsCtr                       = stx.http.client.RequestOptionsCtr;
typedef RequestOptionsCtrApi                    = stx.http.client.RequestOptionsCtrApi;
typedef Response<T>                             = stx.http.client.Response<T>;
typedef ResponseMessage                         = stx.http.client.ResponseMessage;
typedef ResponseMessageDef                      = stx.http.client.ResponseMessage.ResponseMessageDef;


class Client{
  static public function client(wildcard:Wildcard){
    return new stx.http.client.Module();
  }
}