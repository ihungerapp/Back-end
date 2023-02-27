unit uPostmanJson;

interface

uses
  System.Classes;

type
  TPostman = class
  public
    class function PostmanJson: TStringList;
    class function PostmanResources(aDelimObj: String): TStringList;
    class function PostmanSchemas(aSchema: String): TStringList;
  end;

implementation

{ TPostman }

class function TPostman.PostmanJson: TStringList;
var
  aJson: TStringList;
begin
  aJson := TStringList.Create;

  aJson.Add(' { ');
  aJson.Add(' 	"info": { ');
  aJson.Add(' 		"_postman_id": "923871e0-5ccf-413f-ba24-4d5111ceefea", ');
  aJson.Add(' 		"name": "HungerApp_ORM", ');
  aJson.Add(' 		"schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json", ');
  aJson.Add(' 		"_exporter_id": "20996876" ');
  aJson.Add(' 	}, ');
  aJson.Add(' 	"item": [ ');
  aJson.Add(' 		@texto ');
  aJson.Add(' 		{ ');
  aJson.Add(' 			"name": "autorizacao", ');
  aJson.Add(' 			"request": { ');
  aJson.Add(' 				"method": "POST", ');
  aJson.Add(' 				"header": [ ');
  aJson.Add(' 					{ ');
  aJson.Add(' 						"key": "Content-Type", ');
  aJson.Add(' 						"value": "application/json", ');
  aJson.Add(' 						"type": "text" ');
  aJson.Add(' 					} ');
  aJson.Add(' 				], ');
  aJson.Add(' 				"body": { ');
  aJson.Add(' 					"mode": "raw", ');
  aJson.Add(' 					"raw": "{\r\n\"user\":\"hunger\",\r\n\"password\":\"rm045369\"\r\n}" ');
  aJson.Add(' 				}, ');
  aJson.Add(' 				"url": { ');
  aJson.Add(' 					"raw": "{{Url_Api}}authorization", ');
  aJson.Add(' 					"host": [ ');
  aJson.Add(' 						"{{Url_Api}}authorization" ');
  aJson.Add(' 					] ');
  aJson.Add(' 				} ');
  aJson.Add(' 			}, ');
  aJson.Add(' 			"response": [ ');
  aJson.Add(' 				{ ');
  aJson.Add(' 					"name": "autorizacao", ');
  aJson.Add(' 					"originalRequest": { ');
  aJson.Add(' 						"method": "POST", ');
  aJson.Add(' 						"header": [ ');
  aJson.Add(' 							{ ');
  aJson.Add(' 								"key": "Content-Type", ');
  aJson.Add(' 								"value": "application/json", ');
  aJson.Add(' 								"type": "text" ');
  aJson.Add(' 							} ');
  aJson.Add(' 						], ');
  aJson.Add(' 						"body": { ');
  aJson.Add(' 							"mode": "raw", ');
  aJson.Add(' 							"raw": "{\r\n\"user\":\"hunger\",\r\n\"password\":\"rm045369\"\r\n}" ');
  aJson.Add(' 						}, ');
  aJson.Add(' 						"url": { ');
  aJson.Add(' 							"raw": "{{Url_Api}}authorization", ');
  aJson.Add(' 							"host": [ ');
  aJson.Add(' 								"{{Url_Api}}authorization" ');
  aJson.Add(' 							] ');
  aJson.Add(' 						} ');
  aJson.Add(' 					}, ');
  aJson.Add(' 					"_postman_previewlanguage": "Text", ');
  aJson.Add(' 					"header": [], ');
  aJson.Add(' 					"cookie": [], ');
  aJson.Add(' 					"body": "" ');
  aJson.Add(' 				} ');
  aJson.Add(' 			] ');
  aJson.Add(' 		} ');
  aJson.Add(' 	], ');
  aJson.Add(' 	"event": [ ');
  aJson.Add(' 		{ ');
  aJson.Add(' 			"listen": "prerequest", ');
  aJson.Add(' 			"script": { ');
  aJson.Add(' 				"type": "text/javascript", ');
  aJson.Add(' 				"exec": [ ');
  aJson.Add(' 					"" ');
  aJson.Add(' 				] ');
  aJson.Add(' 			} ');
  aJson.Add(' 		}, ');
  aJson.Add(' 		{ ');
  aJson.Add(' 			"listen": "test", ');
  aJson.Add(' 			"script": { ');
  aJson.Add(' 				"type": "text/javascript", ');
  aJson.Add(' 				"exec": [ ');
  aJson.Add(' 					"" ');
  aJson.Add(' 				] ');
  aJson.Add(' 			} ');
  aJson.Add(' 		} ');
  aJson.Add(' 	], ');
  aJson.Add(' 	"variable": [ ');
  aJson.Add(' 		{ ');
  aJson.Add(' 			"key": "Url_Api", ');
  aJson.Add(' 			"value": "http://rmti.tec.br:8081/v1/", ');
  aJson.Add(' 			"type": "string" ');
  aJson.Add(' 		}, ');
  aJson.Add(' 		{ ');
  aJson.Add(' 			"key": "Token", ');
  aJson.Add(' 			"value": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJodW5nZXIiLCJpYXQiOjE2NzczODAzOTksIlVzZXJJRCI6MX0.k6sf6VdWO0sDsTfaNkT4HGOrPcZpGFgSfku4h3fMJUo", ');
  aJson.Add(' 			"type": "string" ');
  aJson.Add(' 		} ');
  aJson.Add(' 	] ');
  aJson.Add(' } ');
  Result := aJson;
end;

class function TPostman.PostmanResources(aDelimObj: String): TStringList;
var
  aJson: TStringList;
begin
  aJson := TStringList.Create;
  aJson.Add(' { ');
  aJson.Add(' 	"name": "@tabela", ');
  aJson.Add(' 	"item": [ ');
  aJson.Add(' 		{ ');
  aJson.Add(' 			"name": "@tabela", ');
  aJson.Add(' 			"request": { ');
  aJson.Add(' 				"method": "GET", ');
  aJson.Add(' 				"header": [ ');
  aJson.Add(' 					{ ');
  aJson.Add(' 						"key": "x-api-key", ');
  aJson.Add(' 						"value": "{{Token}}", ');
  aJson.Add(' 						"type": "text" ');
  aJson.Add(' 					} ');
  aJson.Add(' 				], ');
  aJson.Add(' 				"url": { ');
  aJson.Add(' 					"raw": "{{Url_Api}}@tabela", ');
  aJson.Add(' 					"host": [ ');
  aJson.Add(' 						"{{Url_Api}}@tabela" ');
  aJson.Add(' 					], ');
  aJson.Add(' 					"query": [ ');
  aJson.Add(' 						{ ');
  aJson.Add(' 							"key": "pageSize", ');
  aJson.Add(' 							"value": "0", ');
  aJson.Add(' 							"disabled": true ');
  aJson.Add(' 						} ');
  aJson.Add(' 					] ');
  aJson.Add(' 				} ');
  aJson.Add(' 			}, ');
  aJson.Add(' 			"response": [] ');
  aJson.Add(' 		}, ');
  aJson.Add(' 		{ ');
  aJson.Add(' 			"name": "@tabela", ');
  aJson.Add(' 			"request": { ');
  aJson.Add(' 				"method": "POST", ');
  aJson.Add(' 				"header": [ ');
  aJson.Add(' 					{ ');
  aJson.Add(' 						"key": "x-api-key", ');
  aJson.Add(' 						"value": "{{Token}}", ');
  aJson.Add(' 						"type": "text" ');
  aJson.Add(' 					} ');
  aJson.Add(' 				], ');
  aJson.Add(' 				"url": { ');
  aJson.Add(' 					"raw": "{{Url_Api}}@tabela", ');
  aJson.Add(' 					"host": [ ');
  aJson.Add(' 						"{{Url_Api}}@tabela" ');
  aJson.Add(' 					] ');
  aJson.Add(' 				} ');
  aJson.Add(' 			}, ');
  aJson.Add(' 			"response": [] ');
  aJson.Add(' 		}, ');
  aJson.Add(' 		{ ');
  aJson.Add(' 			"name": "@tabela", ');
  aJson.Add(' 			"request": { ');
  aJson.Add(' 				"method": "PUT", ');
  aJson.Add(' 				"header": [ ');
  aJson.Add(' 					{ ');
  aJson.Add(' 						"key": "Content-Type", ');
  aJson.Add(' 						"value": "application/json", ');
  aJson.Add(' 						"type": "text" ');
  aJson.Add(' 					}, ');
  aJson.Add(' 					{ ');
  aJson.Add(' 						"key": "x-api-key", ');
  aJson.Add(' 						"value": "{{Token}}", ');
  aJson.Add(' 						"type": "text" ');
  aJson.Add(' 					} ');
  aJson.Add(' 				], ');
  aJson.Add(' 				"url": { ');
  aJson.Add(' 					"raw": "{{Url_Api}}@tabela/1", ');
  aJson.Add(' 					"host": [ ');
  aJson.Add(' 						"{{Url_Api}}@tabela" ');
  aJson.Add(' 					], ');
  aJson.Add(' 					"path": [ ');
  aJson.Add(' 						"1" ');
  aJson.Add(' 					] ');
  aJson.Add(' 				} ');
  aJson.Add(' 			}, ');
  aJson.Add(' 			"response": [] ');
  aJson.Add(' 		}, ');
  aJson.Add(' 		{ ');
  aJson.Add(' 			"name": "@tabela", ');
  aJson.Add(' 			"request": { ');
  aJson.Add(' 				"method": "DELETE", ');
  aJson.Add(' 				"header": [ ');
  aJson.Add(' 					{ ');
  aJson.Add(' 						"key": "Content-Type", ');
  aJson.Add(' 						"value": "application/json", ');
  aJson.Add(' 						"type": "text" ');
  aJson.Add(' 					}, ');
  aJson.Add(' 					{ ');
  aJson.Add(' 						"key": "x-api-key", ');
  aJson.Add(' 						"value": "{{Token}}", ');
  aJson.Add(' 						"type": "text" ');
  aJson.Add(' 					} ');
  aJson.Add(' 				], ');
  aJson.Add(' 				"url": { ');
  aJson.Add(' 					"raw": "{{Url_Api}}@tabela/2", ');
  aJson.Add(' 					"host": [ ');
  aJson.Add(' 						"{{Url_Api}}@tabela" ');
  aJson.Add(' 					], ');
  aJson.Add(' 					"path": [ ');
  aJson.Add(' 						"2" ');
  aJson.Add(' 					] ');
  aJson.Add(' 				} ');
  aJson.Add(' 			}, ');
  aJson.Add(' 			"response": [] ');
  aJson.Add(' 		} ');
  aJson.Add(' 	] ');
  aJson.Add(' }'+ aDelimObj +' ');
  Result := aJson;
end;

class function TPostman.PostmanSchemas(aSchema: String): TStringList;
var
  aJson: TStringList;
begin
  aJson := TStringList.Create;
  aJson.Add(' 		{ ');
  aJson.Add(' 			"name": "' + aSchema + '", ');
  aJson.Add(' 			"item": [@texto] ');
  aJson.Add(' 		}, ');
  Result := aJson;
end;

end.

