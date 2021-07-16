package stx.fail;

enum HttpClientFailure{
  E_HttpClient_Error(string:String);  
  E_HttpClient_CantDecode(type:String);
  E_HttpClient_PreflightUnautheticated;
}