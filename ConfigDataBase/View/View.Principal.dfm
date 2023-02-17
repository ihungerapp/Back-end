object ViewPrincipal: TViewPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object pnlBase: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    BevelOuter = bvNone
    Color = 16381425
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      624
      441)
    object lblServidor: TLabel
      AlignWithMargins = True
      Left = 20
      Top = 0
      Width = 604
      Height = 32
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      AutoSize = False
      Caption = 'SERVIDOR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8678406
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object lblCadastro: TLabel
      AlignWithMargins = True
      Left = 20
      Top = 173
      Width = 604
      Height = 32
      Margins.Left = 20
      Margins.Top = 140
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      AutoSize = False
      Caption = 'CADASTRO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8678406
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitTop = 344
    end
    object pnlDescricao: TPanel
      Left = 20
      Top = 39
      Width = 200
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 200
        Height = 15
        Align = alTop
        Caption = 'Database'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8157046
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 48
      end
      object Panel3: TPanel
        Left = 0
        Top = 21
        Width = 200
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object Shape2: TShape
          Left = 0
          Top = 0
          Width = 200
          Height = 28
          Align = alClient
          Pen.Color = 15131098
          Pen.Width = 2
          Shape = stRoundRect
          ExplicitLeft = 90
          ExplicitTop = 4
          ExplicitWidth = 225
          ExplicitHeight = 65
        end
        object edtDatabase: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 190
          Height = 18
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 0
        end
      end
    end
    object pnlLine: TPanel
      AlignWithMargins = True
      Left = 20
      Top = 32
      Width = 584
      Height = 1
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Color = 15721152
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
    end
    object Panel1: TPanel
      Left = 222
      Top = 39
      Width = 200
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 200
        Height = 15
        Align = alTop
        Caption = 'Server'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8157046
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 32
      end
      object Panel2: TPanel
        Left = 0
        Top = 21
        Width = 200
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object Shape1: TShape
          Left = 0
          Top = 0
          Width = 200
          Height = 28
          Align = alClient
          Pen.Color = 15131098
          Pen.Width = 2
          Shape = stRoundRect
          ExplicitLeft = 90
          ExplicitTop = 4
          ExplicitWidth = 225
          ExplicitHeight = 65
        end
        object edtServer: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 190
          Height = 18
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 0
        end
      end
    end
    object Panel4: TPanel
      Left = 20
      Top = 95
      Width = 298
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 5
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 298
        Height = 15
        Align = alTop
        Caption = 'Username'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8157046
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 53
      end
      object Panel5: TPanel
        Left = 0
        Top = 21
        Width = 298
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object Shape3: TShape
          Left = 0
          Top = 0
          Width = 298
          Height = 28
          Align = alClient
          Pen.Color = 15131098
          Pen.Width = 2
          Shape = stRoundRect
          ExplicitLeft = 90
          ExplicitTop = 4
          ExplicitWidth = 225
          ExplicitHeight = 65
        end
        object edtUsername: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 288
          Height = 18
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 0
        end
      end
    end
    object Panel6: TPanel
      Left = 319
      Top = 95
      Width = 285
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      object Label4: TLabel
        Left = 0
        Top = 0
        Width = 285
        Height = 15
        Align = alTop
        Caption = 'Password'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8157046
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 50
      end
      object Panel7: TPanel
        Left = 0
        Top = 21
        Width = 285
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          285
          28)
        object Shape4: TShape
          Left = 0
          Top = 0
          Width = 285
          Height = 28
          Align = alClient
          Pen.Color = 15131098
          Pen.Width = 2
          Shape = stRoundRect
          ExplicitLeft = 90
          ExplicitTop = 4
          ExplicitWidth = 225
          ExplicitHeight = 65
        end
        object imgPassword: TImage
          Left = 255
          Top = 5
          Width = 30
          Height = 18
          Cursor = crHandPoint
          Anchors = [akTop, akRight]
          Center = True
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
            00181006000000B0E7E1BB0000000467414D410000B18F0BFC61050000000662
            4B4744000000000000F943BB7F0000000970485973000000600000006000F06B
            42CF0000000774494D4507E606060B2D0B1D4F94C5000002F74944415478DAED
            564B685351103D2F496DFC55DC6AAD564105A1D64D14AD4B11A5E84A4170D32A
            7E28587029F5534570D585B685B6A81B1716C445A058F7F5532C34ADB810A1A0
            8D3B17DA2AD624269E3B7762E323EF256AF02164C27D9377EFDC9939F3B9EF3A
            F8CFC909DA812A80A01DA802A89CAA7B18471DF93744D1409EE3A877994ACABF
            5ABCE5F304B6623E0800FD98C66A71238B3675F4B0A872B05BDE7388F89A7490
            21CF723CE108513EAEFC0E791B76E0632501E423FB9591ED922D399CD1B5952E
            65CF0480831E79CBE0856B3DA6FCBCCEEC72D9CA67A45FA4A2B88E5299F20130
            88045A25320E06642687351EB2BD1CB3D88E4EF20DDCB789FC3BC73ED915C252
            957B0853464D52420DCCE44DCD588787DEF7EAE26901D28C113F0097C594513C
            852BB0A5D1E58BD3467C960EB5C8BE048DD80CF4AAC412E55F2410214A02ED7C
            CE14D85B477B4F556EA70790AC02BD260168C655F26EDAC91ACF063081659C08
            B3721FE88603284DC6FC11F208633D251177F052D76A5DB2631C2769786F113D
            B709FCA8066CB80CBB267023622FCD7D8E5530AA0AF697A5C052983B1A614BE5
            A02AEEF330F881CF2816A4B48E33CE7305AB4384DF08DB5B33BF61DFD0E8BF01
            B0086402B6144C939A9232A593E57BEA6F00E44B28C2DFB002692D6B7B4E521F
            E648C0BF84DC9486ED952DAA2706DB67F7CB743C2EF6323856AC89EBE9CE25D8
            F3FAA2AE853C143D873D7DF6C034E3341BD43A946F6237909466C29C3A75788D
            BBE473D8FCB389631E76B2BAAF1BE6346A92667624673EC7E81026A5348CE0A0
            CEAD2D22E768E9BCA3E2730264121B65252CC7A80114862DB9C7E4CBF1464A65
            9E8EDF82CDF8590F1F92A23F8453EAF8A322D64B521F5E618544338D0B051134
            A6EB5CB2E3AAB247A2E6B83E648BA592FF90FD1A71079F74DD647081257D83BC
            03DBF0D9D3BB3FB84A989E59057BECB6AB9243AAAA05A5AF1286D2CAC7609B37
            2E014AC955C27D4AF953052F73F94CD5D0BDF5B0A555789933C092E27C8D7C89
            FD231B008060A80A2068AA02089A7E000E1AC93D452E3ED00000002574455874
            646174653A63726561746500323032322D30362D30365431313A34353A31312B
            30303A30309035469A0000002574455874646174653A6D6F6469667900323032
            322D30362D30365431313A34353A31312B30303A3030E168FE26000000004945
            4E44AE426082}
          OnClick = imgPasswordClick
        end
        object edtPassword: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 250
          Height = 18
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 30
          Margins.Bottom = 5
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsNone
          PasswordChar = '*'
          TabOrder = 0
        end
      end
    end
    object pnlConfirmar: TPanel
      AlignWithMargins = True
      Left = 514
      Top = 159
      Width = 92
      Height = 23
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Anchors = [akTop]
      BevelOuter = bvNone
      TabOrder = 4
      object ShapeConfirmar: TShape
        Left = 0
        Top = 0
        Width = 92
        Height = 23
        Cursor = crHandPoint
        Align = alClient
        Brush.Color = 14133797
        Pen.Color = 14133797
        Shape = stRoundRect
        ExplicitWidth = 121
        ExplicitHeight = 28
      end
      object lblConfirmar: TLabel
        Left = 0
        Top = 0
        Width = 92
        Height = 23
        Cursor = crHandPoint
        Align = alClient
        Alignment = taCenter
        Caption = 'SALVAR'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        OnClick = lblConfirmarClick
        ExplicitWidth = 45
        ExplicitHeight = 17
      end
    end
    object pnlLineCadastro: TPanel
      AlignWithMargins = True
      Left = 20
      Top = 205
      Width = 584
      Height = 1
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Color = 15721152
      ParentBackground = False
      ShowCaption = False
      TabOrder = 7
    end
    object pnlDeletar: TPanel
      Left = 392
      Top = 159
      Width = 111
      Height = 23
      Cursor = crHandPoint
      BevelOuter = bvNone
      TabOrder = 8
      object ShapeDeletar: TShape
        Left = 0
        Top = 0
        Width = 111
        Height = 23
        Cursor = crHandPoint
        Align = alClient
        Brush.Color = 16381425
        Pen.Color = 14133797
        Shape = stRoundRect
        ExplicitWidth = 121
        ExplicitHeight = 28
      end
      object lblDeletar: TLabel
        Left = 0
        Top = 0
        Width = 111
        Height = 23
        Cursor = crHandPoint
        Align = alClient
        Alignment = taCenter
        Caption = 'Testar conex'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = 14133797
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        OnClick = lblDeletarClick
        ExplicitWidth = 91
        ExplicitHeight = 17
      end
    end
    object Panel8: TPanel
      Left = 423
      Top = 39
      Width = 181
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object Label5: TLabel
        Left = 0
        Top = 0
        Width = 181
        Height = 15
        Align = alTop
        Caption = 'Porta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8157046
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 28
      end
      object Panel9: TPanel
        Left = 0
        Top = 21
        Width = 181
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object Shape5: TShape
          Left = 0
          Top = 0
          Width = 181
          Height = 28
          Align = alClient
          Pen.Color = 15131098
          Pen.Width = 2
          Shape = stRoundRect
          ExplicitLeft = 90
          ExplicitTop = 4
          ExplicitWidth = 225
          ExplicitHeight = 65
        end
        object edtPorta: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 171
          Height = 18
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 0
        end
      end
    end
    object Panel10: TPanel
      Left = 20
      Top = 215
      Width = 94
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 9
      object Label6: TLabel
        Left = 0
        Top = 0
        Width = 94
        Height = 15
        Align = alTop
        Caption = 'Vers'#227'o do sistema'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8157046
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Panel11: TPanel
        Left = 0
        Top = 21
        Width = 94
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 298
        object Shape6: TShape
          Left = 0
          Top = 0
          Width = 94
          Height = 28
          Align = alClient
          Pen.Color = 15131098
          Pen.Width = 2
          Shape = stRoundRect
          ExplicitLeft = 90
          ExplicitTop = 4
          ExplicitWidth = 225
          ExplicitHeight = 65
        end
        object lblVersao: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 0
          Width = 89
          Height = 28
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          Alignment = taCenter
          Caption = '0.0.196'
          Layout = tlCenter
          ExplicitWidth = 36
          ExplicitHeight = 15
        end
      end
    end
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=PG')
    Left = 304
    Top = 152
  end
end
