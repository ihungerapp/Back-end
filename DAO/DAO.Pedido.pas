unit DAO.Pedido;

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
  TDAOPedido = class
    private
    public
      class function ListarPedidos(const Params: array of TValue): TJSONObject;
  end;

implementation

{ TDAOPedido }

class function TDAOPedido.ListarPedidos(const Params: array of TValue): TJSONObject;
const
  lSQL = 'SELECT to_json(r)'+
  ' FROM ('+
  ' SELECT'+
  ' p.*,'+
  ' (SELECT'+
  ' array_agg(pi2.*) as pedido_item'+
  ' FROM'+
  ' "Pedidos".pedido_item pi2'+
  ' WHERE'+
  ' p.id_pedido = pi2.id_pedido and pi2.pedido_item_status = ''Aguardando'')'+
  ' AS pedido_item'+
  ' FROM'+
  ' "Pedidos".pedido p'+
  ' where p.pedido_status = ''Em aberto'' '+
  ' order by p.data_hora_abertura desc'+
  ' ) r';
var
  Connection: TConnection;
  lWhere,
  lJsonString: String;
  lJsonArray: TJSONArray;
  lJsonPair: TJSONPair;
begin
  Result := TJSONObject.Create;
  Connection := TConnection.Create;
  lJsonArray := TJSONArray.Create;
  lJsonPair := TJSONPair.Create('pedidos', lJsonArray);
  try
    lWhere := TDAO.GetWhere(Params[5].ToString, tpSemIncidencia, Params[0].AsType<TWebResponse>);
    Connection.Query.SQL.Add(Format(lSQL, [lWhere]));
    try
      Connection.Query.Open;
      Connection.Query.First;
      while not Connection.Query.Eof do
      begin
        lJsonString := Connection.Query.FieldByName('to_json').Value;
        lJsonArray.AddElement(TJSONValue.ParseJSONValue(TEncoding.ANSI.GetBytes(LJSONString), 0) as TJSONValue);
        Connection.Query.Next;
      end;
      Result := Result.AddPair(lJsonPair);
      //Result := TDAO.CreateJSONObject(Connection, Params);
    except
      on E: Exception do
        TMessage.Create(EErroGeral, 'Erro ao executar a consulta (' + E.Message + ')').SendMessage(Params[0].AsType<TWebResponse>);
    end;
  finally
    Connection.Free;
    //FreeAndNil(lJsonArray);
  end;
end;

end.

