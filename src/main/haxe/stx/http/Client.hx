package stx.http;

typedef Configured<T:FetchConfigDef>            = stx.http.client.Configured<T>;
typedef Content<T>                              = stx.http.client.Content<T>;
typedef Fetch<C:FetchConfigDef>                 = stx.http.client.Fetch<C>;
typedef FetchConfigDef                          = stx.http.client.FetchConfigDef;
typedef Headers                                 = stx.http.client.Headers;
typedef HeadersCtr                              = stx.http.client.HeadersCtr;
typedef HeadersCtrApi                           = stx.http.client.HeadersCtrApi;
typedef RemotingContext<T,E>                    = stx.http.client.RemotingContext<T,E>;
typedef RemotingContextDef<T,E>                 = stx.http.client.RemotingContext.RemotingContextDef<T,E>;
typedef RemotingContextAbs<T,E>                 = stx.http.client.RemotingContext.RemotingContextAbs<T,E>;
typedef RemotingContextCls<T,E>                 = stx.http.client.RemotingContext.RemotingContextCls<T,E>;
typedef RemotingContextApi<T,E>                 = stx.http.client.RemotingContext.RemotingContextApi<T,E>;
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
typedef HttpClientFailure                       = stx.fail.HttpClientFailure;
typedef HeaderId                                = stx.http.client.HeaderId;
typedef HttpMethod                              = stx.http.client.HttpMethod;

class ClientAccess{
  static public function client(wildcard:Wildcard){
    return new stx.http.client.Module();
  }
}

interface ClientApi<R,E> extends FletcherApi<Request,Response>{
  
}