program Configuracao;

uses
  Vcl.Forms,
  View.Principal in 'View\View.Principal.pas' {ViewPrincipal},
  WK.Utils.Criptografia in '..\lib\Utils\WK.Utils.Criptografia.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.
