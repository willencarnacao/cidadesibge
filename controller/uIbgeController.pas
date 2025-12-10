unit uIbgeController;

interface

uses
  System.Generics.Collections,
  uMunicipio, uStringHelper,
  uIbgeService;

type
  TIbgeController = class
  public
    class function Processar(const Inputs: TObjectList<TMunicipioInput>): TObjectList<TMunicipioResultado>;
    class function MatchMunicipio(const NomeDigitado: string; const Lista: TArray<TIbgeMunicipio>): Integer;
  end;

implementation

uses
  System.SysUtils;

class function TIbgeController.MatchMunicipio(const NomeDigitado: string;
  const Lista: TArray<TIbgeMunicipio>): Integer;
var
  NomeNorm, CurrNorm: string;
  I: Integer;
  Dist, BestDist, BestIdx: Integer;
begin
  Result := -1;

  NomeNorm := NormalizarTexto(NomeDigitado);;
  BestDist := MaxInt;
  BestIdx  := -1;

  for I := 0 to High(Lista) do
  begin
    CurrNorm := NormalizarTexto(Lista[I].Nome);

    if NomeNorm = CurrNorm then
      Exit(I);

    Dist := LevenshteinDist(NomeNorm, CurrNorm);

    if Dist < BestDist then
    begin
      BestDist := Dist;
      BestIdx  := I;
    end;
  end;

  // tolerância
  if BestDist <= 2 then
    Result := BestIdx;
end;

class function TIbgeController.Processar(const Inputs: TObjectList<TMunicipioInput>): TObjectList<TMunicipioResultado>;
var
  ListaIbge: TArray<TIbgeMunicipio>;
  I, Idx: Integer;
  Item: TMunicipioResultado;
begin
  Result := TObjectList<TMunicipioResultado>.Create(True);

  ListaIbge := GetMunicipios;

  for I := 0 to Inputs.Count - 1 do
  begin
    Item := TMunicipioResultado.Create;
    Item.MunicipioInput := Inputs[I].Nome;
    Item.PopulacaoInput := Inputs[I].Populacao;

    Idx := MatchMunicipio(Inputs[I].Nome, ListaIbge);

    if Idx >= 0 then
    begin
      Item.MunicipioIbge := ListaIbge[Idx].Nome;
      Item.UF            := ListaIbge[Idx].UF;
      Item.Regiao        := ListaIbge[Idx].Regiao;
      Item.IdIbge        := ListaIbge[Idx].Id;
      Item.Status        := 'OK';
    end
    else
    begin
      Item.Status := 'NAO_ENCONTRADO';
    end;

    Result.Add(Item);
  end;
end;


end.