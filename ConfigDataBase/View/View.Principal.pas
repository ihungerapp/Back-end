unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,IniFiles, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, WK.Utils.Criptografia, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef;

type
  TViewPrincipal = class(TForm)
    pnlBase: TPanel;
    pnlDescricao: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Shape2: TShape;
    edtDatabase: TEdit;
    lblServidor: TLabel;
    pnlLine: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    Shape1: TShape;
    edtServer: TEdit;
    Panel4: TPanel;
    Label3: TLabel;
    Panel5: TPanel;
    Shape3: TShape;
    edtUsername: TEdit;
    Panel6: TPanel;
    Label4: TLabel;
    Panel7: TPanel;
    Shape4: TShape;
    edtPassword: TEdit;
    imgPassword: TImage;
    lblCadastro: TLabel;
    pnlConfirmar: TPanel;
    ShapeConfirmar: TShape;
    lblConfirmar: TLabel;
    pnlLineCadastro: TPanel;
    FDConnection: TFDConnection;
    pnlDeletar: TPanel;
    ShapeDeletar: TShape;
    lblDeletar: TLabel;
    Panel8: TPanel;
    Label5: TLabel;
    Panel9: TPanel;
    Shape5: TShape;
    edtPorta: TEdit;
    Panel10: TPanel;
    Label6: TLabel;
    Panel11: TPanel;
    Shape6: TShape;
    lblVersao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure imgPasswordClick(Sender: TObject);
    procedure lblConfirmarClick(Sender: TObject);
    procedure lblDeletarClick(Sender: TObject);
  private
    FPath:string;
    procedure ValidarDadosServidor();
    procedure SavarDadosServidor();
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.dfm}

procedure TViewPrincipal.FormCreate(Sender: TObject);
var
  LFileIni:TIniFile;
begin
  FPath := GetCurrentDir()+'\ConfigServer.Ini';
  if FileExists(FPath) then
  begin
    LFileIni := TIniFile.Create(FPath);
    try
      edtDatabase.Text := LFileIni.ReadString('Config','Database','');
      edtServer.Text := LFileIni.ReadString('Config','Server','');
      edtUsername.Text := LFileIni.ReadString('Config','UserName','');
      edtPorta.Text := LFileIni.ReadString('Config','Port','');
      try
        edtPassword.Text := TCriptografia.Descriptografar(LFileIni.ReadString('Config','Password',''));
      except on E: Exception do
        begin
          edtPassword.Text := '';
        end;
      end;
    finally
      LFileIni.Free;
    end;
  end;
end;

procedure TViewPrincipal.imgPasswordClick(Sender: TObject);
begin
  if edtPassword.PasswordChar = '*' then
    edtPassword.PasswordChar := #0
  else
    edtPassword.PasswordChar := '*';
end;

procedure TViewPrincipal.lblConfirmarClick(Sender: TObject);
begin
  try
    ValidarDadosServidor();
    SavarDadosServidor();
    ShowMessage('Dadaos salvo com sucesso')
  except on E: Exception do
    raise Exception.Create(e.Message);
  end;
end;

procedure TViewPrincipal.lblDeletarClick(Sender: TObject);
begin
  try
    FDConnection.Connected := False;
    FDConnection.Params.Clear;
    FDConnection.Params.AddPair('DriverID', 'PG');
    FDConnection.Params.AddPair('Server', edtServer.Text);
    FDConnection.Params.AddPair('Database', edtDatabase.Text);
    FDConnection.Params.AddPair('User_Name', edtUsername.Text);
    FDConnection.Params.AddPair('Password', edtPassword.Text);
    FDConnection.Params.AddPair('Port', edtPorta.Text);
    FDConnection.Connected := True;
  except on E: Exception do
    begin
      ShowMessage('Conexão mal sucedida!'+#13+E.Message);
      Abort;
    end;
  end;
  ShowMessage('Conexão bem sucedida!');
end;

procedure TViewPrincipal.SavarDadosServidor;
var
  LFileIni:TIniFile;
begin
  if FileExists(FPath) then
  begin
    LFileIni := TIniFile.Create(FPath);
    try
      LFileIni.WriteString('Config','Database',edtDatabase.Text);
      LFileIni.WriteString('Config','Server',edtServer.Text);
      LFileIni.WriteString('Config','UserName',edtUsername.Text);
      LFileIni.WriteString('Config','Password',TCriptografia.Criptografar(edtPassword.Text));
      LFileIni.WriteString('Config','Port',edtPorta.Text);
    finally
      LFileIni.Free;
    end;
  end;
end;

procedure TViewPrincipal.ValidarDadosServidor;
begin
  if edtDatabase.Text = EmptyStr then
  begin
    edtDatabase.SetFocus();
    raise Exception.Create('Campo database não pode ser vazio!');
  end;
  if edtServer.Text = EmptyStr then
  begin
    edtServer.SetFocus();
    raise Exception.Create('Campo server não pode ser vazio!');
  end;
  if edtPorta.Text = EmptyStr then
  begin
    edtPorta.SetFocus();
    raise Exception.Create('Campo porta não pode ser vazio!');
  end;
  if edtUsername.Text = EmptyStr then
  begin
    edtUsername.SetFocus();
    raise Exception.Create('Campo username não pode ser vazio!');
  end;
  if edtPassword.Text = EmptyStr then
  begin
    edtPassword.SetFocus();
    raise Exception.Create('Campo password não pode ser vazio!');
  end;
end;

end.
