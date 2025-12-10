unit uSubmitController;

interface

uses
  uStatsResult, Vcl.StdCtrls;

type
  TSubmitController = class
  public
    class procedure Enviar(
      const URL: string;
      const Token: string;
      const Stats: TStatsResult;
      Memo: TMemo
    );
  end;

implementation

uses
  System.Net.HttpClient,
  System.Net.URLClient,
  System.JSON,
  System.SysUtils,
  System.Classes;

class procedure TSubmitController.Enviar(
  const URL: string;
  const Token: string;
  const Stats: TStatsResult;
  Memo: TMemo
);
var
  Http: THttpClient;
  Json, StatsObj, Medias: TJSONObject;
  Resp: string;
begin
  Memo.Lines.Add('Enviando dados para API...');

  Http := THttpClient.Create;
  try
    Json := TJSONObject.Create;
    StatsObj := TJSONObject.Create;
    Medias := TJSONObject.Create;
    try
      Medias.AddPair('Sudeste', TJSONNumber.Create(Stats.MediaSudeste));
      Medias.AddPair('Sul', TJSONNumber.Create(Stats.MediaSul));
      Medias.AddPair('Centro-Oeste', TJSONNumber.Create(Stats.MediaCentroOeste));

      StatsObj.AddPair('total_municipios', TJSONNumber.Create(Stats.TotalMunicipios));
      StatsObj.AddPair('total_ok', TJSONNumber.Create(Stats.TotalOK));
      StatsObj.AddPair('total_nao_encontrado', TJSONNumber.Create(Stats.TotalNaoEncontrado));
      StatsObj.AddPair('total_erro_api', TJSONNumber.Create(Stats.TotalErroApi));
      StatsObj.AddPair('pop_total_ok', TJSONNumber.Create(Stats.PopTotalOK));
      StatsObj.AddPair('medias_por_regiao', Medias);

      Json.AddPair('stats', StatsObj);

      Resp := Http.Post(
        URL,
        TStringStream.Create(Json.ToString, TEncoding.UTF8),
        nil,
        [
          TNetHeader.Create('Authorization', 'Bearer ' + Token),
          TNetHeader.Create('Content-Type', 'application/json')
        ]
      ).ContentAsString(TEncoding.UTF8);

      Memo.Lines.Add('Resposta da API:');
      Memo.Lines.Add(Resp);

    finally
      Json.Free;
    end;
  finally
    Http.Free;
  end;
end;

end.
