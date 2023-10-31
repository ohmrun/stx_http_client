package stx.http.client;

class RemotingContextCtr extends Clazz{
  static public function Make(request  : Request,response: Option<Response>){
    return RemotingContext.make(request,response);
  }
}