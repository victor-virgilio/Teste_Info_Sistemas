unit dmMain_Unit;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Types, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, IdMessage,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdSMTP, IdBaseComponent, IdComponent, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdAttachmentFile,
  IdHTTP;

type
  TdmdMain = class(TDataModule)
    tbPessoa: TFDMemTable;
    tbPessoaid_Codigo_Pes: TIntegerField;
    tbPessoads_Nome_Pes: TStringField;
    tbPessoaid_RG_Pes: TStringField;
    tbPessoaid_CPF_Pes: TStringField;
    tbPessoads_Tel_Pes: TStringField;
    tbPessoads_Email_Pes: TStringField;
    tbPessoadt_Alteracao_Pes: TDateTimeField;
    dsPessoa: TDataSource;
    tbEndereco: TFDMemTable;
    tbEnderecoid_Codigo_Pes: TIntegerField;
    tbEnderecoid_Codigo_End: TIntegerField;
    tbEnderecods_CEP_End: TStringField;
    tbEnderecods_Logradouro_End: TStringField;
    tbEnderecods_Numero_End: TStringField;
    tbEnderecods_Complemento_End: TStringField;
    tbEnderecods_Bairro_End: TStringField;
    tbEnderecods_Cidade_End: TStringField;
    tbEnderecods_Estado_End: TStringField;
    tbEnderecods_Pais_End: TStringField;
    tbEnderecodt_Alteracao_End: TDateTimeField;
    dsEndereco: TDataSource;
    tbEndPes: TFDMemTable;
    tbEndPesid_Codigo_Pes: TIntegerField;
    tbEndPesid_Codigo_End: TIntegerField;
    tbEndPesds_CEP_End: TStringField;
    tbEndPesds_Logradouro_End: TStringField;
    tbEndPesds_Numero_End: TStringField;
    tbEndPesds_Complemento_End: TStringField;
    tbEndPesds_Bairro_End: TStringField;
    tbEndPesds_Cidade_End: TStringField;
    tbEndPesds_Estado_End: TStringField;
    tbEndPesds_Pais_End: TStringField;
    tbEndPesdt_Alteracao_End: TDateTimeField;
    dsEndPes: TDataSource;
    rstClient: TRESTClient;
    rstRequest: TRESTRequest;
    rstResponse: TRESTResponse;
    rstResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    tbJSONEndereco: TFDMemTable;
    xmlPessoaEndereco: TXMLDocument;
    IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    IdHTTP1: TIdHTTP;
    procedure tbPessoaAfterScroll(DataSet: TDataSet);

    procedure PreencheTabelaFilha;
    procedure GeraArquivoXML;
    Procedure EnviarEmail;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmdMain: TdmdMain;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses sick013;

procedure TdmdMain.PreencheTabelaFilha;
begin
  tbEndPes.Open;
  tbEndPes.EmptyDataSet;

  tbEndereco.Open;
  tbEndereco.First;
  while not tbEndereco.Eof do
  begin
    if tbEnderecoid_Codigo_Pes.AsInteger = tbPessoaid_Codigo_Pes.AsInteger then
    begin
      tbEndPes.Append;

      tbEndPesid_Codigo_Pes.AsInteger     := tbPessoaid_Codigo_Pes.AsInteger;
      tbEndPesid_Codigo_End.AsInteger     := tbEnderecoid_Codigo_End.AsInteger;
      tbEndPesds_CEP_End.AsString         := tbEnderecods_CEP_End.AsString;
      tbEndPesds_Logradouro_End.AsString  := tbEnderecods_Logradouro_End.AsString;
      tbEndPesds_Numero_End.AsString      := tbEnderecods_Numero_End.AsString;
      tbEndPesds_Complemento_End.AsString := tbEnderecods_Complemento_End.AsString;
      tbEndPesds_Bairro_End.AsString      := tbEnderecods_Bairro_End.AsString;
      tbEndPesds_Cidade_End.AsString      := tbEnderecods_Cidade_End.AsString;
      tbEndPesds_Estado_End.AsString      := tbEnderecods_Estado_End.AsString;
      tbEndPesds_Pais_End.AsString        := tbEnderecods_Pais_End.AsString;

      tbEndPes.Post;
    end;

    tbEndereco.Next;
  end;
end;



procedure TdmdMain.GeraArquivoXML;
var
  ndRaiz, ndPessoa, ndEndereco: IXMLNode;
  I: Integer;
begin
  try
    xmlPessoaEndereco.Active := True;

    ndRaiz         := xmlPessoaEndereco.AddChild('Cadastro');
    ndPessoa       := ndRaiz.AddChild('Pessoa');
    ndPessoa.ChildValues['Nome']       := tbPessoads_Nome_Pes.AsString;
    ndPessoa.ChildValues['Identidade'] := tbPessoaid_RG_Pes.AsString;
    ndPessoa.ChildValues['CPF']        := tbPessoaid_CPF_Pes.AsString;
    ndPessoa.ChildValues['Telefone']   := tbPessoads_Tel_Pes.AsString;
    ndPessoa.ChildValues['Email']      := tbPessoads_Email_Pes.AsString;

    tbEndPes.Open;
    tbEndPes.First;
    while not(tbEndPes.Eof) do
    begin
      ndEndereco := ndPessoa.AddChild('Endereco');
      ndEndereco.ChildValues['CEP']         := tbEndPesds_CEP_End.AsInteger;
      ndEndereco.ChildValues['Logradouro']  := tbEndPesds_Logradouro_End.AsString;
      ndEndereco.ChildValues['Numero']      := tbEndPesds_Numero_End.AsString;
      ndEndereco.ChildValues['Complemento'] := tbEndPesds_Complemento_End.AsString;
      ndEndereco.ChildValues['Bairro']      := tbEndPesds_Bairro_End.AsString;
      ndEndereco.ChildValues['Cidade']      := tbEndPesds_Cidade_End.AsString;
      ndEndereco.ChildValues['Estado']      := tbEndPesds_Estado_End.AsString;
      ndEndereco.ChildValues['Pais']        := tbEndPesds_Pais_End.AsString;

      tbEndPes.Next
    end;


    xmlPessoaEndereco.SaveToFile(ExtractFileDir(GetCurrentDir) + '/ArquivoXml' + IntTostr(tbPessoaid_Codigo_Pes.AsInteger) + '.xml');
  except
    ALERTMSG('Ops...','Houve algum problema durante a grava??o do arquivo XML',false)
  end;

  xmlPessoaEndereco.Active := False;
end;



Procedure TdmdMain.EnviarEmail;
var
  sAttach : String;
begin
  IdSMTP.Disconnect;

  //Configurta??o SSL
  IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
  IdSSLIOHandlerSocket.SSLOptions.Mode   := sslmClient;

  // Configura??o do SMTP
   IdSMTP.IOHandler := IdSSLIOHandlerSocket;
  IdSMTP.UseTLS    := utUseImplicitTLS;
  IdSMTP.AuthType  := satDefault;
  IdSMTP.Port      := 465;
  IdSMTP.Host      := 'smtp.kinghost.net';           //'smtp.gmail.com'
  IdSMTP.Username  := 'ghisistemas@ghisistemas.com'; //'teste.smtp.info.sistemas@gmail.com'
  IdSMTP.Password  := 'Toy07!530';                   //'testeinfosistemas';

  // Mensagem
  IdMessage.From.Address           := 'ghisistemas@ghisistemas.com';
  IdMessage.From.Name              := 'Cadastro de pessoas e endere?os';
  IdMessage.ReplyTo.EMailAddresses := '';
  IdMessage.Recipients.Add.Text    := tbPessoads_Email_Pes.AsString;
  IdMessage.Subject                := 'Cadastro de pessoa e endere?os atualizado.';
  IdMessage.ContentType            := 'multipart/alternative';
  IdMessage.ContentDisposition     := 'inline';
  IdMessage.Encoding               := meMIME;
  IdMessage.Body.Clear;
  IdMessage.Body.Add('Segue em anexo um arquivo xml, gerado pelo cadastro de pessoas e endere?os.');

  sAttach := ExtractFileDir(GetCurrentDir) + '\ArquivoXml' + tbPessoaid_Codigo_Pes.asString + '.xml';

  if FileExists(sAttach) then
    TIdAttachmentFile.create(IdMessage.MessageParts, TFileName(sAttach));

  // Conex?o e autentica??o
  try
    IdSMTP.Connect;
    IdSMTP.Authenticate;
  except
    on E:Exception do
    begin
      ALERTMSG('Ops...','Houve algum problema durante a conex?o/autentica??o com o servidor de Email.',false);
      Exit;
    end;
  end;

  // Envio da mensagem
  try
    IdSMTP.Send(IdMessage);
  except
    On E:Exception do
    begin
      ALERTMSG('Ops...','Houve algum problema durante o envio do Email com xml anexo.',false);
      Exit;
    end;
  end;

  ALERTMSG('Sucesso!','Um email com o XML em anexo foi enviado para ' + tbPessoads_Email_Pes.AsString,false);
  // desconecta do servidor
  IdSMTP.Disconnect;
end;



procedure TdmdMain.tbPessoaAfterScroll(DataSet: TDataSet);
begin
  PreencheTabelaFilha;
end;

end.
