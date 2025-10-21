# MD5-BruteForce:

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![D7](https://github.com/user-attachments/assets/d479678d-4135-470a-9dba-82c1c2b7c237)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) : ![md5 pas](https://github.com/user-attachments/assets/073c6130-58b3-49b3-9d50-03c6a1f1039c) ![md5_unit pas](https://github.com/user-attachments/assets/527fbcd2-3bbd-4cd7-9e52-c99ae2dae45b)  
![Discription](https://github.com/user-attachments/assets/4a778202-1072-463a-bfa3-842226e300af) &nbsp;&nbsp;: ![MD5-BruteForce](https://github.com/user-attachments/assets/41daa33d-ee17-4cb6-90c5-d431e4a2f1cd)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) &nbsp;: ![102025](https://github.com/user-attachments/assets/62cea8cc-bd7d-49bd-b920-5590016735c0)  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)

</br>

The MD5 message-digest algorithm is a widely used hash function producing a 128-bit hash value. MD5 was designed by Ronald Rivest in 1991 to replace an earlier hash function MD4,[3] and was specified in 1992 as RFC 1321.


![MD5 Brute Force](https://github.com/user-attachments/assets/80b46a7f-abb5-485e-bef8-c2976cb72ac2)



MD5 can be used as a [checksum](https://en.wikipedia.org/wiki/Checksum) to verify [data integrity](https://en.wikipedia.org/wiki/Data_integrity) against unintentional corruption. Historically it was widely used as a [cryptographic hash function](https://en.wikipedia.org/wiki/Cryptographic_hash_function); however it has been found to suffer from extensive vulnerabilities. It remains suitable for other non-cryptographic purposes, for example for determining the partition for a particular key in a partitioned database, and may be preferred due to lower computational requirements than more recent [Secure Hash Algorithms](https://en.wikipedia.org/wiki/Secure_Hash_Algorithms).

MD5 is one in a series of message digest algorithms designed by [Professor Ronald Rivest](https://en.wikipedia.org/wiki/Ron_Rivest) of MIT (Rivest, 1992). When analytic work indicated that MD5's predecessor MD4 was likely to be insecure, Rivest designed MD5 in 1991 as a secure replacement. (Hans Dobbertin did indeed later find weaknesses in MD4.)

In 1993, Den Boer and Bosselaers gave an early, although limited, result of finding a "pseudo-collision" of the MD5 [compression function](https://en.wikipedia.org/wiki/One-way_compression_function); that is, two different initialization vectors that produce an identical digest.

In 1996, Dobbertin announced a collision of the compression function of MD5 (Dobbertin, 1996). While this was not an attack on the full MD5 hash function, it was close enough for cryptographers to recommend switching to a replacement, such as [SHA-1](https://en.wikipedia.org/wiki/SHA-1) (also compromised since) or [RIPEMD-160](https://en.wikipedia.org/wiki/RIPEMD).

The size of the hash value (128 bits) is small enough to contemplate a birthday attack. MD5CRK was a distributed project started in March 2004 to demonstrate that MD5 is practically insecure by finding a collision using a birthday attack.

MD5CRK ended shortly after 17 August 2004, when collisions for the full MD5 were announced by [Xiaoyun Wang](https://en.wikipedia.org/wiki/Xuejia_Lai), Dengguo Feng, Xuejia Lai, and Hongbo Yu. Their analytical attack was reported to take only one hour on an IBM p690 cluster.

On 1 March 2005, [Arjen Lenstra](https://en.wikipedia.org/wiki/Arjen_Lenstra), Xiaoyun Wang, and Benne de Weger demonstrated construction of two X.509 certificates with different public keys and the same MD5 hash value, a demonstrably practical collision.[8] The construction included private keys for both public keys. A few days later, [Vlastimil Klima](https://en.wikipedia.org/wiki/Vlastimil_Kl%C3%ADma) described an improved algorithm, able to construct MD5 collisions in a few hours on a single notebook computer. On 18 March 2006, Klima published an algorithm that could find a collision within one minute on a single notebook computer, using a method he calls tunneling.

Various MD5-related RFC errata have been published. In 2009, the [United States Cyber Command](https://en.wikipedia.org/wiki/United_States_Cyber_Command) used an MD5 hash value of their mission statement as a part of their official emblem.

### Pseudocode:
The MD5 hash is calculated according to this algorithm. All values are in [little-endian](https://en.wikipedia.org/wiki/Endianness).

```pascal
// : All variables are unsigned 32 bit and wrap modulo 2^32 when calculating
var int s[64], K[64]
var int i

// s specifies the per-round shift amounts
s[ 0..15] := { 7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22 }
s[16..31] := { 5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20 }
s[32..47] := { 4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23 }
s[48..63] := { 6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21 }

// Use binary integer part of the sines of integers (Radians) as constants:
for i from 0 to 63 do
    K[i] := floor(232 × abs(sin(i + 1)))
end for
// (Or just use the following precomputed table):
K[ 0.. 3] := { 0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee }
K[ 4.. 7] := { 0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501 }
K[ 8..11] := { 0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be }
K[12..15] := { 0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821 }
K[16..19] := { 0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa }
K[20..23] := { 0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8 }
K[24..27] := { 0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed }
K[28..31] := { 0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a }
K[32..35] := { 0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c }
K[36..39] := { 0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70 }
K[40..43] := { 0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05 }
K[44..47] := { 0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665 }
K[48..51] := { 0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039 }
K[52..55] := { 0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1 }
K[56..59] := { 0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1 }
K[60..63] := { 0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391 }

// Initialize variables:
var int a0 := 0x67452301   // A
var int b0 := 0xefcdab89   // B
var int c0 := 0x98badcfe   // C
var int d0 := 0x10325476   // D

// Pre-processing: adding a single 1 bit
append "1" bit to message<    
 // Notice: the input bytes are considered as bit strings,
 //  where the first bit is the most significant bit of the byte.[52]

// Pre-processing: padding with zeros
append "0" bit until message length in bits ≡ 448 (mod 512)

// Notice: the two padding steps above are implemented in a simpler way
  //  in implementations that only work with complete bytes: append 0x80
  //  and pad with 0x00 bytes so that the message length in bytes ≡ 56 (mod 64).

append original length in bits mod 264 to message

// Process the message in successive 512-bit chunks:
for each 512-bit chunk of padded message do
    break chunk into sixteen 32-bit words M[j], 0 ≤ j ≤ 15
    // Initialize hash value for this chunk:
    var int A := a0
    var int B := b0
    var int C := c0
    var int D := d0
    // Main loop:
    for i from 0 to 63 do
        var int F, g
        if 0 ≤ i ≤ 15 then
            F := (B and C) or ((not B) and D)
            g := i
        else if 16 ≤ i ≤ 31 then
            F := (D and B) or ((not D) and C)
            g := (5×i + 1) mod 16
        else if 32 ≤ i ≤ 47 then
            F := B xor C xor D
            g := (3×i + 5) mod 16
        else if 48 ≤ i ≤ 63 then
            F := C xor (B or (not D))
            g := (7×i) mod 16
        // Be wary of the below definitions of a,b,c,d
        F := F + A + K[i] + M[g]  // M[g] must be a 32-bit block
        A := D
        D := C
        C := B
        B := B + leftrotate(F, s[i])
    end for
    // Add this chunk's hash to result so far:
    a0 := a0 + A
    b0 := b0 + B
    c0 := c0 + C
    d0 := d0 + D
end for

var char digest[16] := a0 append b0 append c0 append d0 // (Output is in little-endian)
```

Instead of the formulation from the original RFC 1321 shown, the following may be used for improved efficiency (useful if assembly language is being used – otherwise, the compiler will generally optimize the above code. Since each computation is dependent on another in these formulations, this is often slower than the above method where the nand/and can be parallelised):

```pascal
( 0 ≤ i ≤ 15): F := D xor (B and (C xor D))
(16 ≤ i ≤ 31): F := C xor (D and (B xor C))
```

### MD5 Example:
```
"github" : bf215181b5140522137b3d4f6b73544a
"GITHUB" : 81219a34fa8b077e82580d87c911895e
```

### Encode:
```pascal
procedure Encode(Source,Target:pointer; Count:lgWord);
// Encode Count bytes at Source into (Count / 4) DWORDs at Target
var S : PByte;
    T : PDWORD;
    I : lgWord;
begin
  S:=Source;
  T:=Target;
  for I:=1 to Count div 4 do
    begin
      T^:=S^;
      inc(S);
      T^:=T^ or (S^ shl 8);
      inc(S);
      T^:=T^ or (S^ shl 16);
      inc(S);
      T^:=T^ or (S^ shl 24);
      inc(S);
      inc(T);
    end;
end;
```

### Decode:
```pascal
procedure Decode(Source, Target: pointer; Count: lgWord);
// Decode Count DWORDs at Source into (Count * 4) Bytes at Target
var S : PDWORD;
    T : PByte;
    I : lgWord;
begin
  S:=Source;
  T:=Target;
  for I := 1 to Count do
    begin
      T^:=S^ and $ff;
      inc(T);
      T^:=(S^ shr 8) and $ff;
      inc(T);
      T^:=(S^ shr 16) and $ff;
      inc(T);
      T^:=(S^ shr 24) and $ff;
      inc(T);
      inc(S);
    end;
end;

procedure Transform(Buffer: pointer; var State: MD5State);
// Transform State according to first 64 bytes at Buffer
var a, b, c, d : DWORD;
    Block      : MD5Block;
begin
  Encode(Buffer, @Block, 64);
  a := State[0];
  b := State[1];
  c := State[2];
  d := State[3];
  FF(a, b, c, d, Block[ 0],  7, $d76aa478);
  FF(d, a, b, c, Block[ 1], 12, $e8c7b756);
  FF(c, d, a, b, Block[ 2], 17, $242070db);
  FF(b, c, d, a, Block[ 3], 22, $c1bdceee);
  FF(a, b, c, d, Block[ 4],  7, $f57c0faf);
  FF(d, a, b, c, Block[ 5], 12, $4787c62a);
  FF(c, d, a, b, Block[ 6], 17, $a8304613);
  FF(b, c, d, a, Block[ 7], 22, $fd469501);
  FF(a, b, c, d, Block[ 8],  7, $698098d8);
  FF(d, a, b, c, Block[ 9], 12, $8b44f7af);
  FF(c, d, a, b, Block[10], 17, $ffff5bb1);
  FF(b, c, d, a, Block[11], 22, $895cd7be);
  FF(a, b, c, d, Block[12],  7, $6b901122);
  FF(d, a, b, c, Block[13], 12, $fd987193);
  FF(c, d, a, b, Block[14], 17, $a679438e);
  FF(b, c, d, a, Block[15], 22, $49b40821);
  GG(a, b, c, d, Block[ 1],  5, $f61e2562);
  GG(d, a, b, c, Block[ 6],  9, $c040b340);
  GG(c, d, a, b, Block[11], 14, $265e5a51);
  GG(b, c, d, a, Block[ 0], 20, $e9b6c7aa);
  GG(a, b, c, d, Block[ 5],  5, $d62f105d);
  GG(d, a, b, c, Block[10],  9,  $2441453);
  GG(c, d, a, b, Block[15], 14, $d8a1e681);
  GG(b, c, d, a, Block[ 4], 20, $e7d3fbc8);
  GG(a, b, c, d, Block[ 9],  5, $21e1cde6);
  GG(d, a, b, c, Block[14],  9, $c33707d6);
  GG(c, d, a, b, Block[ 3], 14, $f4d50d87);
  GG(b, c, d, a, Block[ 8], 20, $455a14ed);
  GG(a, b, c, d, Block[13],  5, $a9e3e905);
  GG(d, a, b, c, Block[ 2],  9, $fcefa3f8);
  GG(c, d, a, b, Block[ 7], 14, $676f02d9);
  GG(b, c, d, a, Block[12], 20, $8d2a4c8a);
  HH(a, b, c, d, Block[ 5],  4, $fffa3942);
  HH(d, a, b, c, Block[ 8], 11, $8771f681);
  HH(c, d, a, b, Block[11], 16, $6d9d6122);
  HH(b, c, d, a, Block[14], 23, $fde5380c);
  HH(a, b, c, d, Block[ 1],  4, $a4beea44);
  HH(d, a, b, c, Block[ 4], 11, $4bdecfa9);
  HH(c, d, a, b, Block[ 7], 16, $f6bb4b60);
  HH(b, c, d, a, Block[10], 23, $bebfbc70);
  HH(a, b, c, d, Block[13],  4, $289b7ec6);
  HH(d, a, b, c, Block[ 0], 11, $eaa127fa);
  HH(c, d, a, b, Block[ 3], 16, $d4ef3085);
  HH(b, c, d, a, Block[ 6], 23,  $4881d05);
  HH(a, b, c, d, Block[ 9],  4, $d9d4d039);
  HH(d, a, b, c, Block[12], 11, $e6db99e5);
  HH(c, d, a, b, Block[15], 16, $1fa27cf8);
  HH(b, c, d, a, Block[ 2], 23, $c4ac5665);
  II(a, b, c, d, Block[ 0],  6, $f4292244);
  II(d, a, b, c, Block[ 7], 10, $432aff97);
  II(c, d, a, b, Block[14], 15, $ab9423a7);
  II(b, c, d, a, Block[ 5], 21, $fc93a039);
  II(a, b, c, d, Block[12],  6, $655b59c3);
  II(d, a, b, c, Block[ 3], 10, $8f0ccc92);
  II(c, d, a, b, Block[10], 15, $ffeff47d);
  II(b, c, d, a, Block[ 1], 21, $85845dd1);
  II(a, b, c, d, Block[ 8],  6, $6fa87e4f);
  II(d, a, b, c, Block[15], 10, $fe2ce6e0);
  II(c, d, a, b, Block[ 6], 15, $a3014314);
  II(b, c, d, a, Block[13], 21, $4e0811a1);
  II(a, b, c, d, Block[ 4],  6, $f7537e82);
  II(d, a, b, c, Block[11], 10, $bd3af235);
  II(c, d, a, b, Block[ 2], 15, $2ad7d2bb);
  II(b, c, d, a, Block[ 9], 21, $eb86d391);
  inc(State[0], a);
  inc(State[1], b);
  inc(State[2], c);
  inc(State[3], d);
end;
```
