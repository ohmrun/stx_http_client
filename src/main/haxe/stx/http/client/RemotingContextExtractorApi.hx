package stx.http.client;

interface RemotingContextExtractorApi<T,E>{
  public final value : RemotingContextValueExtractorApi<T,E>;
  public final error : RemotingContextErrorExtractorApi<T,E>;  
}