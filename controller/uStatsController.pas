unit uStatsController;

interface

uses
  System.Generics.Collections,
  uMunicipio,
  uStats;

type
  TStatsController = class
  public
    class function Calcular(Lista: TObjectList<TMunicipioResultado>): TStatsResult;
  end;

implementation

class function TStatsController.Calcular(Lista: TObjectList<TMunicipioResultado>): TStatsResult;
begin
  Result.TotalMunicipios := Lista.Count;
end;

end.