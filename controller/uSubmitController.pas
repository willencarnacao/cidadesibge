unit uSubmitController;

interface

uses
  uStats;

type
  TSubmitController = class
  public
    class procedure Enviar(const Stats: TStatsResult);
  end;

implementation

uses
  System.Net.HttpClient,
  System.JSON,
  uSupabaseService,
  System.SysUtils,
  System.Classes;

const
  FUNCTION_URL =
    'https://mynxlubykylncinttggu.functions.supabase.co/ibge-submit';

class procedure TSubmitController.Enviar(const Stats: TStatsResult);
var
  Http: THttpClient;
  Json, StatsJson, RegJson: TJSONObject;
  Body: TStringStream;
//  Pair: TPair<string, Double>;
begin
//  Http := THttpClient.Create;
//  try
//    Json := TJSONObject.Create;
//    try
//      StatsJson := TJSONObject.Create;
//
//      StatsJson.AddPair('total_municipios', TJSONNumber.Create(Stats.TotalMunicipios));
//      StatsJson.AddPair('total_ok', TJSONNumber.Create(Stats.TotalOk));
//      StatsJson.AddPair('total_nao_encontrado', TJSONNumber.Create(Stats.TotalNaoEncontrado));
//      StatsJson.AddPair('total_erro_api', TJSONNumber.Create(Stats.TotalErroApi));
//      StatsJson.AddPair('pop_total_ok', TJSONNumber.Create(Stats.PopTotalOk));
//
//      RegJson := TJSONObject.Create;
//      for Pair in Stats.MediasPorRegiao do
//        RegJson.AddPair(Pair.Key, TJSONNumber.Create(Pair.Value));
//
//      StatsJson.AddPair('medias_por_regiao', RegJson);
//      Json.AddPair('stats', StatsJson);
//
//      Body := TStringStream.Create(Json.ToJSON, TEncoding.UTF8);
//      try
//        Http.CustomHeaders['Authorization'] :=
//          'Bearer ' + TSupabaseService.GetToken;
//        Http.CustomHeaders['Content-Type'] := 'application/json';
//
//        Http.Post(FUNCTION_URL, Body);
//      finally
//        Body.Free;
//      end;
//    finally
//      Json.Free;
//    end;
//  finally
//    Http.Free;
//  end;
end;

end.