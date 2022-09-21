unit MercLivre;

interface

uses
  System.SysUtils,REST.Types,json,System.DateUtils,UserInfo,
  UserEndereco,System.Classes,
  System.Generics.Collections, FireDAC.Comp.Client,RESTRequest4D;

const
  ML_APIBASE                                 = 'https://api.mercadolibre.com';
  ML_POST_REFRESHTOKEN                       = '/oauth/token?grant_type=refresh_token&client_id={app_id}&client_secret={secret_key}&refresh_token={refresh_token}';
  ML_POST_AUTORIZATION                       = 'https://auth.mercadolivre.com.br/authorization?response_type=code&client_id={app_id}&redirect_uri=http://localhost/redirect';
  ML_GET_CATEGORIES_SITE                     = '/sites/MLB/categories';
  ML_GET_CATEGORIES_INFO                     = '/categories/{category_id}';
  ML_GET_CATEGORIE_ATTRIBUTTES               = '/categories/{category_id}/attributes';
  ML_GET_CATEGORIE_SEARCH                    = '/sites/MLB/domain_discovery/search?q={produto}';
  ML_GET_USERTEST                            = '/users/test_user';
  ML_GET_MODOSENVIO                          = '/users/{user_id}';
  ML_GET_LISTING_TYPES                       = '/sites/MLB/listing_types';
  ML_POST_ITEM                               = '/items';
  ML_GET_ITEM                                = '/items/{item_id}';
  ML_PUT_ITEM                                = '/items/{item_id}';
  ML_POST_ITEM_RELIST                        = '/items/{item_id}/relist';
  ML_UPLOAD_PICTURE                          = '/pictures';
  ML_LISTING_PRICES_LIST_TYPE_CATEGORY       = '/sites/MLB/listing_prices/{listing_type}?category_id={category_id}&price={price}';
  ML_SHIPPING_OPTIONS                        = '/users/{user_id}/shipping_options/free?currency_id=BRL&listing_type_id={listing_type_id}&condition=new&category_id={category_id}&item_price={item_price}&verbose=true&dimensions={dimensions}';
  ML_SHIPPING_DIMENSION                      = '/categories/{category_id}/shipping_preferences';
  ML_GET_ORDER                               = '/orders/{order_id}';
  ML_GET_ORDER_BILLING_INFO                  = '/orders/{order_id}/billing_info';
  ML_GET_SHIPIMENT                           = '/shipments/{shipping_id}';
  ML_GET_SHIPIING_LIST                       = '/sites/MLB/shipping_methods';
  ML_GET_SHIPIMENT_BILLING_INFO              = '/shipments/{shipping_id}/billing_info';
  ML_GET_USR_INF                             = '/users/{cust_id}';
  ML_GET_USR_INF_REGEX                       = '/users/:cust_id';
  ML_GET_USR_LOGIN                           = '/users/me';
  ML_GET_USR_ADDRESSES                       = '/users/{cust_id}/addresses';
  ML_GET_USR_ACCEPTED_PAYMENT_METHODS        = '/users/{cust_id}/accepted_payment_methods';
  ML_GET_APP_INF                             = '/applications/{application_id}';
  ML_GET_USR_BRANDS                          = '/users/{user_id}/brands';
  ML_GET_USR_CLASSIFIEDS_PROMOTION_PACKS     = '/users/{user_id}/classifieds_promotion_packs';
  ML_GET_USR_CLASSIFIEDS_PROMOTION_PACKS_EXT = '/users/{user_id}/classifieds_promotion_packs/{listing_type}&categoryId={category_id}';
  ML_GET_USR_AVAILABLE_LISTING_TYPES         = '/users/{Cust_id}/available_listing_types?category_id={Category_id}';
  ML_GET_USR_AVAILABLE_LISTING_TYPES_EXT     = '/users/{Cust_id}/available_listing_type/{listing_type_id}?category_id={Category_id}';
  ML_DELETE_USR_APPLICATIONS                 = '/users/{user_id}/applications/{app_id}';
  ML_GET_MYFEEDS                             = '/myfeeds?app_id={app_id}';
  ML_PEDIDOS_VENDEDOR                        = '/orders/search?seller={seller_id}';

type TRetorno=record
     StatusCode:Integer;
     Mensagem:string;
     IdPublicacao:string;
end;



type TGrupos=class
     Id:string;
     Descricao:string;
end;

type TMetodos=class
     Id:string;
     Descricao:string;
end;

type
  TMercadoLivre = class(TComponent)
  private
    FClientID: string;
    FClientSecret: string;
    FAccessToken: string;
    FRefreshToken: string;
    FuserID: string;
    FCaminhoArquivoToken: string;
    FDataToken: TDate;
    FHoraToken: TTime;
    procedure SetClientID(const Value: string);
    procedure SetClientSecret(const Value: string);
    procedure SetAccessToken(const Value: string);
    procedure SetRefreshToken(const Value: string);
    procedure SetuserID(const Value: string);
    procedure SetCaminhoArquivoToken(const Value: string);
    procedure SetDataToken(const Value: TDate);
    procedure SetHoraToken(const Value: TTime);
  protected

  public
    Retorno : Tretorno;
    UserInfo:TUserInfo;
    UserEndereco:TEndereco;
    Grupos: TList<TGrupos>;
    Metodos: TList<TMetodos>;
    function ConsultaInformacoesdoUsuario:TRetorno;
    function GetToken:TRetorno;
    function RefreshToken:TRetorno;
    function EnderecoUsuario:TRetorno;
    function ConsultaGrupos(DescricaoProduto:string):TGrupos;
    function ConsultaMetodosEnvio:TMetodos;
    function PublicarProduto(Ean: string; CodigoInterno: string; Descricao: string; Marca:string; Modelo:String; URLImg:string;Valor:Extended;CategoriaML:string;Estoque:Extended):TRetorno;
    function AlteraPublicacao(IdPublicacao:string;Ean: string; CodigoInterno: string; Descricao: string; Marca:string; Modelo:string; URLImg:string;Valor:Extended;Estoque:Extended):TRetorno;
    function DesativarPublicacao(IdPublicacao:string):TRetorno;
    function ExcluirPublicacao(IdPublicacao:string):TRetorno;
    function ReativarPublicacao(IdPublicacao:string;Estoque:Extended):TRetorno;
    function ObterPedidosPorVendedor(IdVendedor:string):Tretorno;
    function ConsultaAtributosDaCategoria(Categoria:string):TRetorno;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property userID: string read FuserID write SetuserID;
    property ClientID: string read FClientID write SetClientID;
    property ClientSecret: string read FClientSecret write SetClientSecret;
    property AccessToken: string read FAccessToken write SetAccessToken;
    property Refresh_Token: string read FRefreshToken write SetRefreshToken;
    property CaminhoArquivoToken: string read FCaminhoArquivoToken write SetCaminhoArquivoToken;
    property DataToken:TDate read FDataToken write SetDataToken;
    property HoraToken:TTime read FHoraToken write SetHoraToken;
  end;

procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('DT Inovacao', [TMercadoLivre]);
end;

{ TMercadoLivre }

function TMercadoLivre.AlteraPublicacao(IdPublicacao, Ean, CodigoInterno,
  Descricao, Marca, Modelo, URLImg: string; Valor: Extended;
  Estoque: Extended): TRetorno;
var
  LResponse: RESTRequest4D.IResponse;
begin
  GetToken;

  LResponse := RESTRequest4D.TRequest.New
               .BaseURL(ML_APIBASE)
               .Resource(ML_PUT_ITEM)
               .AddBody('{'+
                        '"attributes": ['+
                        '{'+
                        '"id": "BRAND",'+
                        '"value_name": "'+ Marca  +'"'+
                        '},'+

                        '{'+
                        '"id": "EAN",'+
                        '"value_name": "'+ Ean +'"'+
                        '}'+

                        ', { ' +
                        ' "id": "MODEL", ' +
                        ' "name": "Modelo", ' +
                        ' "value_id": null, ' +
                        ' "value_name": "'+ Modelo  +'", ' +
                        ' "value_struct": null, ' +
                        ' "values": [ ' +
                        ' { ' +
                        ' "id": null, ' +
                        ' "name": "'+ Modelo +'", ' +
                        ' "struct": null ' +
                        ' } ' +
                        ' ] ' +
                        ' } ' +

                        ',{'+
                        '"id": "SKU",'+
                        '"value_name": "'+ CodigoInterno +'"'+
                        '}'+

                        '],'+
                        '"available_quantity": ' + FloatToStr(valor).Replace(',','.') + ','+
                        '"buying_mode": "buy_it_now",'+
                       // '"category_id": "'+ CategoriaML +'",'+
                        '"condition": "new",'+
                        '"currency_id": "BRL",'+
                       // '"listing_type_id": "gold_special",'+
                        '"pictures": ['+
                        '{'+
                        '"source": "'+ URLImg +'"'+
                        '}'+
                        '],'+
                        '"price": '+ FloatToStr(Valor).Replace(',','.') +','+
                        '"title": "'+ Descricao +'"'+
                        '}' )
               .AddUrlSegment('cust_id', FuserID)
               .AddUrlSegment('item_id', IdPublicacao)
               .Token('Bearer ' + FAccessToken)
               .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
               .RaiseExceptionOn500(True)
               .Put;

               Retorno.StatusCode := LResponse.StatusCode;
               Retorno.Mensagem   := LResponse.Content;
end;

function TMercadoLivre.ConsultaAtributosDaCategoria(
  Categoria: string): TRetorno;
var
LResponse: RESTRequest4D.IResponse;
Grup:TGrupos;
obj:TJSONObject;
Lista:TJSONArray;
i:integer;
Id_Categoria,Nome_Categoria:string;
LJsonArr   : TJSONArray;
LJsonValue : TJSONValue;
LItem     : TJSONValue;
begin
  GetToken;

  LResponse := RESTRequest4D.TRequest.New
               .BaseURL(ML_APIBASE)
               .Resource(ML_GET_CATEGORIE_ATTRIBUTTES)
               .AddUrlSegment('category_id', Categoria)
               .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
               .RaiseExceptionOn500(True)
               .Get;
     retorno.statuscode := lresponse.statuscode;
     Retorno.Mensagem   := LResponse.Content;

//   LJsonArr    := tjsonarray.create;
//   LJsonArr    := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LResponse.content),0) as TJSONArray;
//   for LJsonValue in LJsonArr do
//   begin
//      for LItem in TJSONArray(LJsonValue) do
//      begin
//              if TJSONPair(LItem).JsonString.Value='required_attributes' then
//               Id_Categoria := TJSONPair(LItem).JsonValue.Value;
//
//              if TJSONPair(LItem).JsonString.Value='category_name' then
//               Nome_Categoria := TJSONPair(LItem).JsonValue.Value;
//              if (Id_Categoria<>'') and (Nome_Categoria<>'') then
//              begin
//                  Grup           := tgrupos.Create;
//                  Grup.Id        := Id_Categoria;
//                  Grup.Descricao := Nome_Categoria;
//
//                  Grupos.Add(Grup);
//                  Id_Categoria   := '';
//                  Nome_Categoria := '';
//              end;
//      end;
//   end;

end;

function TMercadoLivre.ConsultaGrupos(DescricaoProduto:string): TGrupos;
var
LResponse: RESTRequest4D.IResponse;
Grup:TGrupos;
obj:TJSONObject;
Lista:TJSONArray;
i:integer;
Id_Categoria,Nome_Categoria:string;
LJsonArr   : TJSONArray;
LJsonValue : TJSONValue;
LItem     : TJSONValue;
begin
  GetToken;

  LResponse := RESTRequest4D.TRequest.New
               .BaseURL(ML_APIBASE)
               .Resource(ML_GET_CATEGORIE_SEARCH)
               .AddUrlSegment('produto', DescricaoProduto)
               .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
               .RaiseExceptionOn500(True)
               .Get;

   LJsonArr    := tjsonarray.create;
   LJsonArr    := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LResponse.content),0) as TJSONArray;
   for LJsonValue in LJsonArr do
   begin
      for LItem in TJSONArray(LJsonValue) do
      begin
              if TJSONPair(LItem).JsonString.Value='category_id' then
               Id_Categoria := TJSONPair(LItem).JsonValue.Value;

              if TJSONPair(LItem).JsonString.Value='category_name' then
               Nome_Categoria := TJSONPair(LItem).JsonValue.Value;
              if (Id_Categoria<>'') and (Nome_Categoria<>'') then
              begin
                  Grup           := tgrupos.Create;
                  Grup.Id        := Id_Categoria;
                  Grup.Descricao := Nome_Categoria;

                  Grupos.Add(Grup);
                  Id_Categoria   := '';
                  Nome_Categoria := '';
              end;
      end;
   end;
   retorno.statuscode := lresponse.statuscode;
   Retorno.Mensagem   := LResponse.Content;
end;

function TMercadoLivre.ConsultaInformacoesdoUsuario: TRetorno;
var
LResponse: RESTRequest4D.IResponse;
JSonValue : TJSonValue;
obj:TJSonObject;
arq: TextFile;
i,n:integer;
begin
  GetToken;
  try
          LResponse := RESTRequest4D.TRequest.New
                       .BaseURL(ML_APIBASE)
                       .Resource(ML_GET_USR_INF_REGEX)
                       .AddUrlSegment('cust_id', FuserID)
                       .Token('Bearer ' + FAccessToken)
                       .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
                       .RaiseExceptionOn500(True)
                       .Get;

                       Retorno.StatusCode := LResponse.StatusCode;
                       Retorno.Mensagem   := LResponse.Content;

                       UserInfo.AsJson := LResponse.Content;
  finally

  end;
end;

function TMercadoLivre.ConsultaMetodosEnvio: TMetodos;
var
  LResponse: RESTRequest4D.IResponse;
  Memtable:Tfdmemtable;
  MtEnvio:TMetodos;
begin
  GetToken;

  Memtable := Tfdmemtable.Create(nil);

  LResponse := RESTRequest4D.TRequest.New
               .BaseURL(ML_APIBASE)
               .Resource(ML_GET_SHIPIING_LIST)
               .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
               .RaiseExceptionOn500(True)
               .DataSetAdapter(Memtable)
               .Get;

  Memtable.First;
  while not Memtable.Eof do
  begin
       MtEnvio  := TMetodos.Create;
       MtEnvio.Id        := Memtable.FieldByName('id').AsString;
       MtEnvio.Descricao := Memtable.FieldByName('name').AsString;
       Metodos.Add(MtEnvio);

       Memtable.Next;
  end;
  FreeAndNil(Memtable);
end;

constructor TMercadoLivre.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
      UserInfo     := TUserInfo.Create;
      UserEndereco := TEndereco.Create;
      Grupos       := TList<TGrupos>.Create;
      Metodos      := TList<TMetodos>.Create;
end;

function TMercadoLivre.DesativarPublicacao(IdPublicacao: string): TRetorno;
var
  LResponse: RESTRequest4D.IResponse;
begin
  GetToken;

  LResponse := RESTRequest4D.TRequest.New
               .BaseURL(ML_APIBASE)
               .Resource(ML_PUT_ITEM)
               .AddBody('{'+

                        '"available_quantity": 0,'+

                        '}' )
               .AddUrlSegment('cust_id', FuserID)
               .AddUrlSegment('item_id', IdPublicacao)
               .Token('Bearer ' + FAccessToken)
               .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
               .RaiseExceptionOn500(True)
               .Put;

               Retorno.StatusCode := LResponse.StatusCode;
               Retorno.Mensagem   := LResponse.Content;
end;

destructor TMercadoLivre.Destroy;
begin
      Grupos.Clear;
      Metodos.Clear;

      FreeAndNil(UserInfo);
      FreeAndNil(UserEndereco);
      FreeAndNil(Grupos);
      FreeAndNil(Metodos);

  inherited Destroy;
end;

function TMercadoLivre.EnderecoUsuario: TRetorno;
var
LResponse: RESTRequest4D.IResponse;
begin
  GetToken;

  LResponse := RESTRequest4D.TRequest.New
               .BaseURL(ML_APIBASE)
               .Resource(ML_GET_USR_ADDRESSES)
               .AddUrlSegment('cust_id', userID)
               .Token('Bearer ' + FAccessToken)
               .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
               .RaiseExceptionOn500(True)
               .Get;

   Retorno.StatusCode := LResponse.StatusCode;
   Retorno.Mensagem   := LResponse.Content;

   UserEndereco.AsJson := LResponse.Content;
end;

function TMercadoLivre.ExcluirPublicacao(IdPublicacao: string): TRetorno;
var
  LResponse: RESTRequest4D.IResponse;
begin
  GetToken;

  LResponse := RESTRequest4D.TRequest.New
               .BaseURL(ML_APIBASE)
               .Resource(ML_PUT_ITEM)
               .AddBody('{'+

                        '"status": "closed"' +

                        '}' )
               .AddUrlSegment('cust_id', FuserID)
               .AddUrlSegment('item_id', IdPublicacao)
               .Token('Bearer ' + FAccessToken)
               .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
               .RaiseExceptionOn500(True)
               .Put;

   LResponse := RESTRequest4D.TRequest.New
               .BaseURL(ML_APIBASE)
               .Resource(ML_PUT_ITEM)
               .AddBody('{'+

                        '"deleted":"true"' +

                        '}' )
               .AddUrlSegment('cust_id', FuserID)
               .AddUrlSegment('item_id', IdPublicacao)
               .Token('Bearer ' + FAccessToken)
               .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
               .RaiseExceptionOn500(True)
               .Put;


               Retorno.StatusCode := LResponse.StatusCode;
               Retorno.Mensagem   := LResponse.Content;

end;

function TMercadoLivre.GetToken: TRetorno;
var
arq: TextFile;
linha: string;
ExpiraData:TDateTime;
ExpiraHora:TDateTime;
Data,Hora:string;
SaveStrings: TStringList;
begin
       if not fileexists(FCaminhoArquivoToken + 'token.ml') then
       begin
             try
                  SaveStrings := TStringList.Create;

                  if FileExists(FCaminhoArquivoToken + 'token.ml') then
                  begin
                     DeleteFile(FCaminhoArquivoToken + 'token.ml');
                  end;

                  SaveStrings.Add('access_token='  + FAccessToken);
                  SaveStrings.Add('user_id='       + FuserID);
                  SaveStrings.Add('refresh_token=' + FRefreshToken);
                  SaveStrings.Add('data='          + DateToStr(date));
                  SaveStrings.Add('ExpiraData='    + DateTimeToStr(IncHour(now,-6)));
                  SaveStrings.Add('hora='          + TimeToStr( IncHour(now,-6)));

                  SaveStrings.SaveToFile(FCaminhoArquivoToken + 'token.ml');
             finally
              FreeAndNil(SaveStrings);
             end;
       end;

       AssignFile(arq, FCaminhoArquivoToken + 'token.ml');
       Reset(arq);

       while (not eof(arq)) do
         begin
           readln(arq, linha);

           if Pos('data',linha)<>0 then
           DataToken := StrToDate(Copy(linha,6));

           if Pos('hora',linha)<>0 then
           HoraToken := strtotime(Copy(linha,6));

           if Pos('user_id',linha)<>0 then
           FuserID := Copy(linha,9);

           if Pos('ExpiraData',linha)<>0 then
           ExpiraData := StrToDateTime(Copy(linha,12));

           if Pos('access_token',linha)<>0 then
           FAccessToken := Copy(linha,14);
         end;

         CloseFile(arq);

         if (ExpiraData) < (now) then
         begin
               RefreshToken;
               GetToken;
         end;
end;

function TMercadoLivre.ObterPedidosPorVendedor(IdVendedor: string): Tretorno;
var
LResponse: RESTRequest4D.IResponse;
begin
  GetToken;

  LResponse := RESTRequest4D.TRequest.New
               .BaseURL(ML_APIBASE)
               .Resource(ML_PEDIDOS_VENDEDOR)
               .AddUrlSegment('seller_id', userID)
               .Token('Bearer ' + FAccessToken)
               .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
               .RaiseExceptionOn500(True)
               .Get;

   Retorno.StatusCode := LResponse.StatusCode;
   Retorno.Mensagem   := LResponse.Content;
end;

function TMercadoLivre.PublicarProduto(Ean, CodigoInterno, Descricao, Marca, Modelo,
   URLImg: string; Valor: Extended;CategoriaML:string;Estoque:Extended): TRetorno;
var
  LResponse: RESTRequest4D.IResponse;
  obj: TJsonObject;
begin
  TRY
      TRY
        GetToken;

        LResponse := RESTRequest4D.TRequest.New
                     .BaseURL(ML_APIBASE)
                     .Resource(ML_POST_ITEM)
                     .AddBody('{'+
                              '"attributes": ['+
                              '{'+
                              '"id": "BRAND",'+
                              '"value_name": "'+ Marca  +'"'+
                              '}'+
                              ',{'+

                              '"id": "EAN",'+
                              '"value_name": "'+ Ean +'"'+
                              '}'+

                              ', { ' +
                              ' "id": "MODEL", ' +
                              ' "name": "Modelo", ' +
                              ' "value_id": null, ' +
                              ' "value_name": "'+ Modelo  +'", ' +
                              ' "value_struct": null, ' +
                              ' "values": [ ' +
                              ' { ' +
                              ' "id": null, ' +
                              ' "name": "'+ Modelo +'", ' +
                              ' "struct": null ' +
                              ' } ' +

//                               ',{ "id": "DISPLAY_SIZE", ' +
//                               ' "name": "Tamanho da tela", '+
//                               ' "value_id": null, '+
//                               ' "value_name": "5.8 polegadas", '+
//                               ' "value_struct": { ' +
//                               '     "number": 5.8,' +
//                               '     "unit": "polegadas"  ' +
//                               ' }} ' +

                              ' ] ' +
                              ' } ' +

                              ',{'+
                              '"id": "SKU",'+
                              '"value_name": "'+ CodigoInterno +'"'+
                              '}'+

                              '],'+
                              '"available_quantity": ' + FloatToStr(valor).Replace(',','.') + ','+
                              '"buying_mode": "buy_it_now",'+
                              '"category_id": "'+ CategoriaML +'",'+
                              '"condition": "new",'+
                              '"currency_id": "BRL",'+
                              '"listing_type_id": "gold_special",'+
                              '"pictures": ['+
                              '{'+
                              '"source": "'+ URLImg +'"'+
                              '}'+
                              '],'+
                              '"price": '+ FloatToStr(Valor).Replace(',','.') +','+
                              '"title": "'+ Descricao +'"'+
                              '}' )
                     .AddUrlSegment('cust_id', FuserID)
                     .Token('Bearer ' + FAccessToken)
                     .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
                     .RaiseExceptionOn500(True)
                     .Post;

                      obj := TJsonObject.create;
                      obj := TJsonObject.ParseJSONValue(LResponse.Content) as TJsonObject;
                      try
                          Retorno.IdPublicacao := obj.GetValue('id').value;
                      finally
                          obj.Free;
                      end;
                      Retorno.StatusCode := LResponse.StatusCode;
                      Retorno.Mensagem   := LResponse.Content;
      except ON E:Exception do
      begin
           Retorno.StatusCode := LResponse.StatusCode;
           Retorno.Mensagem   := LResponse.Content;
      end;

      END;
  FINALLY

  END;

end;

function TMercadoLivre.ReativarPublicacao(IdPublicacao: string;
  Estoque: Extended): TRetorno;
var
  LResponse: RESTRequest4D.IResponse;
begin
  GetToken;

  LResponse := RESTRequest4D.TRequest.New
               .BaseURL(ML_APIBASE)
               .Resource(ML_PUT_ITEM)
               .AddBody('{'+

                        '"available_quantity": '+ FloatToStr(Estoque).Replace(',','.') +','+

                        '}' )
               .AddUrlSegment('cust_id', FuserID)
               .AddUrlSegment('item_id', IdPublicacao)
               .Token('Bearer ' + FAccessToken)
               .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
               .RaiseExceptionOn500(True)
               .Put;

               Retorno.StatusCode := LResponse.StatusCode;
               Retorno.Mensagem   := LResponse.Content;

end;

function TMercadoLivre.RefreshToken: TRetorno;
var
LResponse: RESTRequest4D.IResponse;
JSonValue : TJSonValue;
obj:TJSonObject;
arq: TextFile;
i,n:integer;
xecar:string;
SaveStrings: TStringList;
begin
    LResponse := RESTRequest4D.TRequest.New
                .BaseURL(ML_APIBASE)
                .Resource(ML_POST_REFRESHTOKEN)
                .AddUrlSegment('app_id',FClientID)
                .AddUrlSegment('secret_key',FClientSecret)
                .AddUrlSegment('refresh_token',FRefreshToken)
                .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
                .RaiseExceptionOn500(True)
                .Post;

                Retorno.StatusCode := LResponse.StatusCode;
                Retorno.Mensagem   := LResponse.Content;

                obj := TJsonObject.create;
                obj := TJsonObject.ParseJSONValue(LResponse.Content) as TJsonObject;
                try
                    SaveStrings := TStringList.Create;

                    if FileExists(FCaminhoArquivoToken + 'token.ml') then
                    begin
                       DeleteFile(FCaminhoArquivoToken + 'token.ml');
                    end;

                    SaveStrings.Add('access_token=' + obj.GetValue('access_token').value);
                    SaveStrings.Add('user_id=' + obj.GetValue('user_id').value);
                    SaveStrings.Add('refresh_token=' + obj.GetValue('refresh_token').value);
                    SaveStrings.Add('data=' + DateToStr(date));
                    SaveStrings.Add('ExpiraData=' + DateTimeToStr(IncHour(now,6)));
                    SaveStrings.Add('hora=' + TimeToStr( IncHour(now,6)));

                    SaveStrings.SaveToFile(FCaminhoArquivoToken + 'token.ml');
                finally
                  FreeAndNil(SaveStrings);
                  obj.Free;
                end;
end;


procedure TMercadoLivre.SetAccessToken(const Value: string);
begin
  FAccessToken := Value;
end;

procedure TMercadoLivre.SetCaminhoArquivoToken(const Value: string);
begin
  FCaminhoArquivoToken := Value;
end;

procedure TMercadoLivre.SetClientID(const Value: string);
begin
  FClientID := Value;
end;

procedure TMercadoLivre.SetClientSecret(const Value: string);
begin
  FClientSecret := Value;
end;

procedure TMercadoLivre.SetDataToken(const Value: TDate);
begin
  FDataToken := Value;
end;

procedure TMercadoLivre.SetHoraToken(const Value: TTime);
begin
  FHoraToken := Value;
end;

procedure TMercadoLivre.SetRefreshToken(const Value: string);
begin
  FRefreshToken := Value;
end;

procedure TMercadoLivre.SetuserID(const Value: string);
begin
  FuserID := Value;
end;

end.
