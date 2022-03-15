
package stx.http;

typedef HttpClientFailure                       = stx.fail.HttpClientFailure; 
typedef Configured<T:FetchConfigDef>            = stx.http.client.Configured<T>;
typedef Content                                 = stx.http.client.Content;
typedef Fetch<C:FetchConfigDef>                 = stx.http.client.Fetch<C>;
typedef FetchConfigDef                          = stx.http.client.FetchConfigDef;
typedef Headers                                 = stx.http.client.Headers;
typedef HeadersCtr                              = stx.http.client.HeadersCtr;
typedef HeadersCtrApi                           = stx.http.client.HeadersCtrApi;
typedef RemotingContext                         = stx.http.client.RemotingContext;
typedef RemotingContextDef                      = stx.http.client.RemotingContext.RemotingContextDef;
typedef RemotingContextCls                      = stx.http.client.RemotingContext.RemotingContextCls;
typedef RemotingContextApi                      = stx.http.client.RemotingContext.RemotingContextApi;
typedef RequestCtr                              = stx.http.client.RequestCtr;
typedef Request                                 = stx.http.client.Request;
typedef RequestCls                              = stx.http.client.Request.RequestCls;
typedef RequestOptions                          = stx.http.client.RequestOptions;
typedef RequestOptionsCtr                       = stx.http.client.RequestOptionsCtr;
typedef RequestOptionsCtrApi                    = stx.http.client.RequestOptionsCtrApi;
typedef Response                                = stx.http.client.Response;
typedef ResponseMessage                         = stx.http.client.ResponseMessage;
typedef ResponseMessageDef                      = stx.http.client.ResponseMessage.ResponseMessageDef;
typedef HeaderId                                = stx.http.client.HeaderId;
typedef HttpMethod                              = stx.http.client.HttpMethod;

class ClientAccess{
  static public function client(wildcard:Wildcard){
    return new stx.http.client.Module();
  }
}

typedef ClientApi = SequentDef<Request,Response,HttpClientFailure>;
typedef Client    = Sequent<Request,Response,HttpClientFailure>;