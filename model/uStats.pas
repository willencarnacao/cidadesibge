unit uStats;

interface

uses System.Generics.Collections;

type
  TStatsResult = record
    TotalMunicipios: Integer;
    TotalOK: Integer;
    TotalNaoEncontrado: Integer;
    TotalErroApi: Integer;
    PopTotalOK: Int64;
    MediasPorRegiao: TDictionary<string, Double>;
  end;

implementation

end.