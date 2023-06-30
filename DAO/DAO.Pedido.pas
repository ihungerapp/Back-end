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
      class function ListarPedidosComProduto(const Params: array of TValue): TJSONObject;
  end;

implementation

{ TDAOPedido }

class function TDAOPedido.ListarPedidos(const Params: array of TValue): TJSONObject;
const
  lSQL = 'SELECT to_json(r)'+
  ' FROM ('+
  ' SELECT'+
  ' pedido.*,'+
  ' (SELECT'+
  ' array_agg(pi2.*) as pedido_item'+
  ' FROM'+
  ' "Pedidos".pedido_item pi2'+
  ' WHERE'+
  ' pedido.id_pedido = pi2.id_pedido)'+
  ' AS pedido_item'+
  ' FROM'+
  ' "Pedidos".pedido pedido'+
  ' inner join "Pedidos".pedido_item pedido_item using (id_pedido)'+
  ' %s '+
  ' group by pedido.id_pedido'+
  ' order by pedido.data_hora_abertura desc'+
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
    except
      on E: Exception do
        TMessage.Create(EErroGeral, 'Erro ao executar a consulta (' + E.Message + ')').SendMessage(Params[0].AsType<TWebResponse>);
    end;
  finally
//    Connection.DB.Connected := False;
//    Connection.Free;
  end;
end;

class function TDAOPedido.ListarPedidosComProduto(
  const Params: array of TValue): TJSONObject;
const
  lSQL = ' SELECT to_json(r)'+
  ' FROM ('+
  ' SELECT'+
  ' pedido.*,'+
  ' array_agg(pedido_item.*) as pedido_item'+
  ' from (select *,'+
  ' (SELECT'+
  ' json_build_object('+
  ' ''id_produto'', pr.id_produto,'+
  ' ''descricao'', pr.descricao,'+
  ' ''complemento'', pr.complemento,'+
  ' ''valor_inicial'', pr.valor_inicial,'+
  ' ''valor_promocao'', pr.valor_promocao,'+
  ' ''promocao_do_dia'', pr.promocao_do_dia,'+
  ' ''id_grupo'', pr.id_grupo,'+
  ' ''imagem'', encode(pr.imagem, ''escape'')'+
  ' ) as produto'+
  ' FROM'+
  ' "Cadastros".produto pr'+
  ' WHERE'+
  ' pi2.id_produto = pr.id_produto)'+
  ' FROM "Pedidos".pedido_item pi2) as pedido_item,'+
  ' "Pedidos".pedido pedido, "Cadastros".mesa mesa'+
  ' %s '+
  ' group by pedido.id_pedido'+
  ' order by pedido.pedido_status, pedido.data_hora_abertura'+
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
    if lWhere = EmptyStr then
      lWhere := ' where pedido.id_pedido = pedido_item.id_pedido and pedido.id_mesa = mesa.id_mesa '
    else
      lWhere := lWhere + ' and pedido.id_pedido = pedido_item.id_pedido and pedido.id_mesa = mesa.id_mesa ';

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

