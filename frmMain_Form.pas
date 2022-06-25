unit frmMain_Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TfrmMain = class(TForm)
    Shape3: TShape;
    Shape10: TShape;
    Label4: TLabel;
    Label8: TLabel;
    btnExecPes: TButton;
    cbbOperacaoPes: TComboBox;
    btnExecEnd: TButton;
    cbbOperacaoEnd: TComboBox;
    grdPessoa: TDBGrid;
    grdEndereco: TDBGrid;
    procedure btnExecPesClick(Sender: TObject);
    procedure cbbOperacaoPesKeyPress(Sender: TObject; var Key: Char);
    procedure cbbOperacaoEndChange(Sender: TObject);
    procedure GetStatusOperacao;
    procedure btnExecEndClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

    var
    strOprPes: String;
    strOprEnd: String;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
uses
  IAEPes_Form, IAEEnd_Form, SICK013, dmMain_Unit;

procedure tfrmMain.GetStatusOperacao;
begin
  if cbbOperacaoPes.itemindex = 0 then
    strOprPes := 'INC'
  else
    if cbbOperacaoPes.itemindex = 1 then
      strOprPes := 'ALT'
    else
      if cbbOperacaoPes.itemindex = 2 then
        strOprPes := 'EXC'
      ;
    ;
  ;

  if cbbOperacaoEnd.itemindex = 0 then
    strOprEnd := 'INC'
  else
    if cbbOperacaoEnd.itemindex = 1 then
      strOprEnd := 'ALT'
    else
      if cbbOperacaoEnd.itemindex = 2 then
        strOprEnd := 'EXC'
      ;
    ;
  ;
end;



procedure TfrmMain.btnExecPesClick(Sender: TObject);
begin
  GetStatusOperacao;

  if ((strOprPes = 'ALT') or (strOprPes = 'EXC')) then
  begin
    if dmdMain.tbPessoa.RecordCount = 0 then
    begin
      ALERTMSG('Atenção!','Ainda não há nenhum registro de pessoa.',false);
      exit;
    end;
  end;

  if frmIAEPessoa = nil then
    frmIAEPessoa := TfrmIAEPessoa.Create(Self);

  frmIAEPessoa.strOpr  := strOprPes;
  frmIAEPessoa.iPessoa := dmdMain.tbPessoaid_Codigo_Pes.AsInteger;
  frmIAEPessoa.ShowModal;
end;



procedure TfrmMain.btnExecEndClick(Sender: TObject);
begin
  GetStatusOperacao;

  if (strOprEnd = 'INC') then
  begin
    if dmdMain.tbPessoa.RecordCount = 0 then
    begin
      ALERTMSG('Atenção!','Ainda não há nenhum registro de pessoa.',false);
      exit;
    end;
  end;

  if ((strOprEnd = 'ALT') or (strOprEnd = 'EXC')) then
  begin
    if dmdMain.tbEndPes.RecordCount = 0 then
    begin
      ALERTMSG('Atenção!','Ainda não há nenhum endereço cadastrado para essa pessoa.',false);
      exit;
    end;
  end;

  if frmIAEEndereco = nil then
    frmIAEEndereco := TfrmIAEEndereco.Create(Self);

  frmIAEEndereco.strOpr  := strOprEnd;
  frmIAEEndereco.iEndereco := dmdMain.tbEndPesid_Codigo_End.AsInteger;
  frmIAEEndereco.ShowModal;
end;



procedure TfrmMain.cbbOperacaoEndChange(Sender: TObject);
begin
  GetStatusOperacao;
  btnExecEnd.Caption := cbbOperacaoEnd.Text;
  btnExecPes.Caption := cbbOperacaoPes.Text;
end;

procedure TfrmMain.cbbOperacaoPesKeyPress(Sender: TObject; var Key: Char);
begin
 key := #0;
end;

end.
