{Implementar un programa que contenga:
a. Un módulo que lea información de alumnos de Taller de Programación y los almacene en
una estructura de datos. De cada alumno se lee legajo, DNI, año de ingreso y los códigos y
notas de los finales rendidos. La estructura generada debe ser eficiente para la búsqueda por
número de legajo. La lectura de los alumnos finaliza con legajo 0 y para cada alumno el ingreso
de las materias finaliza con el código de materia -1.
b. Un módulo que reciba la estructura generada en a. y retorne los DNI y año de ingreso de
aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro.
c. Un módulo que reciba la estructura generada en a. y retorne el legajo más grande.
d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
e. Un módulo que reciba la estructura generada en a. y retorne el legajo y el promedio del
alumno con mayor promedio.
f. Un módulo que reciba la estructura generada en a. y un valor entero. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.
}

program ejercicio03;
type 
n=0..10;
examen=record
cod:integer;
nota:n;
end;


lista=^nodo;
nodo=record
sig:lista;
dato:examen;
end;

alumno=record
dni:integer;
legajo:integer;
ingreso:integer;
materias:lista;
end;

lista2=^nodo3;
nodo3=record
dato:alumno;
sig:lista2;
end;

arbol=^nodo2;
nodo2=record
hi:arbol;
hd:arbol;
elemento:alumno;
end;

info=record
legajo:integer;
promedio:real;
end;
lista3=^nodo4;
nodo4=record
sig:lista3;
dato:info;
end;
procedure crear_lista(var l:lista;materia:examen);
var
nuevo:lista;
begin
new(nuevo);
nuevo^.sig:=nil;
nuevo^.dato:=materia;
if l= nil then
l:=nuevo
else begin
nuevo^.sig:=l;
l:=nuevo
end;
end;

procedure crear_lista2(var l:lista2;info:alumno);
var
nuevo:lista2;
begin
new(nuevo);
nuevo^.sig:=nil;
nuevo^.dato.dni:=info.dni;
nuevo^.dato.ingreso:=info.ingreso;
if l= nil then
l:=nuevo
else begin
nuevo^.sig:=l;
l:=nuevo;
end;
end;

procedure leer_info(var info:alumno); 
var
materia:examen;
begin
writeln('Ingrese legajo (0 para terminar)');
readln(info.legajo);
if info.legajo <> 0 then begin
info.dni:=random(45999);
writeln('Dni es ',info.dni);
info.ingreso:=random(2020);
writeln('Fecha de ingreso ',info.ingreso );
{
info.materias:=nil;
writeln('Ingrese codigo de la materia (-1 para dejar de leer)');
readln(materia.cod);
while materia.cod <> -1 do begin
writeln('Ingrese nota de la materia');
readln(materia.nota);
crear_lista(info.materias,materia);
writeln('Ingrese codigo de la materia (-1 para dejar de leer)');
readln(materia.cod);
end;
}
end;
end;

procedure cargar_arbol (var a:arbol;info:alumno);
begin
if a = nil then begin
	new(a);
	a^.hi:=nil;
	a^.hd:=nil;
	a^.elemento:=info;
end
else begin
if info.legajo >= a^.elemento.legajo then
	cargar_arbol(a^.hd,info)
else
	cargar_arbol(a^.hi,info);
end;
end;

procedure generar_arbol(var a:arbol);
var
info:alumno;
begin
leer_info(info);
while info.legajo <> 0 do begin
	cargar_arbol(a,info);
	leer_info(info);
end;
end;


procedure imprimir_lista2(l:lista2);
begin 
while l <> nil do
begin
writeln(l^.dato.dni);
l:=l^.sig;
end;
end;

procedure buscar_rango(a:arbol; num:integer; var l:lista2);
begin
if a <> nil then begin
	if num > a^.elemento.legajo then
		crear_lista2(l,a^.elemento);
	if num > a^.elemento.legajo then begin
		buscar_rango(a^.hd,num,l);
		buscar_rango(a^.hi,num,l);
	end
	else
		buscar_rango(a^.hi,num,l);
end;
end;
procedure buscar_maxlegajo(a:arbol;var max:integer);
begin
if a <> nil then begin
	if a^.hd = nil then 
		max:=a^.elemento.legajo;
buscar_maxlegajo(a^.hd,max);
end;
end;
procedure buscar_maxdni(a:arbol;var max:integer);
begin
if a <> nil then begin
	if max < a^.elemento.dni then 
		max:=a^.elemento.dni;
buscar_maxdni(a^.hi,max);
buscar_maxdni(a^.hd,max);
end;
end;

procedure cant_legajoimpar(a:arbol;var cant:integer);
begin
if a <> nil then begin
	if (a^.elemento.legajo mod 2) <> 0 then 
		cant:=cant+1;
	cant_legajoimpar(a^.hi,cant);
	cant_legajoimpar(a^.hd,cant);
end;
end;

procedure calcular_promedio (l:lista;var promedio:real);
var
cant:integer;
begin
cant:=0;
promedio:=0;
while l <> nil do begin
	promedio:=promedio+l^.dato.nota;
	cant:=cant+1;
	l:=l^.sig;
end;
promedio:=promedio / cant;
end;

procedure mejorpromedio (a:arbol;var legajo:integer;var maxpromedio:real);
var
promedio:real;
begin
if a <> nil then begin
	calcular_promedio(a^.elemento.materias,promedio);
		if promedio > maxpromedio then begin
			maxpromedio:=promedio;
			legajo:=a^.elemento.legajo;
		end;
	mejorpromedio(a^.hi,legajo,maxpromedio);
	mejorpromedio(a^.hd,legajo,maxpromedio);
end;
end;

procedure cargar_lista3(legajo:integer;promedio:real;var l:lista3);
var
nuevo:lista3;
begin
new(nuevo);
nuevo^.sig:=nil;
nuevo^.dato.promedio:=promedio;
nuevo^.dato.legajo:=legajo;
if l= nil then
l:=nuevo
else begin
nuevo^.sig:=l;
l:=nuevo;
end;
end;

procedure alumnos_maspromedio(a:arbol ; num:real;var l:lista3);
var 
promedio:real;
begin
if a <> nil then begin
	calcular_promedio(a^.elemento.materias,promedio);
	if promedio > num then
		cargar_lista3(a^.elemento.legajo,promedio,l);
	alumnos_maspromedio(a^.hi,num,l);
	alumnos_maspromedio(a^.hd,num,l);
end;
end;
var
a:arbol;
l:lista2;
l2:lista3;
num,maxlegajo,maxdni:integer;
promedio:real;
begin
randomize;
a:=nil;
l:=nil;
l2:=nil;
generar_arbol(a);
writeln('Buscar datos de legajos menores a:');
readln(num);
buscar_rango(a,num,l);
//imprimir_lista2(l);
buscar_maxlegajo(a,maxlegajo);
writeln('El numero de legajo mas grande es ', maxlegajo);
maxdni:=0;
buscar_maxdni(a,maxdni);
writeln('El numero de DNI mas grande es ', maxdni);
num:=0;
cant_legajoimpar(a,num);
writeln('La cantidad de legajos impares es', num);
promedio:=0;
mejorpromedio(a,maxlegajo,promedio);
writeln('El maximo promedio ',promedio,'y el legajo del alumno es ',maxlegajo);
writeln('Ingrese que valor debe superar el promedio');
readln(num);
alumnos_maspromedio(a,num,l2);
end.
