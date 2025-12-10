unit uStringHelper;

interface

uses
  System.SysUtils;

function NormalizarTexto(const S: string): string;
function LevenshteinDist(const S, T: string): Integer;

implementation

function NormalizarTexto(const S: string): string;
var
  I: Integer;
begin
  Result := LowerCase(Trim(S));

  for I := 1 to Length(Result) do
  begin
    case Result[I] of
      'á','à','â','ã','ä': Result[I] := 'a';
      'é','è','ê','ë':     Result[I] := 'e';
      'í','ì','î','ï':     Result[I] := 'i';
      'ó','ò','ô','õ','ö': Result[I] := 'o';
      'ú','ù','û','ü':     Result[I] := 'u';
      'ç':                 Result[I] := 'c';
    end;
  end;
end;

function LevenshteinDist(const S, T: string): Integer;
var
  D: array of array of Integer;
  I, J, Cost: Integer;
  Del, Ins, Sub: Integer;
begin
  SetLength(D, Length(S)+1, Length(T)+1);

  for I := 0 to Length(S) do D[I][0] := I;
  for J := 0 to Length(T) do D[0][J] := J;

  for I := 1 to Length(S) do
  begin
    for J := 1 to Length(T) do
    begin
      if S[I] = T[J] then Cost := 0 else Cost := 1;

      Del := D[I-1][J] + 1;
      Ins := D[I][J-1] + 1;
      Sub := D[I-1][J-1] + Cost;

      D[I][J] := Del;
      if Ins < D[I][J] then D[I][J] := Ins;
      if Sub < D[I][J] then D[I][J] := Sub;
    end;
  end;

  Result := D[Length(S)][Length(T)];
end;

end.

