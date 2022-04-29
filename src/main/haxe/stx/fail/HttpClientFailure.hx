package stx.fail;

enum HttpClientFailure{
  E_HttpClient_Error(string:String);  
  E_HttpClient_CantDecode(type:String);
  E_HttpClient_PreflightUnautheticated;
  E_HttpClient_Unknown(x:Dynamic);
  E_HttpClient_NoValue;
  E_HttpClient_Context(ctx:stx.http.client.RemotingContext);
}