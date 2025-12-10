unit uStringHelper;

interface

function NormalizarTexto(const S: string): string;
function Similaridade(const A, B: string): Integer;

implementation

uses
  System.SysUtils, System.Character, System.Math;

function RemoverAcentos(const S: string): string;
const
  ComAcento = 'áàãâäéèêëíìîïóòõôöúùûüçÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÇ';
  SemAcento = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC';
var
  I: Integer;
  C: Char;
begin
  Result := S;
  for I := 1 to Length(ComAcento) do
  begin
    C := ComAcento[I];
    Result := Result.Replace(C, SemAcento[I], [rfReplaceAll]);
  end;
end;

function NormalizarTexto(const S: string): string;
begin
  Result := RemoverAcentos(S.Trim.ToLower);
  Result := Result.Replace(' ', '');
end;

function Similaridade(const A, B: string): Integer;
var
  I, LenMin: Integer;
begin
  Result := 0;
  LenMin := Min(Length(A), Length(B));

  for I := 1 to LenMin do
    if A[I] = B[I] then
      Inc(Result);
end;

end.