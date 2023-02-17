object WebModuleApi: TWebModuleApi
  OnCreate = WebModuleCreate
  Actions = <
    item
      Default = True
      Name = 'WebActionPadrao'
      OnAction = WebModuleApiWebActionPadraoAction
    end
    item
      MethodType = mtPost
      Name = 'webAuthorization'
      PathInfo = '/v1/authorization'
      OnAction = WebModuleApiwebAuthorizationAction
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 201
  Width = 389
  PixelsPerInch = 96
end
