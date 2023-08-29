//El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
//las expensas de dichas oficinas.
//Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
//a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
//se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
//finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
//b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
//oficina.
//c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.


program ejercicio02;
const 
dimf=300;

type
oficina=record 
codigo:integer;
dni:integer;
expensa:real;
end;
informacion= array[1..dimf] of oficina;

procedure leer_datos (var ofi:oficina);
begin
writeln('Codigo');
read(ofi.codigo);
writeln('DNI');
read(ofi.dni);
writeln('Expensas');
read(ofi.expensa);
end;
procedure almacenar_datos (var vec:informacion;var dimlog:integer);
var
ofi:oficina;
begin
leer_datos(ofi);
while (dimlog > dimf) and (ofi.codigo <> -1) do 
begin
	dimlog:=dimlog+1;
	vec[dimlog]:=ofi;
	leer_datos(ofi);
end;
end;

procedure ordenar_seleccion (var vec:informacion; dimlog:integer);
var
i,j,pos:integer;
aux:oficina;
begin
for i:= 1 to dimlog-1 do 
begin
pos:=i;
for j:= i+1 to dimlog do
begin
	if vec[j].codigo < vec[pos].codigo then
		pos:=j;
end;
aux:=vec[pos];
vec[pos]:=vec[j];
vec[j]:=aux;
end;
procedure ordenar_insercion (var vec:informacion; dimlog:integer);
var
i,j:integer;
aux:oficina;
begin
for i:= 2 to dimlog do begin
aux:=vec[i];
j:= i-1;
while (j > 0) and (v[j] > aux) do begin
vec[j+1]:= v[j];
j:=j-1;
end;
v[j+1]:= actual;
end;
end;
var
vec:informacion;
dimlog:integer;

begin 
dimlog:=0;
almacenar_datos(vec,dimlog);
end.
