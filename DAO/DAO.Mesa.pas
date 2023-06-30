unit DAO.Mesa;

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
  TDAOMesa = class
    private
    public
      class function ListarMesasComPedido(const Params: array of TValue): TJSONObject;
  end;

implementation

{ TDAOMesa }

class function TDAOMesa.ListarMesasComPedido(const Params: array of TValue): TJSONObject;
const
  lSQL = ' SELECT to_json(r)'+
  ' FROM ('+
  ' SELECT'+
  ' mesa.*,'+
  ' array_agg(pedido.*) as pedido'+
  ' from "Cadastros".mesa mesa'+
  ' left outer join "Pedidos".pedido pedido on pedido.id_mesa = mesa.id_mesa'+
  ' and pedido.pedido_status = ''Em aberto'' '+
  ' %s'+
  ' group by mesa.id_mesa'+
  ' order by mesa.id_mesa'+
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
  lJsonPair := TJSONPair.Create('mesas', lJsonArray);
  try
    lWhere := TDAO.GetWhere(Params[5].ToString, tpSemIncidencia, Params[0].AsType<TWebResponse>);
    Connection.Query.SQL.Add(Format(lSQL, [lWhere]));
    try
      Connection.Query.Open;
      Connection.Query.First;
      while not Connection.Query.Eof do
      begin
        lJsonString := Connection.Query.FieldByName('to_json').Value;
        lJsonArray.AddElement(TJSONValue.ParseJSONValue(TEncoding.UTF8.GetBytes(LJSONString), 0) as TJSONValue);
        Connection.Query.Next;
      end;
      Result := Result.AddPair(lJsonPair);
    except
      on E: Exception do
        TMessage.Create(EErroGeral, 'Erro ao executar a consulta (' + E.Message + ')').SendMessage(Params[0].AsType<TWebResponse>);
    end;
  finally
//    Connection.DB.Connected := False;
//    Connection.Free;
  end;
end;

end.

