unit Teste_Info_Sistemas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, SICK013, dmMain_Unit;

type
  TfrmMain = class(TForm)
    Shape3: TShape;
    Shape1: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label1: TLabel;
    edtNome: TEdit;
    edtRG: TEdit;
    edtCPF: TEdit;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    edtCEP: TEdit;
    edtLogradouro: TEdit;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtEstado: TEdit;
    edtPais: TEdit;
    btnExecPes: TButton;
    cbbOperacaoPes: TComboBox;
    btnExecEnd: TButton;
    cbbOperacaoEnd: TComboBox;
    grdPessoa: TDBGrid;
    grdEndereco: TDBGrid;
    procedure btnExecPesClick(Sender: TObject);
    procedure tbPessoaAfterScroll(DataSet: TDataSet);
    procedure cbbOperacaoPesKeyPress(Sender: TObject; var Key: Char);
    procedure cbbOperacaoEndChange(Sender: TObject);
    procedure GetStatusOperacao(Sender: TObject);

  private
    { Private declarations }

    var
    iCodPes, iCodEnd : Integer;
    bNavega : Boolean;



  public
    { Public declarations }

    var
    strOpr: String;


  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure tfrmMain.GetStatusOperacao(Sender: TObject);
begin
  if frmMain.cbbOperacaoPes.itemindex = 0 then
  begin

  end;

end;


procedure TfrmMain.cbbOperacaoEndChange(Sender: TObject);
begin
  btnExecEnd.Caption := cbbOperacaoEnd.Text;
  btnExecPes.Caption := cbbOperacaoPes.Text;
end;

procedure TfrmMain.cbbOperacaoPesKeyPress(Sender: TObject; var Key: Char);
begin
 key := #0;
end;


procedure TfrmMain.btnExecPesClick(Sender: TObject);
var
  NovoCodigo : integer;

begin
  {
  if not(ValidaCPF(edtCPF.Text)) then begin
    ALERTMSG('CPF Inválido!','Favor digitar um CPF válido.',false);
    edtCPF.SetFocus;
    exit;
  end;
  }

  dmdMain.tbPessoa.Open;

  if (dmdMain.tbPessoa.RecordCount = 0) then begin
    NovoCodigo := 0;
  end else begin
    bNavega := False;
    dmdMain.tbPessoa.Last;
    NovoCodigo := dmdMain.tbPessoaid_Codigo_Pes.AsInteger +  1;
  end;

  bNavega := False;

  try
    dmdMain.tbPessoa.Append;
    dmdMain.tbPessoaid_Codigo_Pes.AsInteger     := NovoCodigo;
    dmdMain.tbPessoads_Nome_Pes.AsString        := edtNome.Text;
    dmdMain.tbPessoaid_RG_Pes.AsString          := edtRG.Text;
    dmdMain.tbPessoaid_CPF_Pes.AsString         := edtCPF.Text;
    dmdMain.tbPessoads_Tel_Pes.AsString         := edtTelefone.Text;
    dmdMain.tbPessoads_Email_Pes.AsString       := edtEmail.Text;
    dmdMain.tbPessoadt_Alteracao_Pes.AsDateTime := Now;
    dmdMain.tbPessoa.Post;
  Except
    ALERTMSG('Ops...','Houve algum erro durante a tentativa de '+cbbOperacaoPes.Text,False);
  end;

  bNavega := true;
end;


procedure TfrmMain.tbPessoaAfterScroll(DataSet: TDataSet);
begin
  if ((dmdMain.tbPessoa.RecordCount <> 0) and (bNavega)) then begin
    iCodPes          := dmdMain.tbPessoaid_Codigo_Pes.AsInteger;
    edtNome.Text     := dmdMain.tbPessoads_Nome_Pes.AsString;
    edtRG.Text       := dmdMain.tbPessoaid_RG_Pes.AsString;
    edtCPF.Text      := dmdMain.tbPessoaid_CPF_Pes.AsString;
    edtTelefone.Text := dmdMain.tbPessoads_Tel_Pes.AsString;
    edtEmail.Text    := dmdMain.tbPessoads_Email_Pes.AsString;
  end;
end;

end.
