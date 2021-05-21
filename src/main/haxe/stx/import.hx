using StringTools;
import haxe.Json;


import httpstatus.*;
import tink.CoreApi;

using stx.Pico;
using stx.Nano;
using stx.Log;
using stx.Fn;

import stx.failure.StxHttpClientFailure;

#if hxnodejs
  import node_fetch.RequestInit;
#end