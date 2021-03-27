unit AWS4D.S3;

interface

uses
  System.Classes,
  AWS4D.Interfaces,
  Vcl.ExtCtrls;

type
  TAWS4DS3 = class(TInterfacedObject,
                          iAWS4DS3)
    private
      FContent : String;
      FContentByteStream : TBytesStream;
      FCredencial : iAWS4DCredential;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAWS4DS3;
      function SendFile : iAWS4DS3SendFile;
      function GetFile : iAWS4DS3GetFile;
      function Credential : iAWS4DCredential;
      function ToString : String;
      function ToBytesStream : TBytesStream;
      function FromImage(var aValue : TImage) : iAWS4DS3;
      function Content ( aValue : String ) :  iAWS4DS3; overload;
      function Content ( var aValue : TBytesStream ) : iAWS4DS3; overload;
   end;

implementation

uses
  Data.Cloud.AmazonAPI,
  Data.Cloud.CloudAPI,
  AWS4D.S3.Get,
  AWS4D.S3.Send,
  AWS4D.S3.Credencial;

{ TBind4DAmazonS3 }

function TAWS4DS3.ToBytesStream: TBytesStream;
begin
  Result := FContentByteStream;
end;

function TAWS4DS3.ToString: String;
begin
  Result := FContent;
end;

function TAWS4DS3.Content(aValue: String): iAWS4DS3;
begin
  Result := Self;
  FContent := aValue;
end;

function TAWS4DS3.Content(var aValue: TBytesStream): iAWS4DS3;
begin
  Result := Self;
  FContentByteStream := aValue;
end;

constructor TAWS4DS3.Create;
begin

end;

function TAWS4DS3.Credential: iAWS4DCredential;
begin
  if not Assigned(FCredencial) then
    FCredencial := TAWS4DCredential.New(Self);

  Result := FCredencial;
end;

destructor TAWS4DS3.Destroy;
begin
  if Assigned(FContentByteStream) then
    FContentByteStream.Free;

  inherited;
end;

function TAWS4DS3.FromImage(var aValue: TImage): iAWS4DS3;
begin
  Result := Self;
  aValue.Picture.LoadFromStream(FContentByteStream);
end;

function TAWS4DS3.GetFile: iAWS4DS3GetFile;
begin
  Result := TAWS4DS3GetFile.New(Self);
end;

class function TAWS4DS3.New: iAWS4DS3;
begin
  Result := Self.Create;
end;

function TAWS4DS3.SendFile: iAWS4DS3SendFile;
begin
  Result := TAWS4DS3SendFile.New(Self);
end;


end.