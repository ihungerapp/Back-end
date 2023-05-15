unit Controller.Pedido_item;

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
  DAO.Pedido_item;

 type
    TControllerPedido_item = class(TController)
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
    dsPedido_item  : TDataSource;

type
  TExec = procedure of object;
  
implementation

uses 
  Resources.pedidoItem;

{ TPedido_item }

constructor TControllerPedido_item.Create;
begin

end;

destructor TControllerPedido_item.Destroy;
begin
   inherited;
end;

function TControllerPedido_item.Execute(pMethod: string): TJSONObject;
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

procedure TControllerPedido_item.ProcedimentoBase;
begin
  JSONObject := TDAOPedido_item.ProcedimentoBase(FParams);
end;

procedure TControllerPedido_item.SetJSONObject(const Value: TJSONOBject);
begin
  FJSONObject := Value;
end;

procedure TControllerPedido_item.SetLengthParams(Size: Integer);
begin
  inherited;
  SetLength(FParams, Size);
end;

function TControllerPedido_item.GetParams(Index: Integer): TValue;
begin
  Result := Params[Index];
end;

procedure TControllerPedido_item.SetParams(const Value: TValue; Index: Integer);
begin
  FParams[Index] := Value;
end;

end.

