unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    btnProcessar: TButton;
    memLog: TMemo;
    dlgOpen: TOpenDialog;
    pnlHeader: TPanel;
    grpLoginAPI: TGroupBox;
    edtEmail: TEdit;
    lblEmail: TLabel;
    edtSenha: TEdit;
    lblSenha: TLabel;
    procedure btnProcessarClick(Sender: TObject);
  private
  public
  end;

var
  frmMain: TfrmMain;

implementation

uses
  uCsvController;

{$R *.dfm}

procedure TfrmMain.btnProcessarClick(Sender: TObject);
begin
  if not dlgOpen.Execute then
    Exit;

  // Arquivos
  TCsvController.ArquivoCsv := dlgOpen.FileName;
  TCsvController.ArquivoResultado :=
    ExtractFilePath(dlgOpen.FileName) + 'resultado.csv';

  memLog.Lines.Clear;
  memLog.Lines.Add('Iniciando processamento...');

  TCsvController.Processar(memLog);
end;

end.