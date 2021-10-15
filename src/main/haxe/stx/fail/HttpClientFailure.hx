package stx.fail;

enum HttpClientFailure{
  E_HttpClient_Error(string:String,?request:Request,?response:Response<Option<String>>);  
  E_HttpClient_CantDecode(type:String);
  E_HttpClient_PreflightUnautheticated;
}