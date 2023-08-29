{
Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción,
2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje
promedio otorgado por las críticas.

Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:

a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
código de la película -1.

b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
obtenido entre todas las críticas, a partir de la estructura generada en a)..

c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
métodos vistos en la teoría.

d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
del vector obtenido en el punto c).}

program ejercicio03;
type
gen=-1..8;
pel=record
genero:gen;
codigo:integer;
puntaje:real;
end;
max_gen=array[1..8]of pel;

lista=^nodo;
nodo=record
sig:lista;
ele:pel;
end;
procedure leer_datos (var pelicula:pel);
begin
writeln('Codigo');
read(pelicula.codigo);
if(pelicula.codigo <> -1) then
begin
writeln('Genero');
read(pelicula.genero);
writeln('Puntaje');
read(pelicula.puntaje);
end;
end;
procedure crear_nodo (var l:lista; dato:pel);
var
nuevo:lista;
begin
new(nuevo);
nuevo^.ele:=dato;
nuevo^.sig:=nil;
if l=nil then
l:=nuevo
else
begin
l^.sig:=nuevo;
l:=nuevo;
end;
end;
procedure almacenar_datos (var l:lista);
var
pelicula:pel;
begin
l:=nil;
leer_datos (pelicula);
while pelicula.codigo <> -1 do
begin
crear_nodo(l,pelicula);
leer_datos(pelicula);
end;
end;

procedure max_pels(var vec:max_gen; l:lista);
var
i:integer;
begin
for i:=1 to 8 do 
	vec[i].puntaje:= 0;
while l <> nil do
begin
	if l^.ele.puntaje > vec[l^.ele.genero].puntaje then
		vec[l^.ele.genero]:= l^.ele;
	l:=l^.sig;
end;
end;
procedure ordenar_vec (var vec:max_gen);
var
i,j,pos:integer;
aux:pel;
begin
for i:=1 to 8-1 do
begin
pos:=i;
for j:=i+1 to 8 do
	if vec[j].puntaje < vec[pos].puntaje then
		pos:=j;
aux:=vec[pos];
vec[pos]:=vec[i];
vec[i]:=aux;
end;
end;
procedure mostar_max_min(vec:max_gen);
begin
writeln('Pelicula con mas puntaje ',vec[8].codigo);
writeln('Pelicula con menos puntaje ',vec[1].codigo);
end;
var
l:lista;
vec:max_gen;
begin
almacenar_datos(l);
max_pels(vec,l);
ordenar_vec(vec);
mostar_max_min(vec);
end.
