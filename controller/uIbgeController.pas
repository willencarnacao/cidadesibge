unit uIbgeController;

interface

uses
  System.Generics.Collections,
  uMunicipio, uStringHelper;

type
  TIbgeController = class
  public
    class function Processar(Inputs: TObjectList<TMunicipioInput>): TObjectList<TMunicipioResultado>;
  end;

implementation

uses
  uIbgeService,
  System.SysUtils;

class function TIbgeController.Processar(Inputs: TObjectList<TMunicipioInput>): TObjectList<TMunicipioResultado>;
var
  ListaIbge: TArray<TIbgeMunicipio>;
  Input: TMunicipioInput;
  Res: TMunicipioResultado;
  Mun: TIbgeMunicipio;
  NomeIn, NomeIbge: string;
  MatchList: array of TIbgeMunicipio;
begin
  Result := TObjectList<TMunicipioResultado>.Create(True);

  ListaIbge := GetMunicipios;

  for Input in Inputs do
  begin
    Res := TMunicipioResultado.Create;
    Res.MunicipioInput := Input.Nome;
    Res.PopulacaoInput := Input.Populacao;

    NomeIn := NormalizarTexto(Input.Nome);
    SetLength(MatchList, 0);

    // Busca candidatos
    for Mun in ListaIbge do
    begin
      NomeIbge := NormalizarTexto(Mun.Nome);

      if (NomeIbge = NomeIn) or
         (NomeIbge.StartsWith(NomeIn)) or
         (NomeIn.StartsWith(NomeIbge)) then
      begin
        SetLength(MatchList, Length(MatchList)+1);
        MatchList[High(MatchList)] := Mun;
      end;
    end;

    // Decisão final
    if Length(MatchList) = 1 then
    begin
      Res.MunicipioIbge := MatchList[0].Nome;
      Res.UF := MatchList[0].UF;
      Res.Regiao := MatchList[0].Regiao;
      Res.IdIbge := MatchList[0].Id;
      Res.Status := 'OK';
    end
    else if Length(MatchList) > 1 then
    begin
      Res.Status := 'AMBIGUO';
    end
    else
    begin
      Res.Status := 'NAO_ENCONTRADO';
    end;

    Result.Add(Res);
  end;
end;

end.