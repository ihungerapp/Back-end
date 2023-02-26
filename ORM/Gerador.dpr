program Gerador;

uses
  Vcl.Forms,
  u_AdmPrincipal in 'source\u_AdmPrincipal.pas' {AdmPrincipal},
  u_PostmanJson in 'source\u_PostmanJson.pas',
  u_GeraResource in 'source\u_GeraResource.pas',
  uPostmanJson in 'source\uPostmanJson.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAdmPrincipal, AdmPrincipal);
  Application.Run;
end.
