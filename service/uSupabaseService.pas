unit uSupabaseService;

interface

type
  TSupabaseService = class
  private
    class var FAccessToken: string;
  public
    class function Login(const Email, Senha: string): Boolean;
    class function GetToken: string;
  end;

implementation

uses
  System.Net.HttpClient,
  System.JSON,
  System.SysUtils,
  System.Classes,
  System.Net.URLClient;

const
  SUPABASE_URL = 'https://mynxlubykylncinttggu.supabase.co';
  SUPABASE_ANON_KEY =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im15bnhsdWJ5a3lsbmNpbnR0Z2d1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUxODg2NzAsImV4cCI6MjA4MDc2NDY3MH0.Z-zqiD6_tjnF2WLU167z7jT5NzZaG72dWH0dpQW1N-Y';

class function TSupabaseService.Login(const Email, Senha: string): Boolean;
var
  Http: THttpClient;
  Body, Resp: TStringStream;
  JsonReq, JsonResp: TJSONObject;
begin
  Result := False;
  Http := THttpClient.Create;
  try
    JsonReq := TJSONObject.Create;
    try
      JsonReq.AddPair('email', Email);
      JsonReq.AddPair('password', Senha);

      Body := TStringStream.Create(JsonReq.ToJSON, TEncoding.UTF8);
      try
        Http.CustomHeaders['apikey'] := SUPABASE_ANON_KEY;

        Resp := TStringStream.Create;
        try
          Http.Post(
            SUPABASE_URL + '/auth/v1/token?grant_type=password',
            Body,
            Resp,
            [TNetHeader.Create('Content-Type', 'application/json')]
          );

          JsonResp := TJSONObject.ParseJSONValue(Resp.DataString) as TJSONObject;
          try
            if JsonResp.TryGetValue<string>('access_token', FAccessToken) then
              Result := True;
          finally
            JsonResp.Free;
          end;

        finally
          Resp.Free;
        end;
      finally
        Body.Free;
      end;
    finally
      JsonReq.Free;
    end;
  finally
    Http.Free;
  end;
end;

class function TSupabaseService.GetToken: string;
begin
  Result := FAccessToken;
end;

end.