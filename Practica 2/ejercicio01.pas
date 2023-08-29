
{
Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto, los
almacene en un vector con dimensión física igual a 10 y retorne el vector.

b. Un módulo que reciba el vector generado en a) e imprima el contenido del vector.

c. Un módulo recursivo que reciba el vector generado en a) e imprima el contenido del vector..

d. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne la cantidad de caracteres leídos. El programa debe informar el valor retornado.

e. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne una lista con los caracteres leídos.

f. Un módulo recursivo que reciba la lista generada en e) e imprima los valores de la lista en el
mismo orden que están almacenados.

g. Implemente un módulo recursivo que reciba la lista generada en e) e imprima los valores de
la lista en orden inverso al que están almacenados.
}

program ejercicio01;
const
dimf=10;
type
letras=array[1..dimf] of char;

procedure descomponer_palabra(palabra:string;var vec:letras;var dimlog:integer);
begin
	if palabra[dimlog] <> '.'  then
		vec[dimlog]:=palabra[dimlog];
		dimlog:=dimlog+1;
		descomponer_palabra(palabra,vec,dimlog);
end;
var
palabra:string;
vec:letras;
dimlog,i:integer;
begin
dimlog:=1;
read(palabra);
descomponer_palabra(palabra,vec,dimlog);
for i:=1 to dimlog do 
 writeln(vec[i]);
end.
