{a. Implemente un módulo recursivo que genere una lista de números enteros “random”
mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se
encuentra en la lista o falso en caso contrario.}

Program ejercicio03;
type
lista=^nodo;
nodo=record
sig:lista;
dato:integer;
end;
procedure generar_lista(var l:lista;var ult:lista; num:integer);
var
nuevo:lista;
begin
if num <> 0 then begin
	num:=random(101);
	new(nuevo);
	nuevo^.dato:=num;
	nuevo^.sig:=nil;
		if (l=nil) then begin
			l:=nuevo;
			ult:=nuevo;
		end
		else 
		begin
			ult^.sig:=nuevo;
			ult:=nuevo;
		end;
	writeln('Ingrese 0 para finalizar');
	readln(num);
	generar_lista(l,ult,num);
end;
end;
procedure min1 (var min:integer;l:lista);
begin
if l <> nil then begin
	if l^.dato < min then
		min:=l^.dato;
min1(min,l^.sig);
end;
end;
procedure max1 (var max:integer;l:lista);
begin
if l <> nil then begin
	if l^.dato > max then
		max:=l^.dato;
max1 (max,l^.sig);
end;
end;
var
num,min,max:integer;
l,ult:lista;
begin
randomize;
l:=nil;
min:=101;
max:=0;
num:=-1;
generar_lista(l,ult,num);
min1(min,l);
writeln(min);
max1(max,l);
writeln(max);
end.
