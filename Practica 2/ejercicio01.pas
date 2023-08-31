
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

lista=^nodo;
nodo=record 
sig:lista;
dato:char;
end;

procedure descomponer_palabra(var vec:letras;var dimlog:integer);
var
caracter:char;
begin
readln(caracter);
	if ( caracter <> '.') and (dimlog < dimF)  then
		begin
		dimlog:=dimlog+1;
		vec[dimlog]:=caracter;
		descomponer_palabra(vec,dimlog);
		end
		else
end;
procedure imprimir_vector (vec:letras;dimlog:integer);
var 
i:integer;
begin
for i:=1 to dimlog do
begin
writeln(vec[i]);
end;
end;
procedure imprimir_vector_recursivo (vec:letras;dimlog:integer);
begin
if dimlog > 0 then
begin
writeln(vec[dimlog]);
dimlog:=dimlog-1;
imprimir_vector_recursivo (vec,dimlog);
end;
end;
function contar_caracteres ():integer;
var
caracter:char;
begin
readln(caracter);
if caracter <> '.' then
contar_caracteres:=contar_caracteres()+1
else
contar_caracteres:=0
end;

procedure lista_caracteres (var l:lista; var pri:lista);
var
caracter:char;
nuevo:lista;
begin
readln(caracter);
if caracter <> '.' then
begin
new(nuevo);
nuevo^.sig:=nil;
nuevo^.dato:=caracter;
	if l=nil then
	begin
		l:=nuevo;
		pri:=nuevo;
	end
	else begin
		l^.sig:=nuevo;
		l:=nuevo;	
	end;
lista_caracteres(l,pri);
end;
end;
procedure leer_lista(pri:lista);
begin
if pri <> nil then
writeln(pri^.dato);
leer_lista(pri^.sig);
end;
procedure apilar (var p:lista; l:lista);
var
nuevo:lista;
begin
if l <> nil then begin
new(nuevo);
nuevo^.sig:=p;
nuevo^.dato:=l^.dato;
apilar (p,l^.sig);
end;
end;
procedure desapilar (p:lista);
begin
if p <> nil then
writeln(p^.dato);
desapilar(p^.sig);
end;
procedure leer_pila (p:lista; l:lista);
begin
apilar(p,l);
desapilar(p);
end;
var
vec:letras;
dimlog:integer;
pri,l,pila:lista;
begin
dimlog:=0;
l:=nil;
pri:=nil;
pila:=nil;
descomponer_palabra(vec,dimlog);
imprimir_vector (vec,dimlog);
imprimir_vector_recursivo (vec,dimlog);
writeln(contar_caracteres());
lista_caracteres(l,pri);
leer_lista(pri);
leer_pila(pila,l)
end.
