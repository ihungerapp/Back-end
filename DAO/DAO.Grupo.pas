unit DAO.Grupo;

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
  TDAOGrupo = class
    private
    public
      class function ListarGrupos(const Params: array of TValue): TJSONObject;
  end;

implementation

{ TDAOGrupo }

class function TDAOGrupo.ListarGrupos(const Params: array of TValue): TJSONObject;
const
  lSQL =
    ' select to_json(r) FROM (select grupo.id_grupo, grupo.descricao from "Cadastros".grupo grupo'+
    ' join "Cadastros".produto produto using(id_grupo)'+
    ' group by grupo.id_grupo'+
    ' order by trim(grupo.descricao)'+
    ' ) r';
begin
  Result := TDAO.OpenQueryToJSON(lSQL, '', 'grupos', Params);
end;

end.

