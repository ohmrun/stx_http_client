package stx.failure;

enum StxHttpClientFailure{
  E_HttpClient_Error(string:String);  
  E_HttpClient_CantDecode(type:String);
  E_HttpClient_PreflightUnautheticated;
}