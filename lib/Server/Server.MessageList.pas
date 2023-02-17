unit Server.MessageList;

interface

uses
  Server.Message;

const
  IRegistroInserido: TMessageType = (StatusCode: 201;
                                     Sucesso: True;
                                     Mensagem: 'Registro Inserido';
                                     Content: nil);

  IRegistroAlterado: TMessageType = (StatusCode: 200;
                                     Sucesso: True;
                                     Mensagem: 'Registro Alterado';
                                     Content: nil);

  IRegistroExcluido: TMessageType = (StatusCode: 200;
                                     Sucesso: True;
                                     Mensagem: 'Registro Excluído';
                                     Content: nil);

  IAutorizado: TMessageType = (StatusCode: 200;
                               Sucesso: True;
                               Mensagem: 'Usuário autenticado com sucesso.';
                               Content: nil);

  IEmailEnviado: TMessageType = (StatusCode: 200;
                               Sucesso: True;
                               Mensagem: 'Email enviado com sucesso.';
                               Content: nil);

  IServidorConnectado: TMessageType = (StatusCode: 200;
                               Sucesso: True;
                               Mensagem: 'Servidor connectado com sucesso';
                               Content: nil);

  EDadosNaoSalvos: TMessageType = (StatusCode: 400;
                                   Sucesso: False;
                                   Mensagem: 'Não foi possível salvar os dados';
                                   Content: nil);

  EDadosNaoExcluidos: TMessageType = (StatusCode: 400;
                                      Sucesso: False;
                                      Mensagem: 'Não foi possível excluir os dados';
                                      Content: nil);

  ERegistroNaoEncontrado: TMessageType = (StatusCode: 400;
                                          Sucesso: False;
                                          Mensagem: 'Nenhum registro encontrado';
                                          Content: nil);

  ECampoNotNullNaoPreenchido: TMessageType = (StatusCode: 400;
                                              Sucesso: False;
                                              Mensagem: 'Campo não preenchido';
                                              Content: nil);

  ENaoAutorizado: TMessageType = (StatusCode: 401;
                                  Sucesso: False;
                                  Mensagem: 'Usuário não logado';
                                  Content: nil);

  EAcessoNegado: TMessageType = (StatusCode: 403;
                                 Sucesso: False;
                                 Mensagem: 'Acesso negado. Usuário sem autorização.';
                                 Content: nil);

  EErroGeral: TMessageType = (StatusCode: 500;
                              Sucesso: False;
                              Mensagem: 'Erro geral';
                              Content: nil);

implementation

end.

