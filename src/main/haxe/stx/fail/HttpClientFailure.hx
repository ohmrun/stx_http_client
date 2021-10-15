package stx.fail;

//,?request:Request,?response:Response<Option<String>>
enum HttpClientFailure{
  E_HttpClient_Error(string:String);  
  E_HttpClient_CantDecode(type:String);
  E_HttpClient_PreflightUnautheticated;
  E_HttpClient_Unknown(x:Dynamic);
}