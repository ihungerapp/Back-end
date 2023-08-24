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
    ' select to_json(r) FROM (select grupo."CODGRUPO" id_grupo, trim(grupo."DESCRICAO") descricao from "CADGRUPO" grupo'+
    ' join "CADPROD" produto using("CODGRUPO")'+
    ' group by grupo."CODGRUPO"'+
    ' order by trim(grupo."DESCRICAO")'+
    ' ) r';
begin
  Result := TDAO.OpenQueryToJSON(lSQL, '', 'grupos', Params);
end;

end.

