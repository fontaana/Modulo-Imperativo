{Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN -1. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.

h. Un módulo recursivo que reciba la estructura generada en h. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).}

program ejercicio02;
type
d=1..31;
m=1..12;
prestamo=record
isbn:integer;
socio:integer;
dia:d;
mes:m;
cant:integer;
end;
arbol=^nodo;
nodo=record
hi:arbol;
hd:arbol;
dato:prestamo;
end;

lista=^nodo3;
nodo3=record
sig:lista;
dato:prestamo;
end;

arbol2=^nodo2;
nodo2=record
hi:arbol2;
hd:arbol2;
dato:lista;
end;

prestamo_isbn=record
isbn:integer;
cant:integer;
end;

lista2=^nodo4;
nodo4=record
sig:lista2;
dato:prestamo_isbn;
end;

procedure leer_informacion(var info:prestamo);
begin
writeln('Ingrese Codigo ISBN');
readln(info.isbn);
if info.isbn <> -1 then begin
{
writeln('Ingrese Dia del prestamo');
readln(info.dia);
writeln('Ingrese Mes del prestamo');
readln(info.mes);
writeln('Ingrese Cantidad de dias del prestamo');
readln(info.cant);
}
writeln('Ingrese Numero de socio');
readln(info.socio);
end;
end;


procedure cargar_lista (var l:lista;info:prestamo);
var 
nuevo:lista;
begin
new(nuevo);
nuevo^.sig:=nil;
nuevo^.dato:=info;
if l = nil then
	l:=nuevo
else begin
	nuevo^.sig:=l;
	l:=nuevo;
end;
end;


procedure generar_arbol(var a:arbol;info:prestamo);
begin
if a = nil then begin
  new(a);
  a^.dato:=info;
  a^.hi:=nil;
  a^.hd:=nil;
end
else begin 
if info.isbn >= a^.dato.isbn then 
  generar_arbol(a^.hd,info)
else
  generar_arbol(a^.hi,info);
end;
end;


procedure generar_arbol2 (var a:arbol2;info:prestamo);
begin
if a=nil then begin
  new(a);
  a^.hi:=nil;
  a^.hd:=nil;
  a^.dato:=nil;
  cargar_lista(a^.dato,info);
end
else begin
if info.isbn = a^.dato^.dato.isbn then begin
  cargar_lista(a^.dato,info);
 end
else begin
if info.isbn >= a^.dato^.dato.isbn then 
  generar_arbol2(a^.hd,info)
else
  generar_arbol2(a^.hi,info);
end;
end;
end;

procedure cargar_arbol (var a1:arbol;var a2:arbol2);
var
info:prestamo;
begin
leer_informacion(info);
while info.isbn <> -1 do begin
	generar_arbol(a1,info);
	generar_arbol2(a2,info);
	leer_informacion(info);
end;
end;

procedure buscar_max(a:arbol;var max:integer);
begin
if a <> nil then begin
  if a^.dato.isbn > max then
    max:=a^.dato.isbn;
  buscar_max(a^.hd,max);
end;
end;


procedure buscar_min(a:arbol2;var min:integer);
begin
if a <> nil then begin
  if a^.dato^.dato.isbn < min then
    min:=a^.dato^.dato.isbn;
  buscar_min(a^.hi,min);
end;
end;




procedure socio_prestamos(a:arbol;num:integer;var cant:integer);
begin
if a <> nil then begin
  if a^.dato.socio = num then 
    cant:=cant+1;
socio_prestamos(a^.hd,num,cant);
socio_prestamos(a^.hi,num,cant);
end;
end;


procedure recorrer_lista(l:lista;num:integer;var cant:integer);
begin
while l <> nil do
begin
  if l^.dato.socio = num then 
    cant:=cant+1;
l:=l^.sig;
end;
end;


procedure socio_prestamos_arbol2 (a:arbol2;num:integer;var cant:integer);
begin
if a <> nil then begin
  recorrer_lista(a^.dato,num,cant);
	socio_prestamos_arbol2(a^.hi,num,cant);
	socio_prestamos_arbol2(a^.hd,num,cant);
end;
end;

procedure crear_lista2(var pri:lista2;info:prestamo);
var
nuevo,actual,anterior:lista2;
begin
new(nuevo);
nuevo^.sig:=nil;
nuevo^.dato.isbn:=info.isbn;
nuevo^.dato.cant:=1;
if pri = nil then begin
	pri:=nuevo;
	writeln('Pri = nil');
end
else begin
	if nuevo^.dato.isbn < pri^.dato.isbn then begin
		nuevo^.sig:=pri;
		pri:=nuevo;
		writeln('Es menor a primer nodo');
		writeln('Inserto nodo al principio');
	end
else begin
	anterior:=pri;
	actual:=pri;
while (actual <> nil) and (actual^.dato.isbn < nuevo^.dato.isbn) and (actual^.dato.isbn <> nuevo^.dato.isbn) do begin
	anterior:=actual;
	actual:=actual^.sig; 
end;
if (actual <> nil) and (actual^.dato.isbn = nuevo^.dato.isbn) then begin
	actual^.dato.cant:=actual^.dato.cant+1;
	writeln('Se sumo uno a el ISBN:',actual^.dato.isbn );
end
else begin
anterior^.sig:=nuevo;
nuevo^.sig:=actual;
	writeln('Inserto nodo');
end;
end;
end;
end;


procedure cargar_lista2(var l:lista2;a:arbol);
begin
if a <> nil then begin
	crear_lista2(l,a^.dato);
	cargar_lista2(l,a^.hi);
	cargar_lista2(l,a^.hd);
end;
end;

procedure recorrer_lista3(l:lista;var cant:integer);
begin
while l <> nil do
begin
    cant:=cant+1;
l:=l^.sig;
end;
end;

procedure crear_lista3(var pri:lista2;info:lista);
var
nuevo,actual,anterior:lista2;
cont:integer;
begin
new(nuevo);
nuevo^.sig:=nil;
nuevo^.dato.isbn:=info^.dato.isbn;
cont:=0;
recorrer_lista3(info,cont);
nuevo^.dato.cant:=cont;
if pri = nil then
	pri:=nuevo
else begin
anterior:=pri;
actual:=pri;
while (actual <> nil) and (actual^.dato.isbn < nuevo^.dato.isbn)  do begin
anterior:=actual;
actual:=actual^.sig; 
end;
if actual = pri then begin
nuevo^.sig:=pri;
pri:=nuevo;
end
else begin
anterior^.sig:=nuevo;
nuevo^.sig:=actual;
end;
end;
end;

procedure cargar_lista3(a:arbol2;var l:lista2);
begin
if a <> nil then begin
	crear_lista3(l,a^.dato);
	cargar_lista3(a^.hi,l);
	cargar_lista3(a^.hd,l);
end;
end;
procedure imprimir_lista (l:lista2);
begin
while l <> nil do begin
writeln('ISBN:',l^.dato.isbn);
writeln('La cantidad de prestamos es ',l^.dato.cant);
l:=l^.sig;
end;
end;

procedure rango_arbol1(a:arbol;isbn1:integer;isbn2:integer;var cant:integer);
begin
if a <> nil then begin
	if (a^.dato.isbn >= isbn1) and (a^.dato.isbn <= isbn2) then begin
		cant:=cant+1;
		rango_arbol1(a^.hi,isbn1,isbn2,cant);
		rango_arbol1(a^.hd,isbn1,isbn2,cant);
	end
	else begin
		if a^.dato.isbn > isbn2 then
			rango_arbol1(a^.hi,isbn1,isbn2,cant)
		else
			rango_arbol1(a^.hd,isbn1,isbn2,cant);
end;
end;
end;

procedure rango_arbol2 (a:arbol2; isbn1:integer;isbn2:integer;var cant:integer);
begin
if a <> nil then
	if (a^.dato^.dato.isbn >= isbn1) and (a^.dato^.dato.isbn <= isbn2) then begin	
		recorrer_lista3(a^.dato,cant);
		rango_arbol2(a^.hi,isbn1,isbn2,cant);
		rango_arbol2(a^.hd,isbn1,isbn2,cant);
	end
	else begin
		if a^.dato^.dato.isbn > isbn2 then
			rango_arbol2(a^.hi,isbn1,isbn2,cant)
		else
			rango_arbol2(a^.hd,isbn1,isbn2,cant);
end;
end;
procedure imprimir_lista_arbol2(l:lista);
begin
while l <> nil do begin
writeln(l^.dato.isbn);
l:=l^.sig;
end;
end;
var
a1:arbol;
a2:arbol2;
cant,min,max,num,isbn1,isbn2:integer;
l,l2:lista2;
begin 
a1:=nil;
a2:=nil;
cant:=0;
min:=9999;
max:=0;
l:=nil;
l2:=nil;
cargar_arbol(a1,a2);
buscar_max(a1,max);
writeln('El ISBN maximo del arbol 1 es ',max);
buscar_min(a2,min);
writeln('El ISBN minimo del arbol 2 es ',min);
writeln('Ingrese Numero de socio a buscar');
readln(num);
socio_prestamos(a1,num,cant);
writeln('El socio ',num ,' realizo ', cant, ' prestamos' );
cant:=0;
writeln('Ingrese Numero de socio a buscar');
readln(num);
socio_prestamos_arbol2(a2,num,cant);
writeln('El socio ',num ,' realizo ', cant, ' prestamos' );
writeln('Lista 1');
cargar_lista2(l,a1);
imprimir_lista(l);
writeln('Lista 2');
cargar_lista3(a2,l2);
imprimir_lista(l2);
writeln('Ingrese rango inferior de ISBN');
readln(isbn1);
writeln('Ingrese rango superior de ISBN');
readln(isbn2);
cant:=0;
rango_arbol1(a1,isbn1,isbn2,cant);
writeln(cant);
cant:=0;
rango_arbol2(a2,isbn1,isbn2,cant);
writeln(cant);
end.

