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
  lWhere: String;
begin
  lWhere := TDAO.GetWhere(Params[5].ToString, tpSemIncidencia, Params[0].AsType<TWebResponse>);
  Result := TDAO.OpenQueryToJSON(lSQL, lWhere, 'mesas', Params);
end;

end.

