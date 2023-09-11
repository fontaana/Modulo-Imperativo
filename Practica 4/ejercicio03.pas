{
Una facultad nos ha encargado procesar la información de sus alumnos de la carrera XXX.
Esta carrera tiene 30 materias. Implementar un programa con:
a. Un módulo que lea la información de los finales rendidos por los alumnos y los
almacene en dos estructuras de datos.
i. Una estructura que para cada alumno se almacenen sólo código y nota de las
materias aprobadas (4 a 10). De cada final rendido se lee el código del alumno, el
código de materia y la nota (valor entre 1 y 10). La lectura de los finales finaliza con
nota -1. La estructura debe ser eficiente para buscar por código de alumno.
ii. Otra estructura que almacene para cada materia, su código y todos los finales
rendidos en esa materia (código de alumno y nota).
b. Un módulo que reciba la estructura generada en i. y un código de alumno y retorne los
códigos y promedios de los alumnos cuyos códigos sean mayor al ingresado.
c. Un módulo que reciba la estructura generada en i., dos códigos de alumnos y un valor
entero, y retorne la cantidad de alumnos con cantidad de finales aprobados igual al
valor ingresado para aquellos alumnos cuyos códigos están comprendidos entre los dos
códigos de alumnos ingresados.}

program ejercicio03;
const
dimf=30;
type
m=1..30;
n=-1..10;

info=record
codigo:integer;
promedio:real;
end;
lista2=^nodo4;
nodo4=record
sig:lista2;
dato:info;
end;

elemento=record 
nota:n;
materia:m;
end;

lista=^nodo3;
nodo3=record
dato:elemento;
sig:lista;
end;

alumno=record 
codigo:integer;
aprobados:lista;
end; 

arbol=^nodo;
nodo=record
hi:arbol;
hd:arbol;
dato:alumno;
end;

finales=record
nota:n;
codigo_alumno:integer;
materia:m;
end;

alumno2=record
codigo_alumno:integer;
nota:n;
end;

arbol2=^nodo2;
nodo2=record
hi:arbol2;
hd:arbol2;
dato:alumno2;
end;

informacion=record
codigo_materia:integer;
alumnos:arbol2;
end;
vec_materias=array[1..dimf]of informacion;

procedure leer_finales(var info:finales);
begin
writeln('Ingrese Nota del final');
readln(info.nota);
if info.nota <> -1 then begin
writeln('Ingrese codigo del alumno');
readln(info.codigo_alumno);
writeln('Ingrese Codigo de materia');
readln(info.materia);
end;
end;

procedure cargar_alumno2 (var alu:alumno2;info:finales);
begin
alu.nota:=info.nota;
alu.codigo_alumno:=info.codigo_alumno;
end;

procedure cargar_arbol2 (var a:arbol2;info:alumno2);
begin
if a = nil then begin
	new(a);
	a^.hi:=nil;
	a^.hd:=nil;
	a^.dato:=info;
end
else begin
if info.codigo_alumno >= a^.dato.codigo_alumno then 
	cargar_arbol2(a^.hd,info)
else
	cargar_arbol2(a^.hi,info);
end;
end;

procedure cargar_lista(var l:lista;info:finales);
var
nuevo:lista;
begin
new(nuevo);
nuevo^.sig:=nil;
nuevo^.dato.nota:=info.nota;
nuevo^.dato.materia:=info.materia;
if l = nil then 
	l:=nuevo
else begin
nuevo^.sig:=l;
l:=nuevo;
end;
end;

procedure cargar_arbol(var a:arbol;info:finales);
begin
if a = nil then begin 
	new(a);
	a^.hi:=nil;
	a^.hd:=nil;
	a^.dato.codigo:=info.codigo_alumno;
	a^.dato.aprobados:=nil;
end;
if a^.dato.codigo = info.codigo_alumno then begin 
	if (info.nota >= 4) and (info.nota <= 10) then
		cargar_lista(a^.dato.aprobados,info);
end
else begin
	if info.codigo_alumno >= a^.dato.codigo then
		cargar_arbol(a^.hd,info)
	else
		cargar_arbol(a^.hi,info);
end;
end;
procedure cargar_estructuras (var vec_arboles:vec_materias;var a1:arbol);
var
i:integer;
info:finales;
alu2:alumno2;
begin
for i:= 1 to dimf do begin
	vec_arboles[i].codigo_materia:=i;
	vec_arboles[i].alumnos:=nil;
end;
leer_finales(info);
cargar_alumno2(alu2,info);
while info.nota <> -1 do begin
	cargar_arbol(a1,info);
	cargar_arbol2(vec_arboles[info.materia].alumnos,alu2);
	leer_finales(info);
	cargar_alumno2(alu2,info);
end;
end;

procedure recorrer_lista (l:lista;var cant:integer;var promedio:real);
begin
cant:=0;
promedio:=0;
while l <> nil do begin
cant:=cant+1;
promedio:=promedio+l^.dato.nota;
l:=l^.sig;
end;
end;

procedure calcular_promedio(l:lista;var promedio:real);
var
cant:integer;
begin
recorrer_lista(l,cant,promedio);
promedio:=promedio/cant;
end;

procedure cargar_lista2(var l:lista2;promedio:real;cod:integer);
var
nuevo:lista2;
begin
new(nuevo);
nuevo^.sig:=nil;
nuevo^.dato.codigo:=cod;
nuevo^.dato.promedio:=promedio;
if l = nil then
l:=nuevo
else begin
nuevo^.sig:=l;
l:=nuevo;
end;
end;

procedure promedio_alumnos (a:arbol;num:integer;var l2:lista2);
var
promedio:real;
begin
if a <> nil then begin
	if a^.dato.codigo > num then begin
		calcular_promedio(a^.dato.aprobados,promedio);
		cargar_lista2(l2,promedio,a^.dato.codigo);
		promedio_alumnos(a^.hd,num,l2);
		promedio_alumnos(a^.hi,num,l2);
	end
	else
		promedio_alumnos(a^.hd,num,l2);
end;
end;

procedure imprimir_lista (l:lista2);
begin
while l <> nil do begin
writeln('Alumno ', l^.dato.codigo);
writeln('Promedio:', l^.dato.promedio);
l:=l^.sig;
end;
end;

procedure contar_lista(l:lista; var cant:integer);
begin
while l <> nil do
begin
cant:=cant+1;
l:=l^.sig;
end;
end;

procedure buscar (a:arbol;inf:integer;sup:integer;num:integer;var cant:integer);
var
cont:integer;
begin
if a <> nil then begin
	if (a^.dato.codigo > inf) and (a^.dato.codigo < sup) then begin
		contar_lista(a^.dato.aprobados,cont);
			if cont=num then
				cant:=cant+1;
		buscar(a^.hd,inf,sup,num,cant);
		buscar(a^.hi,inf,sup,num,cant);
end
else begin
	if a^.dato.codigo >= sup then
		buscar(a^.hi,inf,sup,num,cant)
	else
		buscar(a^.hi,inf,sup,num,cant);
end;
end;
end;
var
a:arbol;
vec_arboles:vec_materias;
l2:lista2;
num,inf,sup,cant:integer;
begin
l2:=nil;
cant:=0;
a:=nil;
cargar_estructuras(vec_arboles,a);
writeln('Ingrese a partir de que codigo quiere calcular el promedio');
readln(num);
promedio_alumnos(a,num,l2);
imprimir_lista(l2);
writeln('Ingrese Rnago inferior de busqueda');
readln(inf);
writeln('Ingrese Rnago inferior de busqueda');
readln(sup);
writeln('Ingrese que cantidad de materias aprobadas debe tener');
readln(num);
buscar(a,inf,sup,num,cant);
writeln('La cantidad de alumnos que cumplen los requisitos son:',cant);
end.

