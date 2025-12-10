unit uMunicipio;

interface

type
  TMunicipioInput = class
  public
    Nome: string;
    Populacao: Int64;
  end;

  TMunicipioResultado = class
  public
    MunicipioInput: string;
    PopulacaoInput: Int64;
    MunicipioIbge: string;
    UF: string;
    Regiao: string;
    IdIbge: string;
    Status: string;
  end;

implementation

end.