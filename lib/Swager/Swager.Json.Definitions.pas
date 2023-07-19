{
  ____________________________________________________________________________

  █░█░█ █ █░░ █▀ █▀█ █▄░█   █░░ █░█ ▀█
  ▀▄▀▄▀ █ █▄▄ ▄█ █▄█ █░▀█   █▄▄ █▄█ █▄ ©  2023
  Map defs to swager Json
  ______________________________________________________________________________
}
unit Swager.Json.Definitions;

interface

uses
  Swager.Json.DTO,
   System.Generics.Collections,
    REST.Json.Types;

{$M+}

type
  TDescricao = class;
  TIdsetor = class;
  TProperties = class;

  TDescricao = class
  private
    FDescription: string;
    FSize: string;
    FType: string;
  published
    property Description: string read FDescription write FDescription;
    property Size: string read FSize write FSize;
    property &Type: string read FType write FType;
  end;

  TIdsetor = class
  private
    FDescription: string;
    FFormat: string;
    FType: string;
  published
    property Description: string read FDescription write FDescription;
    property Format: string read FFormat write FFormat;
    property &Type: string read FType write FType;
  end;

  TProperties = class
  private
    FDescricao: TDescricao;
    FIdsetor: TIdsetor;
  published
    property Descricao: TDescricao read FDescricao;
    property Idsetor: TIdsetor read FIdsetor;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TSetor = class(TJsonDTO)
  private
    FDescription: string;
    FProperties: TProperties;
    [JSONName('required')]
    FRequiredArray: TArray<string>;
    [JSONMarshalled(False)]
    FRequired: TList<string>;
    FType: string;
    function GetRequired: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Description: string read FDescription write FDescription;
    property Properties: TProperties read FProperties;
    property Required: TList<string> read GetRequired;
    property &Type: string read FType write FType;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TRoot = class(TJsonDTO)
  private
    FSetor: TSetor;
  published
    property Setor: TSetor read FSetor;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TProperties }

constructor TProperties.Create;
begin
  inherited;
  FIdsetor := TIdsetor.Create;
  FDescricao := TDescricao.Create;
end;

destructor TProperties.Destroy;
begin
  FIdsetor.Free;
  FDescricao.Free;
  inherited;
end;

{ TSetor }

constructor TSetor.Create;
begin
  inherited;
  FProperties := TProperties.Create;
end;

destructor TSetor.Destroy;
begin
  FProperties.Free;
  GetRequired.Free;
  inherited;
end;

function TSetor.GetRequired: TList<string>;
begin
  Result := List<string>(FRequired, FRequiredArray);
end;

function TSetor.GetAsJson: string;
begin
  RefreshArray<string>(FRequired, FRequiredArray);
  Result := inherited;
end;

{ TRoot }

constructor TRoot.Create;
begin
  inherited;
  FSetor := TSetor.Create;
end;

destructor TRoot.Destroy;
begin
  FSetor.Free;
  inherited;
end;

end.
