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
  ' pedido.id_pedido = pi2.id_pedido AND pi2.pedido_item_status = ''Aguardando'')'+
  ' AS pedido_item'+
  ' FROM'+
  ' "Pedidos".pedido pedido'+
  ' inner join "Pedidos".pedido_item pedido_item using (id_pedido)'+
  ' %s '+
  ' group by pedido.id_pedido'+
  ' order by pedido.data_hora_abertura desc'+
  ' ) r';
var
  lWhere: String;
begin
  lWhere := TDAO.GetWhere(Params[5].ToString, tpSemIncidencia, Params[0].AsType<TWebResponse>);
  Result := TDAO.OpenQueryToJSON(lSQL, lWhere, 'pedidos', Params);
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
  lWhere: String;
begin
  lWhere := TDAO.GetWhere(Params[5].ToString, tpSemIncidencia, Params[0].AsType<TWebResponse>);
  if lWhere = EmptyStr then
    lWhere := ' where pedido.id_pedido = pedido_item.id_pedido and pedido.id_mesa = mesa.id_mesa '
  else
    lWhere := lWhere + ' and pedido.id_pedido = pedido_item.id_pedido and pedido.id_mesa = mesa.id_mesa ';
  Result := TDAO.OpenQueryToJSON(lSQL, lWhere, 'pedidos', Params);
end;

end.

