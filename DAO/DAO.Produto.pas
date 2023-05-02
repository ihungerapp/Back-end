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
  ' produto.id_produto,'+
  ' produto.descricao,'+
  ' produto.complemento,'+
  ' produto.valor_inicial,'+
  ' produto.valor_promocao,'+
  ' produto.promocao_do_dia,'+
  ' produto.id_grupo,'+
  ' encode(produto.imagem, ''escape'') as imagem,'+
  ' (select json_build_object(''id_grupo'', g.id_grupo, ''descricao'', g.descricao)'+
  ' FROM'+
  ' "Cadastros".grupo g where produto.id_grupo = g.id_grupo) as grupo'+
  ' , array_agg(produto_precificacao.*) as produto_precificacao'+
  ' FROM (select *,'+
  ' (SELECT'+
  ' json_build_object(''id_precificacao'', pf.id_precificacao,'+
  ' ''tipo'', pf.tipo) as precificacao'+
  ' FROM'+
  ' "Cadastros".precificacao pf'+
  ' WHERE'+
  ' produto_precificacao.id_precificacao = pf.id_precificacao)'+
  ' from "Cadastros".produto_precificacao'+
  ' ) as produto_precificacao,'+
  ' "Cadastros".produto produto'+
  ' %s'+
  ' group by produto.id_produto'+
  ' order by produto.descricao'+
  ' ) r;';
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
  lJsonPair := TJSONPair.Create('produtos', lJsonArray);
  try
    lWhere := TDAO.GetWhere(Params[5].ToString, tpTodoCampo, Params[0].AsType<TWebResponse>);
    if lWhere = EmptyStr then
      lWhere := ' where produto.id_produto = produto_precificacao.id_produto '
    else
      lWhere := lWhere + ' and produto.id_produto = produto_precificacao.id_produto ';
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
    Connection.Free;
  end;
end;

end.

