unit u_PostmanJson;

interface

uses
  System.SysUtils,
  System.Classes;

type
  IPostman = interface
  ['{B6E40577-9EF6-42A6-82F9-7663416F8771}']
    function Execute(ANomeResource, ANomeCampos: string): string;
  end;

type
  TPostman = class(TInterfacedObject, IPostman)
  private
    const
      NOVALINHA: string = #13#10;
    function PostmanJson(ANomeResource, ATexto: string): string;
    function PostmanResources(ANomeTabela, ANomeCampos: string): string;
    function Execute(ANomeResource, ANomeCampos: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    function Ref: IPostman;
  end;

var
  Postman: TPostman;

implementation

{ TPostman }

constructor TPostman.Create;
begin
  inherited Create;
end;

destructor TPostman.Destroy;
begin
  inherited Destroy;
end;

function TPostman.Ref: IPostman;
begin
  result := Self;
end;

function TPostman.Execute(ANomeResource, ANomeCampos: string): string;
begin
  result := PostmanResources(ANomeResource, ANomeCampos);
  result := PostmanJson(ANomeResource, result);
end;

function TPostman.PostmanJson(ANomeResource, ATexto: string): string;
begin
  result := '{ ' + NOVALINHA
          + '    "info": { ' + NOVALINHA
          + '        "_postman_id": "923871e0-5ccf-413f-ba24-4d5111ceefea", ' + NOVALINHA
          + '        "name": "Hunger App - @classe_resource ", ' + NOVALINHA
          + '        "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json", ' + NOVALINHA
          + '        "_exporter_id": "20996876" ' + NOVALINHA
          + '    }, ' + NOVALINHA
          + '    "item": [ ' + NOVALINHA
          + '        { ' + NOVALINHA
          + '            "name": "Cadastros", ' + NOVALINHA
          + '            "item": [ ' + NOVALINHA
          + '                @texto            ]' + NOVALINHA
          + '        }, ' + NOVALINHA
          + '        { ' + NOVALINHA
          + '            "name": "autorizacao", ' + NOVALINHA
          + '            "request": { ' + NOVALINHA
          + '                "method": "POST", ' + NOVALINHA
          + '                "header": [ ' + NOVALINHA
          + '                    { ' + NOVALINHA
          + '                        "key": "Content-Type", ' + NOVALINHA
          + '                        "value": "application/json", ' + NOVALINHA
          + '                        "type": "text" ' + NOVALINHA
          + '                    } ' + NOVALINHA
          + '                ], ' + NOVALINHA
          + '                "body": { ' + NOVALINHA
          + '                    "mode": "raw", ' + NOVALINHA
          + '                    "raw": "{\r\n\"user\":\"adm\",\r\n\"password\":\"adm\"\r\n}" ' + NOVALINHA
          + '                }, ' + NOVALINHA
          + '                "url": { ' + NOVALINHA
          + '                    "raw": "{{Url_Api}}authorization", ' + NOVALINHA
          + '                    "host": [ ' + NOVALINHA
          + '                        "{{Url_Api}}authorization" ' + NOVALINHA
          + '                    ] ' + NOVALINHA
          + '                } ' + NOVALINHA
          + '            }, ' + NOVALINHA
          + '            "response": [ ' + NOVALINHA
          + '                { ' + NOVALINHA
          + '                    "name": "autorizacao", ' + NOVALINHA
          + '                    "originalRequest": { ' + NOVALINHA
          + '                        "method": "POST", ' + NOVALINHA
          + '                        "header": [ ' + NOVALINHA
          + '                            { ' + NOVALINHA
          + '                                "key": "Content-Type", ' + NOVALINHA
          + '                                "value": "application/json", ' + NOVALINHA
          + '                                "type": "text" ' + NOVALINHA
          + '                            } ' + NOVALINHA
          + '                        ], ' + NOVALINHA
          + '                        "body": { ' + NOVALINHA
          + '                        "mode": "raw", ' + NOVALINHA
          + '                        "raw": "{\r\n\"user\":\"adm\",\r\n\"password\":\"adm\"\r\n}" ' + NOVALINHA
          + '                        }, ' + NOVALINHA
          + '                        "url": { ' + NOVALINHA
          + '                            "raw": "{{Url_Api}}authorization", ' + NOVALINHA
          + '                            "host": [ ' + NOVALINHA
          + '                                "{{Url_Api}}authorization" ' + NOVALINHA
          + '                            ] ' + NOVALINHA
          + '                        } ' + NOVALINHA
          + '                    }, ' + NOVALINHA
          + '                    "_postman_previewlanguage": "Text", ' + NOVALINHA
          + '                    "header": [], ' + NOVALINHA
          + '                    "cookie": [], ' + NOVALINHA
          + '                    "body": "" ' + NOVALINHA
          + '                } ' + NOVALINHA
          + '            ] ' + NOVALINHA
          + '        } ' + NOVALINHA
          + '    ], ' + NOVALINHA
          + '    "event": [ ' + NOVALINHA
          + '        { ' + NOVALINHA
          + '            "listen": "prerequest", ' + NOVALINHA
          + '            "script": { ' + NOVALINHA
          + '                "type": "text/javascript", ' + NOVALINHA
          + '                "exec": [ ' + NOVALINHA
          + '                    "" ' + NOVALINHA
          + '                ] ' + NOVALINHA
          + '            } ' + NOVALINHA
          + '        }, ' + NOVALINHA
          + '        { ' + NOVALINHA
          + '             "listen": "test", ' + NOVALINHA
          + '             "script": { ' + NOVALINHA
          + '                 "type": "text/javascript", ' + NOVALINHA
          + '                 "exec": [ ' + NOVALINHA
          + '                     "" ' + NOVALINHA
          + '                 ] ' + NOVALINHA
          + '             } ' + NOVALINHA
          + '        } ' + NOVALINHA
          + '    ], ' + NOVALINHA
          + '    "variable": [ ' + NOVALINHA
          + '        { ' + NOVALINHA
          + '            "key": "Url_Api", ' + NOVALINHA
          + '            "value": "http://localhost:8081/v1/", ' + NOVALINHA
          + '            "type": "string" ' + NOVALINHA
          + '        }, ' + NOVALINHA
          + '        { ' + NOVALINHA
          + '            "key": "Token", ' + NOVALINHA
          + '            "value": "Bearer substituir", ' + NOVALINHA
          + '            "type": "string" ' + NOVALINHA
          + '        } ' + NOVALINHA
          + '    ] ' + NOVALINHA
          + '} ' + NOVALINHA;

   result := result.Replace('@classe_resource', ANomeResource, [rfReplaceAll]);
   result := result.Replace('@texto', ATexto, [rfReplaceAll]);
end;

function TPostman.PostmanResources(ANomeTabela, ANomeCampos: string): string;
begin
  result := '{ ' + NOVALINHA
          + '                    "name": "@tabela", ' + NOVALINHA
          + '                    "item": [ ' + NOVALINHA
          + '                        { ' + NOVALINHA
          + '                            "name": "Busca @tabela", ' + NOVALINHA
          + '                            "request": { ' + NOVALINHA
          + '                                "method": "GET", ' + NOVALINHA
          + '                                "header": [ ' + NOVALINHA
          + '                                    { ' + NOVALINHA
          + '                                        "key": "x-api-key", ' + NOVALINHA
          + '                                        "value": "{{Token}}", ' + NOVALINHA
          + '                                        "type": "text" ' + NOVALINHA
          + '                                    } ' + NOVALINHA
          + '                                ], ' + NOVALINHA
          + '                                "url": { ' + NOVALINHA
          + '                                    "raw": "{{Url_Api}}@tabela", ' + NOVALINHA
          + '                                    "host": [ ' + NOVALINHA
          + '                                        "{{Url_Api}}@tabela" ' + NOVALINHA
          + '                                    ], ' + NOVALINHA
          + '                                    "query": [ ' + NOVALINHA
          + '                                        { ' + NOVALINHA
          + '                                            "key": "pageSize", ' + NOVALINHA
          + '                                            "value": "0", ' + NOVALINHA
          + '                                            "disabled": true ' + NOVALINHA
          + '                                        } ' + NOVALINHA
          + '                                    ] ' + NOVALINHA
          + '                                } ' + NOVALINHA
          + '                            }, ' + NOVALINHA
          + '                            "response": [] ' + NOVALINHA
          + '                        }, ' + NOVALINHA
          + '                        { ' + NOVALINHA
          + '                            "name": "Inclui @tabela", ' + NOVALINHA
          + '                            "request": { ' + NOVALINHA
          + '                                "method": "POST", ' + NOVALINHA
          + '                                "header": [ ' + NOVALINHA
          + '                                    { ' + NOVALINHA
          + '                                        "key": "x-api-key", ' + NOVALINHA
          + '                                        "value": "{{Token}}", ' + NOVALINHA
          + '                                        "type": "text" ' + NOVALINHA
          + '                                    } ' + NOVALINHA
          + '                                ], ' + NOVALINHA
          + '                                @campos ' + NOVALINHA
          + '                                "url": { ' + NOVALINHA
          + '                                    "raw": "{{Url_Api}}@tabela", ' + NOVALINHA
          + '                                    "host": [ ' + NOVALINHA
          + '                                        "{{Url_Api}}@tabela" ' + NOVALINHA
          + '                                    ] ' + NOVALINHA
          + '                                } ' + NOVALINHA
          + '                            }, ' + NOVALINHA
          + '                            "response": [] ' + NOVALINHA
          + '                        }, ' + NOVALINHA
          + '                        { ' + NOVALINHA
          + '                            "name": "Altera @tabela", ' + NOVALINHA
          + '                            "request": { ' + NOVALINHA
          + '                                "method": "PUT", ' + NOVALINHA
          + '                                "header": [ ' + NOVALINHA
          + '                                    { ' + NOVALINHA
          + '                                        "key": "Content-Type", ' + NOVALINHA
          + '                                        "value": "application/json", ' + NOVALINHA
          + '                                        "type": "text" ' + NOVALINHA
          + '                                    }, ' + NOVALINHA
          + '                                    { ' + NOVALINHA
          + '                                        "key": "x-api-key", ' + NOVALINHA
          + '                                        "value": "{{Token}}", ' + NOVALINHA
          + '                                        "type": "text" ' + NOVALINHA
          + '                                    } ' + NOVALINHA
          + '                                ], ' + NOVALINHA
          + '                                @campos ' + NOVALINHA
          + '                                "url": { ' + NOVALINHA
          + '                                    "raw": "{{Url_Api}}@tabela/1", ' + NOVALINHA
          + '                                    "host": [ ' + NOVALINHA
          + '                                        "{{Url_Api}}@tabela" ' + NOVALINHA
          + '                                    ], ' + NOVALINHA
          + '                                    "path": [ ' + NOVALINHA
          + '                                        "1" ' + NOVALINHA
          + '                                    ] ' + NOVALINHA
          + '                                } ' + NOVALINHA
          + '                            }, ' + NOVALINHA
          + '                            "response": [] ' + NOVALINHA
          + '                        }, ' + NOVALINHA
          + '                        { ' + NOVALINHA
          + '                            "name": "Exclui @tabela", ' + NOVALINHA
          + '                            "request": { ' + NOVALINHA
          + '                                "method": "DELETE", ' + NOVALINHA
          + '                                "header": [ ' + NOVALINHA
          + '                                    { ' + NOVALINHA
          + '                                        "key": "Content-Type", ' + NOVALINHA
          + '                                        "value": "application/json", ' + NOVALINHA
          + '                                        "type": "text" ' + NOVALINHA
          + '                                    }, ' + NOVALINHA
          + '                                    { ' + NOVALINHA
          + '                                        "key": "x-api-key", ' + NOVALINHA
          + '                                        "value": "{{Token}}", ' + NOVALINHA
          + '                                        "type": "text" ' + NOVALINHA
          + '                                    } ' + NOVALINHA
          + '                                ], ' + NOVALINHA
          + '                                "url": { ' + NOVALINHA
          + '                                    "raw": "{{Url_Api}}@tabela/2", ' + NOVALINHA
          + '                                    "host": [ ' + NOVALINHA
          + '                                        "{{Url_Api}}@tabela" ' + NOVALINHA
          + '                                    ], ' + NOVALINHA
          + '                                    "path": [ ' + NOVALINHA
          + '                                        "2" ' + NOVALINHA
          + '                                    ] ' + NOVALINHA
          + '                                } ' + NOVALINHA
          + '                            }, ' + NOVALINHA
          + '                            "response": [] ' + NOVALINHA
          + '                        } ' + NOVALINHA
          + '                    ] ' + NOVALINHA
          + '                } ' + NOVALINHA;

  result := result.Replace('@tabela', ANomeTabela, [rfReplaceAll]);
  result := result.Replace('@campos', ANomeCampos, [rfReplaceAll]);
end;

end.

