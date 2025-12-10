unit uResultadoCsvController;

interface

uses
  System.Generics.Collections,
  uMunicipio;

type
  TResultadoCsvController = class
  public
    class procedure GerarArquivo(
      const Caminho: string;
      Lista: TObjectList<TMunicipioResultado>
    );
  end;

implementation

uses
  System.Classes,
  System.SysUtils;

class procedure TResultadoCsvController.GerarArquivo(
  const Caminho: string;
  Lista: TObjectList<TMunicipioResultado>
);
var
  SL: TStringList;
  M: TMunicipioResultado;
begin
  SL := TStringList.Create;
  try
    // Cabeçalho
    SL.Add('municipio_input,populacao_input,municipio_ibge,uf,regiao,id_ibge,status');

    for M in Lista do
    begin
      SL.Add(Format('%s,%d,%s,%s,%s,%s,%s', [
        M.MunicipioInput,
        M.PopulacaoInput,
        M.MunicipioIbge,
        M.UF,
        M.Regiao,
        M.IdIbge,
        M.Status
      ]));
    end;

    SL.SaveToFile(Caminho, TEncoding.UTF8);
  finally
    SL.Free;
  end;
end;

end.