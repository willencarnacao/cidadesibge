unit uCsvController;

interface

uses
  System.Classes, Vcl.StdCtrls;

type
  TCsvController = class
  public
    class var ArquivoCsv: string;
    class var ArquivoResultado: string;
    class procedure Processar(Memo: TMemo);
  end;

implementation

uses
  System.SysUtils,
  System.Generics.Collections,
  uMunicipio,
  uIbgeController,
  uStatsController,
  uResultadoCsvController,
  uSubmitController,
  uStatsResult;

class procedure TCsvController.Processar(Memo: TMemo);
var
  Linhas: TStringList;
  Inputs: TObjectList<TMunicipioInput>;
  Resultados: TObjectList<TMunicipioResultado>;
  I: Integer;
  Cols: TArray<string>;
  Item: TMunicipioInput;
  Stats: TStatsResult;
begin
  Linhas := TStringList.Create;
  Inputs := TObjectList<TMunicipioInput>.Create(True);
  Resultados := nil;
  try
    Linhas.LoadFromFile(ArquivoCsv, TEncoding.UTF8);

    for I := 1 to Linhas.Count - 1 do
    begin
      Cols := Linhas[I].Split([',']);
      if Length(Cols) < 2 then
        Continue;

      Item := TMunicipioInput.Create;
      Item.Nome := Cols[0].Trim;
      Item.Populacao := StrToInt64Def(Cols[1], 0);
      Inputs.Add(Item);
    end;

    if Assigned(Memo) then
      Memo.Lines.Add('Registros lidos: ' + Inputs.Count.ToString);

    // Chamada à API do IBGE
    Resultados := TIbgeController.Processar(Inputs);

    // Gera resultado.csv
    TResultadoCsvController.GerarArquivo(
      ArquivoResultado,
      Resultados
    );

    if Assigned(Memo) then
      Memo.Lines.Add('Arquivo resultado.csv gerado.');

    // Estatísticas
    Stats := TStatsController.Calcular(Resultados);

    // Envio para API (Supabase)
    TSubmitController.Enviar(
	  'https://mynxlubykylncinttggu.functions.supabase.co/ibge-submit',
    'eyJhbGciOiJIUzI1NiIsImtpZCI6ImR0TG03UVh1SkZPVDJwZEciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL215bnhsdWJ5a3lsbmNpbnR0Z2d1LnN1cGFiYXNlLmNvL2F1dGgvdjEiLCJzdWIiOiJlMDg3NWM1YS05OGYzLTQ5NzItYmU3Zi1hOTNlZmY0N2I3ZWYiLCJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNzY1NDAxNTk5LCJpYXQiOjE3NjUzOTc5OTksImVtYWlsIjoid2lsbC5lbmNhcm5hY2FvQGdtYWlsLmNvbSIsInBob25lIjoiIiwiYXBwX21ldGFkYXRhIjp7InByb3ZpZGVyIjoiZW1haWwiLCJwcm92aWRlcnMiOlsiZW1haWwiXX0sInVzZXJfbWV0YWRhdGEiOnsiZW1haWwiOiJ3aWxsLmVuY2FybmFjYW9AZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5vbWUiOiJXaWxpYW4gS3VudHogZGEgRW5jYXJuYcOnw6NvIiwicGhvbmVfdmVyaWZpZWQiOmZhbHNlLCJzdWIiOiJlMDg3NWM1YS05OGYzLTQ5NzItYmU3Zi1hOTNlZmY0N2I3ZWYifSwicm9sZSI6ImF1dGhlbnRpY2F0ZWQiLCJhYWwiOiJhYWwxIiwiYW1yIjpbeyJtZXRob2QiOiJwYXNzd29yZCIsInRpbWVzdGFtcCI6MTc2NTM5Nzk5OX1dLCJzZXNzaW9uX2lkIjoiZWQ1YzYyMzMtMDkxNS00ZDExLTg1N2ItMmJjOWM0MzY0OGRjIiwiaXNfYW5vbnltb3VzIjpmYWxzZX0.fILv52Utzq06CXqPhQs0LipAPPVOElW5V7mUMRpXhdk',
	  Stats,
    Memo
	);

    if Assigned(Memo) then
      Memo.Lines.Add('Processamento concluído.');

  finally
    Linhas.Free;
    Inputs.Free;

    if Assigned(Resultados) then
      Resultados.Free;
  end;
end;

end.

