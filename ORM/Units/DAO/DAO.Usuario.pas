unit DAO.Usuario;

interface

uses
  System.JSON, 
  System.Rtti,
  Data.DB, 
  WK.Server.Connection, 
  System.SysUtils, 
  System.DateUtils,
  Server.Message, 
  Server.MessageList, 
  Web.HTTPApp,
  Server.DAO;

type
  TDAOUsuario = class
    private
    public
      class function ProcedimentoBase(const Params: array of TValue): TJSONObject;
  end;

implementation

{ TDAOUsuario }

class function TDAOUsuario.ProcedimentoBase(const Params: array of TValue): TJSONObject;
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
	  //PASSAGEM DE PARAMETROS ATRAVÉS DOS PARAMS 	
      //Connection.Query.ParamByName('ID').AsInteger := StrToInt(Params[6].ToString);
      Connection.Query.Open;
      Connection.Query.First;
      
      Result := TDAO.CreateJSONObject(Connection);
    except
      on E: Exception do
        TMessage.Create(EErroGeral, 'Erro ao executar a consulta (' + E.Message + ')').SendMessage(Params[0].AsType<TWebResponse>);
    end;
  finally
    Connection.Free;
  end;
end;

end.

