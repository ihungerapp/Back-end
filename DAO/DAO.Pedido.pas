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
  ' "CONSUMO_AP" pi2'+
  ' WHERE'+
  ' pedido."CODRECEPCAO" = pi2."CODRECEPCAO" AND pi2."PEDIDO_ITEM_STATUS" = ''Aguardando'')'+
  ' AS pedido_item'+
  ' FROM'+
  ' "RECEPCAO" pedido'+
  ' inner join "CONSUMO_AP" pedido_item using ("CODRECEPCAO")'+
  ' %s '+
  ' group by pedido."CODRECEPCAO"'+
  ' order by pedido."DATA_ENTRADA" desc'+
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
//  lSQL = ' SELECT to_json(r)'+
//  ' FROM ('+
//  ' SELECT'+
//  ' pedido.*,'+
//  ' array_agg(pedido_item.*) as pedido_item'+
//  ' from (select *,'+
//  ' (SELECT'+
//  ' json_build_object('+
//  ' ''id_produto'', pr."CODPROD",'+
//  ' ''descricao'', pr."DESCRICAO",'+
//  ' ''complemento'', pr."COMPLEMENTO",'+
//  ' ''valor_inicial'', pr."VALORF",'+
//  ' ''valor_promocao'', pr."VALOR_PROMOCAO",'+
//  ' ''promocao_do_dia'', pr."PROMOCAO_DO_DIA",'+
//  ' ''id_grupo'', pr."CODGRUPO",'+
//  ' ''imagem'', encode(pr."IMAGEM", ''base64'')'+
//  ' ) as produto'+
//  ' FROM'+
//  ' "CADPROD" pr'+
//  ' WHERE'+
//  ' pi2."CODPROD" = pr."CODPROD")'+
//  ' FROM "CONSUMO_AP" pi2) as pedido_item,'+
//  ' "RECEPCAO" pedido, "CADAP" mesa'+
//  ' %s '+
//  ' group by pedido."CODRECEPCAO"'+
//  ' order by pedido."SITUACAO", pedido."DATA_ENTRADA"'+
//  ' ) r';
  lSQL = ' SELECT to_json(r) FROM ('+
  ' SELECT pedido.*, array_agg(pedido_item.*) as pedido_item'+
  ' from (select pi2.*,'+
  ' (SELECT json_build_object( ''id_produto'', pr."CODPROD", ''descricao'', pr."DESCRICAO", ''complemento'', pr."COMPLEMENTO", ''valor_inicial'','+
  ' pr."VALORF", ''valor_promocao'', pr."VALOR_PROMOCAO", ''promocao_do_dia'', pr."PROMOCAO_DO_DIA", ''id_grupo'', pr."CODGRUPO", ''imagem'', encode(pr."IMAGEM", ''base64'') ) as produto'+
  ' from "CADPROD" pr WHERE pi2."CODPROD" = pr."CODPROD"),'+
  ' (select'+
  ' array_agg(produto_precificacao.*) as produto_precificacao from (select pp.*, (select json_build_object(''id_precificacao'', pf.id_precificacao, ''tipo'', pf.tipo,'+
  ' ''grupo'', pf.grupo,''qtde_max_selecao'', pf.qtde_max_selecao) as precificacao from precificacao pf2 where pf2.id_precificacao = pp.id_precificacao)'+
  ' from precificacao pf, produto_precificacao pp WHERE pp.id_precificacao = pf.id_precificacao and pi2."CODPROD" = pp.id_produto'+
  ' and pp.id_produto_precificacao in ('+
  ' select UNNEST(ARRAY[string_to_array(pi2."ID_PRODUTO_PRECIFICACAO", '','')])::INT from "CONSUMO_AP" ca where ca."ID_CONSUMO_AP" = pi2."ID_CONSUMO_AP"'+
  ' ) ) as produto_precificacao'+
  ' )'+
  ' from "CONSUMO_AP" pi2) as pedido_item,'+
  ' "RECEPCAO" pedido, "CADAP" mesa'+
  ' %s '+
  ' group by pedido."CODRECEPCAO"'+
  ' order by pedido."SITUACAO", pedido."DATA_ENTRADA" ) r';

var
  lWhere: String;
begin
  lWhere := TDAO.GetWhere(Params[5].ToString, tpSemIncidencia, Params[0].AsType<TWebResponse>);
  if lWhere = EmptyStr then
    lWhere := ' where pedido."CODRECEPCAO" = pedido_item."CODRECEPCAO" and pedido."CODAP" = mesa."CODAP" '
  else
    lWhere := lWhere + ' and pedido."CODRECEPCAO" = pedido_item."CODRECEPCAO" and pedido."CODAP" = mesa."CODAP" ';
  Result := TDAO.OpenQueryToJSON(lSQL, lWhere, 'pedidos', Params);
end;

end.

