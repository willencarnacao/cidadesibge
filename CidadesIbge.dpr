program CidadesIbge;

uses
  Vcl.Forms,
  uMainForm in 'view\uMainForm.pas' {frmMain},
  uCsvController in 'controller\uCsvController.pas',
  uIbgeController in 'controller\uIbgeController.pas',
  uStatsController in 'controller\uStatsController.pas',
  uResultadoCsvController in 'controller\uResultadoCsvController.pas',
  uSubmitController in 'controller\uSubmitController.pas',
  uIbgeService in 'service\uIbgeService.pas',
  uSupabaseService in 'service\uSupabaseService.pas',
  uMunicipio in 'model\uMunicipio.pas',
  uStatsResult in 'model\uStatsResult.pas',
  uStringHelper in 'uStringHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.