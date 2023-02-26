unit Controller.Precificacao;

interface

uses
  System.SysUtils, 
  Data.DB, 
  FireDAC.Stan.Intf, 
  FireDAC.Stan.Option,
  FireDAC.Stan.Param, 
  FireDAC.Stan.Error, 
  FireDAC.DatS, 
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, 
  FireDAC.Comp.DataSet, 
  FireDAC.Comp.Client, 
  Server.DAO, 
  System.Generics.Collections,  
  Server.Controller, 
  System.JSON, 
  System.Rtti,  
  DAO.Precificacao;

 type
    TControllerPrecificacao = class(TController)
  published
    procedure ProcedimentoBase;
 private
    FJSONObject: TJSONOBject;
    FParams: array of TValue;
    function GetParams(Index: Integer): TValue;
    procedure SetJSONObject(const Value: TJSONOBject);

public
    constructor Create;
    destructor Destroy; override;
    function Execute(pMethod: string): TJSONObject; override;
    procedure SetParams(const Value: TValue; Index: Integer); override;
    procedure SetLengthParams(Size: Integer); override;
    property JSONObject: TJSONOBject read FJSONObject write SetJSONObject;
    property Params[Index: Integer]: TValue read GetParams;    
end;

  var
    dsPrecificacao  : TDataSource;

type
  TExec = procedure of object;
  
implementation

uses 
  Resources.precificacao;

{ TPrecificacao }

constructor TControllerPrecificacao.Create;
begin

end;

destructor TControllerPrecificacao.Destroy;
begin
   inherited;
end;

function TControllerPrecificacao.Execute(pMethod: string): TJSONObject;
var
  Routine: TMethod;
  Exec: TExec;
begin
  Routine.Data := Pointer(Self);
  Routine.Code := Self.MethodAddress(pMethod);
  if not Assigned(Routine.Code) then
    Exit;
  Exec := TExec(Routine);
  Exec;
  Result := JSONObject;
end;

procedure TControllerPrecificacao.ProcedimentoBase;
begin
  JSONObject := TDAOPrecificacao.ProcedimentoBase(FParams);
end;

procedure TControllerPrecificacao.SetJSONObject(const Value: TJSONOBject);
begin
  FJSONObject := Value;
end;

procedure TControllerPrecificacao.SetLengthParams(Size: Integer);
begin
  inherited;
  SetLength(FParams, Size);
end;

function TControllerPrecificacao.GetParams(Index: Integer): TValue;
begin
  Result := Params[Index];
end;

procedure TControllerPrecificacao.SetParams(const Value: TValue; Index: Integer);
begin
  FParams[Index] := Value;
end;

end.

