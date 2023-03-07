unit DAO.Pedido_item;

interface

uses
  System.JSON, 
  System.Rtti,
  Data.DB, 
  Server.Connection, 
  System.SysUtils, 
  System.DateUtils,
  Server.Message, 
  Server.MessageList, 
  Web.HTTPApp,
  Server.DAO;

type
  TDAOPedido_item = class
    private
    public
      class function ProcedimentoBase(const Params: array of TValue): TJSONObject;
  end;

implementation

{ TDAOPedido_item }

class function TDAOPedido_item.ProcedimentoBase(const Params: array of TValue): TJSONObject;
const
  lSQL = 'COLOCAR O SQL AQUI';
var
  Connection: TConnection;
begin
  Result := TJSONObject.Create;
  Connection := TConnection.Create;
  try
    Connection.Query.SQL.Add(lSQL);
    try
	  //PASSAGEM DE PARAMETROS ATRAV�S DOS PARAMS 	
      //Connection.Query.ParamByName('ID').AsInteger := StrToInt(Params[6].ToString);
      Connection.Query.Open;
      Connection.Query.First;
      
      Result := TDAO.CreateJSONObject(Connection, Params);
    except
      on E: Exception do
        TMessage.Create(EErroGeral, 'Erro ao executar a consulta (' + E.Message + ')').SendMessage(Params[0].AsType<TWebResponse>);
    end;
  finally
    Connection.Free;
  end;
end;

end.

