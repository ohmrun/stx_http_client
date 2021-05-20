package stx.http.client;

typedef RemotingContextExtractorDef<T,E> = {
  public final value : RemotingContextValueExtractorDef<T,E>;
  public final error : RemotingContextErrorExtractorDef<T,E>;  
}