{Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número
leído, sus dígitos en el orden en que aparecen en el número. Debe implementarse un módulo
recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 256, se debe
imprimir 2 5 6
}
program ejercicio02;
procedure descomponer_numero(num:integer);
var
dig:integer;
begin
if (num <> 0) then
begin
dig:=num mod 10;
descomponer_numero(num div 10);
writeln(dig);
end;
end;
var
num:integer;
begin
readln(num);
descomponer_numero(num);
end.
