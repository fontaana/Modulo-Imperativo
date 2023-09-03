{Escribir un programa que:
a. Implemente un módulo que lea información de socios de un club y las almacene en un árbol
binario de búsqueda. De cada socio se lee número de socio, nombre y edad. La lectura finaliza
con el número de socio 0 y el árbol debe quedar ordenado por número de socio.
* 
b. Una vez generado el árbol, realice módulos independientes que reciban el árbol como
parámetro y que :
* 
i. Informe el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.

ii. Informe los datos del socio con el número de socio más chico. Debe invocar a un módulo
recursivo que retorne dicho socio.

iii. Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que
retorne dicho valor.

iv. Aumente en 1 la edad de todos los socios.

v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a
un módulo recursivo que reciba el valor leído y retorne verdadero o falso.

vi. Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a
un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.

vii. Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha
cantidad.

viii. Informe el promedio de edad de los socios. Debe invocar al módulo recursivo del inciso

vii e invocar a un módulo recursivo que retorne la suma de las edades de los socios.

xi. Informe los números de socio en orden creciente.

x. Informe los números de socio pares en orden decreciente.}

program ejercicio01;
type
socio=record
nro:integer;
nombre:string;
edad:integer;
end;

arbol=^nodo;
nodo=record
hi:arbol;
hd:arbol;
dato:socio;
end;

procedure leer_socio(var dato:socio);
begin
writeln('Ingrese Nro');
readln(dato.nro);
if dato.nro <> 0 then begin
writeln('Ingrese Edad');
readln(dato.edad);
{
writeln('Ingrese Nombre');
readln(dato.nombre);
}
end;
end;
procedure agregar (var a:arbol; dato:socio);
begin
	if a=nil then begin
		new(a);
		a^.dato:=dato;
		a^.hi:=nil;
		a^.hd:=nil;
		end
	else begin
		if dato.nro > a^.dato.nro then
			agregar(a^.hd,dato)
		else
			agregar(a^.hi,dato);
	end;
end;
procedure cargar_arbol (var a:arbol);
var
dato:socio;
begin
leer_socio(dato);
while dato.nro <> 0 do begin
	agregar(a,dato);
	leer_socio(dato);
end;
end;
procedure encontrar_maximo (a:arbol; var max:integer);
begin
if a <> nil then begin
	max:=a^.dato.nro; 
	encontrar_maximo(a^.hd,max);
end;
end;
procedure encontrar_min (a:arbol;var min:integer);
begin
if a <> nil then
begin
min:=a^.dato.nro;
encontrar_min(a^.hi,min);
end;
end; 

procedure min_edad(a:arbol;var edad:integer;var nro:integer);
begin
if a <> nil then begin 
	if a^.dato.edad < edad then begin
		edad:=a^.dato.edad;
		nro:=a^.dato.nro;
	end;
	min_edad(a^.hi,edad,nro);
	min_edad(a^.hd,edad,nro);
end;
end;
procedure max_edad(a:arbol;var edad:integer;var nro:integer);
begin
if a <> nil then begin 
	if a^.dato.edad > edad then begin
		edad:=a^.dato.edad;
		nro:=a^.dato.nro;
	end;
	max_edad(a^.hi,edad,nro);
	max_edad(a^.hd,edad,nro);
end;
end;
var
a:arbol;
max,min,nro,edad:integer;

begin
a:=nil;
edad:=999;
cargar_arbol(a);
{
encontrar_maximo(a,max);
writeln('Numero de socio mas grande ',max);
encontrar_min(a,min);
writeln('Numero de mas chico ',min);
min_edad(a,edad,nro);
writeln('Numero de socio mas joven ', nro);
edad:=-1;
max_edad(a^.hd,edad,nro);
writeln('Numero de socio mas viejo ', nro);
}

end.
