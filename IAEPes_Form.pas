unit IAEPes_Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Sick013, dmMain_Unit;

type
  TfrmIAEPessoa = class(TForm)
    shp1: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    edtNome: TEdit;
    edtRG: TEdit;
    edtCPF: TEdit;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    btnExecPes: TButton;
    btnCancelar: TButton;
    procedure btnExecPesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure IncluirPessoa;
    procedure AlterarPessoa;
    procedure ExcluirPessoa;
    Procedure PreencheCampos;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    var strOpr  : String;
        iPessoa : integer;
        bErro   : boolean;
  end;

var
  frmIAEPessoa: TfrmIAEPessoa;


implementation

{$R *.dfm}

uses frmMain_Form;



procedure TfrmIAEPessoa.IncluirPessoa;
var
  NovoCodigo : integer;
begin
  bErro := False;

  if not(ValidaCPF(edtCPF.Text)) then begin
    ALERTMSG('CPF Inválido!','Favor digitar um CPF válido.',false);
    edtCPF.SetFocus;
    bErro := true;
    exit;
  end;

  dmdMain.tbPessoa.Open;

  if dmdMain.tbPessoa.Locate('id_CPF_Pes',edtCPF.Text) then
  begin
    ALERTMSG('CPF Duplicado!','Esse número de CPF já existe no cadastro.',false);
    edtCPF.SetFocus;
    bErro := true;
    exit;
  end;

  if dmdMain.tbPessoa.Locate('id_RG_Pes',edtRG.Text) then
  begin
    ALERTMSG('Identidade Duplicada!','Esse número de RG já existe no cadastro.',false);
    edtRG.SetFocus;
    bErro := true;
    exit;
  end;

  if (dmdMain.tbPessoa.RecordCount = 0) then begin
    NovoCodigo := 0;
  end else begin
    dmdMain.tbPessoa.Last;
    NovoCodigo := dmdMain.tbPessoaid_Codigo_Pes.AsInteger +  1;
  end;

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
    ALERTMSG('Ops...','Houve algum erro durante a tentativa de '+ Caption,False);
  end;

  dmdMain.PreencheTabelaFilha;
end;



procedure TfrmIAEPessoa.AlterarPessoa;
begin
  if not(ValidaCPF(edtCPF.Text)) then begin
    ALERTMSG('CPF Inválido!','Favor digitar um CPF válido.',false);
    edtCPF.SetFocus;
    exit;
  end;

  dmdMain.tbPessoa.Open;

  dmdMain.tbPessoa.Locate('id_Codigo_Pes',iPessoa);
  try
    dmdMain.tbPessoa.edit;
    dmdMain.tbPessoaid_Codigo_Pes.AsInteger     := iPessoa;
    dmdMain.tbPessoads_Nome_Pes.AsString        := edtNome.Text;
    dmdMain.tbPessoaid_RG_Pes.AsString          := edtRG.Text;
    dmdMain.tbPessoaid_CPF_Pes.AsString         := edtCPF.Text;
    dmdMain.tbPessoads_Tel_Pes.AsString         := edtTelefone.Text;
    dmdMain.tbPessoads_Email_Pes.AsString       := edtEmail.Text;
    dmdMain.tbPessoadt_Alteracao_Pes.AsDateTime := Now;
    dmdMain.tbPessoa.Post;
  Except
    ALERTMSG('Ops...','Houve algum erro durante a tentativa de '+ Caption,False);
  end;
end;



procedure TfrmIAEPessoa.ExcluirPessoa;
begin
  if ALERTMSG('Confirma Exclusão de Pessoa.','O registro da pessoa será apagado, deseja continuar?',true) then
  begin
    dmdMain.tbPessoa.Locate('id_Codigo_Pes',iPessoa);
    try
      dmdMain.tbPessoa.Delete;
    Except
      ALERTMSG('Ops...','Houve algum erro durante a tentativa de '+ Caption,False);
    end;

    //Apaga todos os registros dos endereços da pessoa que está sendo deletada
    while dmdMain.tbEndereco.Locate('id_Codigo_Pes',iPessoa) do
      dmdMain.tbEndereco.Delete;
  end;
end;



Procedure TfrmIAEPessoa.PreencheCampos;
begin
  edtNome.Text     := dmdMain.tbPessoads_Nome_Pes.AsString;
  edtRG.Text       := dmdMain.tbPessoaid_RG_Pes.AsString;
  edtCPF.Text      := dmdMain.tbPessoaid_CPF_Pes.AsString;
  edtTelefone.Text := dmdMain.tbPessoads_Tel_Pes.AsString;
  edtEmail.Text    := dmdMain.tbPessoads_Email_Pes.AsString;
end;



procedure TfrmIAEPessoa.btnExecPesClick(Sender: TObject);
begin
  if strOpr = 'INC' then
    IncluirPessoa;

  if strOpr = 'ALT' then
    AlterarPessoa;

  if strOpr = 'EXC' then
    ExcluirPessoa;

  if not(bErro) then begin
    dmdMain.GeraArquivoXML;
    frmIAEPessoa.Close;
  end;
end;



procedure TfrmIAEPessoa.FormShow(Sender: TObject);
begin
  frmIAEPessoa.Left := 1240;
  frmIAEPessoa.top  := 128;

  if strOpr = 'INC' then begin
    frmIAEPessoa.Caption := 'Incluir cadastro de pessoa';
    btnExecPes.Caption := '&Incluir';
  end else begin
    if strOpr = 'ALT' then begin
      frmIAEPessoa.Caption := 'Alterar cadastro de pessoa';
      btnExecPes.Caption := '&Alterar';
      PreencheCampos;
    end else begin
     if strOpr = 'EXC' then begin
        frmIAEPessoa.Caption := 'Excluir cadastro de pessoa';
        btnExecPes.Caption := '&Excluir';
        PreencheCampos;
      end else begin
        ALERTMSG('Falha no sistema.','Algo não foi bem na execução do sistema, por favor tente novamente',False);
        frmIAEPessoa.Close;
      end;
    end;
  end;

end;



procedure TfrmIAEPessoa.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  if strOpr = 'EXC' then
    key := #0;
end;

procedure TfrmIAEPessoa.btnCancelarClick(Sender: TObject);
begin
  frmIAEPessoa.Close;
end;

procedure TfrmIAEPessoa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmIAEPessoa := Nil;
end;

end.
