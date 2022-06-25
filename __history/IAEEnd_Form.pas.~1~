unit IAEEnd_Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmIAEEndereco = class(TForm)
    Shape3: TShape;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtCEP: TEdit;
    edtLogradouro: TEdit;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtEstado: TEdit;
    edtPais: TEdit;
    btnExecEnd: TButton;
    btnCancelar: TButton;

    procedure IncluirEndereco;
    procedure AlterarEndereco;
    procedure ExcluirEndereco;
    Procedure PreencheCampos;
    Procedure GetJSONCEP;

    function  ValidaCEP(CEP: String):Boolean;

    procedure btnExecEndClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCEPKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCEPExit(Sender: TObject);
    procedure edtLogradouroKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    var
      strOpr    : string;
      iEndereco : integer;
      bErro     : Boolean;
  end;

var
  frmIAEEndereco: TfrmIAEEndereco;

implementation

{$R *.dfm}

uses frmMain_Form, dmMain_Unit, SICK013;



procedure TfrmIAEEndereco.IncluirEndereco;
var
  iCodigo : integer;
begin
  bErro := False;

  dmdMain.tbEndereco.Open;

  if (dmdMain.tbEndereco.RecordCount = 0) then begin
    iCodigo := 0;
  end else begin
    dmdMain.tbEndereco.Last;
    iCodigo := dmdMain.tbEnderecoid_Codigo_End.AsInteger +  1;
  end;

  try
    dmdMain.tbEndereco.Append;
    dmdMain.tbEnderecoid_Codigo_Pes.AsInteger     := dmdMain.tbPessoaid_Codigo_Pes.AsInteger;
    dmdMain.tbEnderecoid_Codigo_End.AsInteger     := iCodigo;
    dmdMain.tbEnderecods_CEP_End.AsString         := edtCEP.Text;
    dmdMain.tbEnderecods_Logradouro_End.AsString  := edtLogradouro.Text;
    dmdMain.tbEnderecods_Numero_End.AsString      := edtNumero.Text;
    dmdMain.tbEnderecods_Complemento_End.AsString := edtComplemento.Text;
    dmdMain.tbEnderecods_Bairro_End.AsString      := edtBairro.Text;
    dmdMain.tbEnderecods_Cidade_End.AsString      := edtCidade.Text;
    dmdMain.tbEnderecods_Estado_End.AsString      := edtEstado.Text;
    dmdMain.tbEnderecods_Pais_End.AsString        := edtPais.Text;
    dmdMain.tbEnderecodt_Alteracao_End.AsDateTime := Now;
    dmdMain.tbEndereco.Post;
  Except
    ALERTMSG('Ops...','Houve algum erro durante a tentativa de '+ Caption,False);
  end;
end;



procedure TfrmIAEEndereco.AlterarEndereco;
begin
  dmdMain.tbEndereco.Open;
  dmdMain.tbEndereco.Locate('id_Codigo_End',iEndereco);
  try
    dmdMain.tbEndereco.edit;
    dmdMain.tbEnderecoid_Codigo_Pes.AsInteger     := dmdMain.tbPessoaid_Codigo_Pes.AsInteger;
    dmdMain.tbEnderecoid_Codigo_End.AsInteger     := iEndereco;
    dmdMain.tbEnderecods_CEP_End.AsString         := edtCEP.Text;
    dmdMain.tbEnderecods_Logradouro_End.AsString  := edtLogradouro.Text;
    dmdMain.tbEnderecods_Numero_End.AsString      := edtNumero.Text;
    dmdMain.tbEnderecods_Complemento_End.AsString := edtComplemento.Text;
    dmdMain.tbEnderecods_Bairro_End.AsString      := edtBairro.Text;
    dmdMain.tbEnderecods_Cidade_End.AsString      := edtCidade.Text;
    dmdMain.tbEnderecods_Estado_End.AsString      := edtEstado.Text;
    dmdMain.tbEnderecods_Pais_End.AsString        := edtPais.Text;
    dmdMain.tbEnderecodt_Alteracao_End.AsDateTime := Now;
    dmdMain.tbEndereco.Post;
  Except
    ALERTMSG('Ops...','Houve algum erro durante a tentativa de '+ Caption,False);
  end;
end;



procedure TfrmIAEEndereco.ExcluirEndereco;
begin
  if ALERTMSG('Confirma Exclusão do endereço.','O registro do endereço será apagado, deseja continuar?',true) then
  begin
    dmdMain.tbEndereco.Locate('id_Codigo_End',iEndereco);
    try
      dmdMain.tbEndereco.Delete;
    Except
      ALERTMSG('Ops...','Houve algum erro durante a tentativa de '+ Caption,False);
    end;
  end;
end;



Procedure TfrmIAEEndereco.PreencheCampos;
begin
  iEndereco           := dmdMain.tbEndPesid_Codigo_End.AsInteger;
  edtCEP.Text         := dmdMain.tbEndPesds_CEP_End.AsString;
  edtLogradouro.Text  := dmdMain.tbEndPesds_Logradouro_End.AsString;
  edtNumero.Text      := dmdMain.tbEndPesds_Numero_End.AsString;
  edtComplemento.Text := dmdMain.tbEndPesds_Complemento_End.AsString;
  edtBairro.Text      := dmdMain.tbEndPesds_Bairro_End.AsString ;
  edtCidade.Text      := dmdMain.tbEndPesds_Cidade_End.AsString ;
  edtEstado.Text      := dmdMain.tbEndPesds_Estado_End.AsString;
  edtPais.Text        := dmdMain.tbEndPesds_Pais_End.AsString;
end;



procedure TfrmIAEEndereco.btnExecEndClick(Sender: TObject);
begin
  if strOpr = 'INC' then
    IncluirEndereco;

  if strOpr = 'ALT' then
    AlterarEndereco;

  if strOpr = 'EXC' then
    ExcluirEndereco;

  dmdMain.PreencheTabelaFilha;

  if not(bErro) then begin
    dmdMain.GeraArquivoXML;
    frmIAEEndereco.Close;
  end;
end;



procedure TfrmIAEEndereco.FormShow(Sender: TObject);
begin
  frmIAEEndereco.Left := 1235;
  frmIAEEndereco.top  := 540;

  if strOpr = 'INC' then begin
    frmIAEEndereco.Caption := 'Incluir endereço';
    btnExecEnd.Caption := '&Incluir';
  end else begin
    if strOpr = 'ALT' then begin
      frmIAEEndereco.Caption := 'Alterar endereço';
      btnExecEnd.Caption := '&Alterar';
      PreencheCampos;
    end else begin
     if strOpr = 'EXC' then begin
        frmIAEEndereco.Caption := 'Excluir endereço';
        btnExecEnd.Caption := '&Excluir';
        PreencheCampos;
      end else begin
        ALERTMSG('Falha no sistema.','Algo não foi bem na execução do sistema, por favor tente novamente',False);
        frmIAEEndereco.Close;
      end;
    end;
  end;
end;

function TfrmIAEEndereco.ValidaCEP(CEP: String):Boolean;
begin
  result := true;
  if length(edtCEP.Text) <> 8 then begin
    ALERTMSG('Atenção','O CEP digitado não é um CEP válido.',false) ;
    edtLogradouro.SetFocus;
    result := False;
  end;
end;



procedure TfrmIAEEndereco.edtCEPExit(Sender: TObject);
begin
  if strOpr = 'EXC' then
    exit;

  if not(ValidaCEP(edtCEP.Text)) then
  begin
    edtLogradouro.SetFocus;
  end else begin
    dmdMain.rstClient.BaseURL := 'https://viacep.com.br/ws/' + edtCEP.Text + '/json/';

    try
      dmdMain.rstRequest.Execute
    except
      ALERTMSG('Aviso','O CEP digitado não existe na base do Via CEP.',false);
    end;

    if ((dmdMain.rstRequest.Response.StatusCode = 200) or (dmdMain.rstRequest.Response.StatusCode = 0)) then
    begin
      if not dmdMain.tbJSONEndereco.IsEmpty then
        getJSONCEP
      else
        ShowMessage('Número OK, porém JSON NÃO retornou dados');
    end
    else
    begin
      if (dmdMain.rstRequest.Response.StatusCode = 400) then
        ShowMessage('CEP não enocontrado na base do Via Cep.')
      else
        ShowMessage('Houve um erro não tratado pelo sistema');
    end;
  end;
end;



Procedure TfrmIAEEndereco.getJSONCEP;
begin
    if dmdMain.tbJSONEndereco.fields.Count > 1 then
    begin
      edtLogradouro.Text  := dmdMain.tbJSONEndereco.FieldByName('logradouro').AsString;
      edtComplemento.Text := dmdMain.tbJSONEndereco.FieldByName('complemento').AsString;
      edtBairro.Text      := dmdMain.tbJSONEndereco.FieldByName('bairro').AsString;
      edtCidade.Text      := dmdMain.tbJSONEndereco.FieldByName('localidade').AsString;
      edtEstado.Text      := dmdMain.tbJSONEndereco.FieldByName('uf').AsString;
      edtPais.Text        := 'BRASIL';
    end else
      ALERTMSG('Aviso', 'CEP não enocontrado na base do Via Cep.',false );
end;

procedure TfrmIAEEndereco.edtCEPKeyPress(Sender: TObject; var Key: Char);
begin
  if ((strOpr = 'EXC') or not (EDITCOD(key))) then
    key := #0;
end;

procedure TfrmIAEEndereco.edtLogradouroKeyPress(Sender: TObject; var Key: Char);
begin
  if strOpr = 'EXC' then
    key := #0;
end;

procedure TfrmIAEEndereco.btnCancelarClick(Sender: TObject);
begin
  frmIAEEndereco.Close;
end;

procedure TfrmIAEEndereco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmIAEEndereco := Nil;
end;




end.
