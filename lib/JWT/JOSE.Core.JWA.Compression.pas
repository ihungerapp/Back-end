unit JOSE.Core.JWA.Compression;

interface

uses
  System.SysUtils, JOSE.Types.Bytes, JOSE.Core.JWA;

type
  IJOSECompressionAlgorithm = interface(IJOSEAlgorithm)
  ['{B2782386-F5A2-43BF-B86C-B103A0221FC4}']
    function Compress(const Data: TBytes): TBytes;
    function Decompress(const CompressedData: TBytes): TBytes;
  end;

implementation

end.
