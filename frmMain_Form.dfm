object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de pessoas e endere'#231'os'
  ClientHeight = 590
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Shape10: TShape
    Left = -54
    Top = -2
    Width = 885
    Height = 312
    Brush.Color = 16701680
  end
  object Shape3: TShape
    Left = -63
    Top = 308
    Width = 900
    Height = 301
    Brush.Color = 16703685
  end
  object Label4: TLabel
    Left = 23
    Top = 13
    Width = 60
    Height = 16
    Caption = 'Pessoas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 22
    Top = 331
    Width = 220
    Height = 13
    Caption = 'Endere'#231'os da pessoa selecionada'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnExecPes: TButton
    Left = 267
    Top = 254
    Width = 147
    Height = 25
    Caption = '&Incluir Pessoa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnExecPesClick
  end
  object cbbOperacaoPes: TComboBox
    Left = 288
    Top = 14
    Width = 126
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ItemIndex = 0
    ParentFont = False
    TabOrder = 1
    Text = 'Incluir Pessoa'
    OnChange = cbbOperacaoEndChange
    OnKeyPress = cbbOperacaoPesKeyPress
    Items.Strings = (
      'Incluir Pessoa'
      'Alterar Pessoa'
      'Excluir Pessoa')
  end
  object btnExecEnd: TButton
    Left = 267
    Top = 537
    Width = 147
    Height = 25
    Caption = '&Incluir Endere'#231'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnExecEndClick
  end
  object cbbOperacaoEnd: TComboBox
    Left = 279
    Top = 328
    Width = 135
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ItemIndex = 0
    ParentFont = False
    TabOrder = 3
    Text = 'Incluir Endere'#231'o'
    OnChange = cbbOperacaoEndChange
    OnKeyPress = cbbOperacaoPesKeyPress
    Items.Strings = (
      'Incluir Endere'#231'o'
      'Alterar Endere'#231'o'
      'Excluir Endere'#231'o')
  end
  object grdPessoa: TDBGrid
    Left = 22
    Top = 48
    Width = 391
    Height = 200
    DataSource = dmdMain.dsPessoa
    GradientEndColor = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'ds_Nome_Pes'
        Title.Caption = 'Nome'
        Width = 195
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_RG_Pes'
        Title.Caption = 'Identidade'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_CPF_Pes'
        Title.Caption = 'CPF'
        Width = 85
        Visible = True
      end>
  end
  object grdEndereco: TDBGrid
    Left = 23
    Top = 363
    Width = 391
    Height = 168
    DataSource = dmdMain.dsEndPes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'ds_Logradouro_End'
        Title.Caption = 'Logradouro'
        Width = 310
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ds_Numero_End'
        Title.Caption = 'N'#250'mero'
        Width = 55
        Visible = True
      end>
  end
end
