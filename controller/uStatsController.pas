unit uStatsController;

interface

uses
  System.Generics.Collections,
  uMunicipio,
  uStatsResult;

type
  TStatsController = class
  public
    class function Calcular(
      Dados: TObjectList<TMunicipioResultado>
    ): TStatsResult;
  end;

implementation

uses System.SysUtils;

class function TStatsController.Calcular(
  Dados: TObjectList<TMunicipioResultado>
): TStatsResult;
var
  Item: TMunicipioResultado;
  SomaSudeste, SomaSul, SomaCentro: Int64;
  ContSudeste, ContSul, ContCentro: Integer;
begin
  FillChar(Result, SizeOf(Result), 0);

  SomaSudeste := 0;
  SomaSul := 0;
  SomaCentro := 0;

  ContSudeste := 0;
  ContSul := 0;
  ContCentro := 0;

  Result.TotalMunicipios := Dados.Count;

  for Item in Dados do
  begin
    if Item.Status = 'OK' then
    begin
      Inc(Result.TotalOK);
      Inc(Result.PopTotalOK, Item.PopulacaoInput);

      if Item.Regiao = 'Sudeste' then
      begin
        Inc(SomaSudeste, Item.PopulacaoInput);
        Inc(ContSudeste);
      end
      else if Item.Regiao = 'Sul' then
      begin
        Inc(SomaSul, Item.PopulacaoInput);
        Inc(ContSul);
      end
      else if Item.Regiao = 'Centro-Oeste' then
      begin
        Inc(SomaCentro, Item.PopulacaoInput);
        Inc(ContCentro);
      end;
    end
    else if Item.Status = 'NAO_ENCONTRADO' then
      Inc(Result.TotalNaoEncontrado)
    else if Item.Status = 'ERRO_API' then
      Inc(Result.TotalErroApi);
  end;

  if ContSudeste > 0 then
    Result.MediaSudeste := SomaSudeste / ContSudeste;

  if ContSul > 0 then
    Result.MediaSul := SomaSul / ContSul;

  if ContCentro > 0 then
    Result.MediaCentroOeste := SomaCentro / ContCentro;
end;

end.