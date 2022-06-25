object dmdMain: TdmdMain
  OldCreateOrder = False
  Height = 329
  Width = 498
  object tbPessoa: TFDMemTable
    AfterScroll = tbPessoaAfterScroll
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 29
    Top = 20
    object tbPessoaid_Codigo_Pes: TIntegerField
      FieldName = 'id_Codigo_Pes'
    end
    object tbPessoads_Nome_Pes: TStringField
      FieldName = 'ds_Nome_Pes'
      Size = 50
    end
    object tbPessoaid_RG_Pes: TStringField
      FieldName = 'id_RG_Pes'
      Size = 11
    end
    object tbPessoaid_CPF_Pes: TStringField
      FieldName = 'id_CPF_Pes'
      Size = 11
    end
    object tbPessoads_Tel_Pes: TStringField
      FieldName = 'ds_Tel_Pes'
      Size = 15
    end
    object tbPessoads_Email_Pes: TStringField
      FieldName = 'ds_Email_Pes'
      Size = 35
    end
    object tbPessoadt_Alteracao_Pes: TDateTimeField
      FieldName = 'dt_Alteracao_Pes'
    end
  end
  object dsPessoa: TDataSource
    DataSet = tbPessoa
    Left = 29
    Top = 76
  end
  object tbEndereco: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 93
    Top = 21
    object tbEnderecoid_Codigo_Pes: TIntegerField
      FieldName = 'id_Codigo_Pes'
    end
    object tbEnderecoid_Codigo_End: TIntegerField
      FieldName = 'id_Codigo_End'
    end
    object tbEnderecods_CEP_End: TStringField
      FieldName = 'ds_CEP_End'
      Size = 9
    end
    object tbEnderecods_Logradouro_End: TStringField
      FieldName = 'ds_Logradouro_End'
      Size = 70
    end
    object tbEnderecods_Numero_End: TStringField
      FieldName = 'ds_Numero_End'
      Size = 6
    end
    object tbEnderecods_Complemento_End: TStringField
      FieldName = 'ds_Complemento_End'
    end
    object tbEnderecods_Bairro_End: TStringField
      FieldName = 'ds_Bairro_End'
      Size = 25
    end
    object tbEnderecods_Cidade_End: TStringField
      FieldName = 'ds_Cidade_End'
      Size = 30
    end
    object tbEnderecods_Estado_End: TStringField
      FieldName = 'ds_Estado_End'
    end
    object tbEnderecods_Pais_End: TStringField
      FieldName = 'ds_Pais_End'
      Size = 25
    end
    object tbEnderecodt_Alteracao_End: TDateTimeField
      FieldName = 'dt_Alteracao_End'
    end
  end
  object dsEndereco: TDataSource
    DataSet = tbEndereco
    Left = 93
    Top = 77
  end
  object tbEndPes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 152
    object tbEndPesid_Codigo_Pes: TIntegerField
      FieldName = 'id_Codigo_Pes'
    end
    object tbEndPesid_Codigo_End: TIntegerField
      FieldName = 'id_Codigo_End'
    end
    object tbEndPesds_CEP_End: TStringField
      FieldName = 'ds_CEP_End'
      Size = 9
    end
    object tbEndPesds_Logradouro_End: TStringField
      FieldName = 'ds_Logradouro_End'
      Size = 70
    end
    object tbEndPesds_Numero_End: TStringField
      FieldName = 'ds_Numero_End'
      Size = 6
    end
    object tbEndPesds_Complemento_End: TStringField
      FieldName = 'ds_Complemento_End'
    end
    object tbEndPesds_Bairro_End: TStringField
      FieldName = 'ds_Bairro_End'
      Size = 25
    end
    object tbEndPesds_Cidade_End: TStringField
      FieldName = 'ds_Cidade_End'
      Size = 30
    end
    object tbEndPesds_Estado_End: TStringField
      FieldName = 'ds_Estado_End'
    end
    object tbEndPesds_Pais_End: TStringField
      FieldName = 'ds_Pais_End'
      Size = 25
    end
    object tbEndPesdt_Alteracao_End: TDateTimeField
      FieldName = 'dt_Alteracao_End'
    end
  end
  object dsEndPes: TDataSource
    DataSet = tbEndPes
    Left = 56
    Top = 200
  end
  object rstClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://viacep.com.br/ws/93700000/json'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 216
    Top = 24
  end
  object rstRequest: TRESTRequest
    Client = rstClient
    Params = <>
    Response = rstResponse
    SynchronizedEvents = False
    Left = 216
    Top = 72
  end
  object rstResponse: TRESTResponse
    ContentType = 'application/json'
    Left = 216
    Top = 120
  end
  object rstResponseDataSetAdapter: TRESTResponseDataSetAdapter
    Dataset = tbJSONEndereco
    FieldDefs = <>
    Response = rstResponse
    Left = 216
    Top = 168
  end
  object tbJSONEndereco: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 216
    Top = 216
  end
  object xmlPessoaEndereco: TXMLDocument
    Left = 408
    Top = 256
  end
  object IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL
    Destination = 'smtp.gmail.com:587'
    Host = 'smtp.gmail.com'
    MaxLineAction = maException
    Port = 587
    DefaultPort = 0
    SSLOptions.Mode = sslmClient
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 401
    Top = 173
  end
  object IdSMTP: TIdSMTP
    IOHandler = IdSSLIOHandlerSocket
    Host = 'smtp.gmail.com'
    Password = 'toy15308875'
    Port = 587
    SASLMechanisms = <>
    UseTLS = utUseExplicitTLS
    Username = 'vhghilardi@gmail.com'
    Left = 401
    Top = 21
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CharSet = 'UTF-8'
    CCList = <>
    ContentType = 'text/html'
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 401
    Top = 69
  end
  object IdHTTP1: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 401
    Top = 117
  end
end
