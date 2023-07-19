unit Utils.Strings;

interface

uses
  strutils,
  sysutils,
  classes;

type
  TUtilString = class
  private
  public
    class function Captalize(value: string): string;
    class function SingularMode(value: string): string;
    class function PluralMode(value: string): string;

  end;

implementation

{ TUtilString }
class function TUtilString.Captalize(value: string): string;
begin
  result := value;
  if value = '' then
    exit;
  result := UpperCase(value[1]) + copy(value, 2, length(value));
end;

class function TUtilString.SingularMode(value: string): string;
begin
  result := value;
  if result = '' then
    exit;

  if LowerCase(value[length(value)]) = 's' then
    result := copy(value, 1, length(value) - 1);
end;

class function TUtilString.PluralMode(value: string): string;
begin
  result := value;
  if result = '' then
    exit;
  if LowerCase(value[length(value)]) <> 's' then
    result := value + 's';

end;

end.
