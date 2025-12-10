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
  uStats;

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
    TSubmitController.Enviar(Stats);

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

