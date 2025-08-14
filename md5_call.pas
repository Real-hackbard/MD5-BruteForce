unit md5_call;

interface

uses Windows;

//============================================== DECLARATIONS

type
  MD5Count = array[0..1] of DWORD;
  MD5State = array[0..3] of DWORD;
  MD5Digest = array[0..15] of byte;
  MD5Buffer = array[0..63] of byte;
  MD5Context = record
    State: MD5State;
    Count: MD5Count;
    Buffer: MD5Buffer;
  end;

//============================================== IMPORTS

const MD5Dll = 'md5_recov.exe';

  procedure MD5Init(var Context:MD5Context);                                far; external MD5Dll;
  procedure MD5Update(var Context:MD5Context; Input:PChar; Length:integer); far; external MD5Dll;
  procedure MD5Final(var Context:MD5Context; var Digest:MD5Digest);         far; external MD5Dll;
   function MD5Match(D1,D2:MD5Digest):boolean;                              far; external MD5Dll;

implementation

(*===================================================*)
(*                                                   *)
(*  EXAMPLE: string -> MD5 reference                 *)
(*                                                   *)
(*    function MD5(M:string):MD5Digest;              *)
(*    var Context : MD5Context;                      *)
(*    begin                                          *)
(*      MD5Init(Context);                            *)
(*      MD5Update(Context, PChar(M), Length(M));     *)
(*      MD5Final(Context, Result);                   *)
(*    end;                                           *)
(*                                                   *)
(*===================================================*)

end.