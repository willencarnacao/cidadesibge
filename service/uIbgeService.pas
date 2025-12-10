unit uIbgeService;

interface

uses
  System.Generics.Collections;

type
  TIbgeMunicipio = record
    Nome: string;
    UF: string;
    Regiao: string;
    Id: string;
  end;

function GetMunicipios: TArray<TIbgeMunicipio>;

implementation

uses
  System.Net.HttpClient,
  System.JSON,
  System.SysUtils;

function GetMunicipios: TArray<TIbgeMunicipio>;
var
  Http: THttpClient;
  Resp: string;
  Json: TJSONArray;
  Item: TJSONObject;
  I: Integer;
  Value: TJSONValue;
  ObjMicro, ObjMeso, ObjUF, ObjRegiao: TJSONObject;
begin
  Http := THttpClient.Create;
  try
    Resp := Http.Get('https://servicodados.ibge.gov.br/api/v1/localidades/municipios')
                .ContentAsString(TEncoding.UTF8);

    Json := TJSONObject.ParseJSONValue(Resp) as TJSONArray;
    try
      SetLength(Result, Json.Count);

      for I := 0 to Json.Count - 1 do
      begin
        Item := Json.Items[I] as TJSONObject;

        Result[I].Id   := Item.GetValue<string>('id');
        Result[I].Nome := Item.GetValue<string>('nome');
        Result[I].UF := '';
        Result[I].Regiao := '';

        // microrregiao
        if Item.TryGetValue<TJSONValue>('microrregiao', Value) then
        begin
          if Value is TJSONObject then
          begin
            ObjMicro := Value as TJSONObject;

            // mesorregiao
            if ObjMicro.TryGetValue<TJSONValue>('mesorregiao', Value) then
            begin
              if Value is TJSONObject then
              begin
                ObjMeso := Value as TJSONObject;

                // UF
                if ObjMeso.TryGetValue<TJSONValue>('UF', Value) then
                begin
                  if Value is TJSONObject then
                  begin
                    ObjUF := Value as TJSONObject;

                    if ObjUF.TryGetValue<string>('sigla', Result[I].UF) then
                    begin
                      // regiao
                      if ObjUF.TryGetValue<TJSONValue>('regiao', Value) then
                      begin
                        if Value is TJSONObject then
                        begin
                          ObjRegiao := Value as TJSONObject;
                          ObjRegiao.TryGetValue<string>('nome', Result[I].Regiao);
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    finally
      Json.Free;
    end;
  finally
    Http.Free;
  end;
end;


end.