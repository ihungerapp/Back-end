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
  ' mesa."CODAP" id_mesa, mesa."DESCRICAO", mesa."CADAP_UUID" mesa_uuid,'+
  ' array_agg(pedido.*) as pedido'+
  ' from "CADAP" mesa'+
  ' left outer join "RECEPCAO" pedido on pedido."CODAP" = mesa."CODAP"'+
  ' and pedido."SITUACAO" = ''Em aberto'''+
  ' %s'+
  ' group by mesa."CODAP"'+
  ' order by mesa."CODAP"'+
  ' ) r';
var
  lWhere: String;
begin
  lWhere := TDAO.GetWhere(Params[5].ToString, tpSemIncidencia, Params[0].AsType<TWebResponse>);
  Result := TDAO.OpenQueryToJSON(lSQL, lWhere, 'mesas', Params);
end;

end.

