object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Cidades IBGE - Desafio T'#233'cnico'
  ClientHeight = 500
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 24
    Top = 8
    Width = 668
    Height = 130
    TabOrder = 1
    object btnProcessar: TButton
      Left = 24
      Top = 8
      Width = 200
      Height = 40
      Caption = 'Selecionar CSV e Processar'
      TabOrder = 0
      OnClick = btnProcessarClick
    end
    object grpLoginAPI: TGroupBox
      Left = 272
      Top = 8
      Width = 385
      Height = 113
      Caption = 'Dados de login Supabase'
      TabOrder = 1
      Visible = False
      object lblEmail: TLabel
        Left = 24
        Top = 17
        Width = 34
        Height = 15
        Caption = 'E-mail'
      end
      object lblSenha: TLabel
        Left = 24
        Top = 67
        Width = 32
        Height = 15
        Caption = 'Senha'
      end
      object edtEmail: TEdit
        Left = 24
        Top = 38
        Width = 321
        Height = 23
        TabOrder = 0
      end
      object edtSenha: TEdit
        Left = 24
        Top = 87
        Width = 233
        Height = 23
        TabOrder = 1
      end
    end
  end
  object memLog: TMemo
    Left = 24
    Top = 144
    Width = 668
    Height = 348
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object dlgOpen: TOpenDialog
    Filter = 'CSV (*.csv)|*.csv'
    Left = 48
    Top = 72
  end
end
