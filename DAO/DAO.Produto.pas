unit DAO.Produto;

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
  TDAOProduto = class
    private
    public
      class function ListarProdutos(const Params: array of TValue): TJSONObject;
  end;

implementation

{ TDAOProduto }

class function TDAOProduto.ListarProdutos(const Params: array of TValue): TJSONObject;
const
  lSQL = ' SELECT to_json(r)'+
  ' FROM ('+
  ' SELECT'+
  ' produto."CODPROD" id_produto,'+
  ' trim(produto."DESCRICAO") descricao,'+
  ' trim(produto."COMPLEMENTO") complemento,'+
  ' produto."VALORF" valor_inicial,'+
  ' produto."VALOR_PROMOCAO",'+
  ' produto."PROMOCAO_DO_DIA",'+
  ' produto."CODGRUPO" id_grupo,'+
  ' encode(produto."IMAGEM", ''base64'') as imagem,'+
  ' (select json_build_object(''id_grupo'', g."CODGRUPO", ''descricao'', trim(g."DESCRICAO"))'+
  ' FROM'+
  ' "CADGRUPO" g where produto."CODGRUPO" = g."CODGRUPO") as grupo'+
  ' , array_agg(produto_precificacao.*) as produto_precificacao'+
  ' FROM (select *,'+
  ' (SELECT'+
  ' json_build_object(''id_precificacao'', pf.id_precificacao,'+
  ' ''tipo'', pf.tipo,'+
  ' ''grupo'', pf.grupo,'+
  ' ''qtde_max_selecao'', pf.qtde_max_selecao) as precificacao'+
  ' FROM'+
  ' precificacao pf'+
  ' WHERE'+
  ' produto_precificacao.id_precificacao = pf.id_precificacao)'+
  ' from produto_precificacao join precificacao pf2 using'+
  ' (id_precificacao) order by pf2.grupo desc, pf2.tipo'+
  ' ) as produto_precificacao,'+
  ' "CADPROD" produto'+
  ' %s'+
  ' group by produto."CODPROD"'+
  ' order by trim(produto."DESCRICAO")'+
  ' ) r;';
var
  lWhere: String;
begin
  lWhere := TDAO.GetWhere(Params[5].ToString, tpTodoCampo, Params[0].AsType<TWebResponse>);
  if lWhere = EmptyStr then
    lWhere := ' where produto."CODPROD" = produto_precificacao.id_produto '
  else
    lWhere := lWhere + ' and produto."CODPROD" = produto_precificacao.id_produto ';
  Result := TDAO.OpenQueryToJSON(lSQL, lWhere, 'produtos', Params);
end;

end.

