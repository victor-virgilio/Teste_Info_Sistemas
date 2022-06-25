program Teste_Info_Sistemas_Proj;

uses
  Vcl.Forms,
  Alert_Form in 'Alert_Form.pas' {frmAlert},
  AlertMsg_Form in 'AlertMsg_Form.pas' {frmAlertMsg},
  SICK013 in 'SICK013.pas',
  dmMain_Unit in 'dmMain_Unit.pas' {dmdMain: TDataModule},
  IAEPes_Form in 'IAEPes_Form.pas' {frmIAEPessoa},
  frmMain_Form in 'frmMain_Form.pas' {frmMain},
  IAEEnd_Form in 'IAEEnd_Form.pas' {frmIAEEndereco};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAlert, frmAlert);
  Application.CreateForm(TfrmAlertMsg, frmAlertMsg);
  Application.CreateForm(TdmdMain, dmdMain);
  Application.CreateForm(TfrmIAEPessoa, frmIAEPessoa);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmIAEEndereco, frmIAEEndereco);
  Application.Run;
end.
