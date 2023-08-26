program ejercicio01;
const 
dimf=50;
type
d= 0..31;
cod =1..15;
cant= 1..99;

venta = record 
dia: d;
codigo : cod;
cantidad : cant;
end;

comercio = array [1..dimf] of venta;

procedure leerventas (var dato:venta);
begin
writeln('Dia');
read(dato.dia);
if (dato.dia <> 0) then 
begin
	dato.codigo:= random(16);
	writeln(dato.codigo);
	writeln('Cantidad');
	read(dato.cantidad);
end;
end;

procedure almacenardatos (var vec:comercio;var dimlog:integer);
var
dato:venta;
begin
leerventas (dato);
while (dimlog < 51) and (dato.dia <> 0)  do 
begin
dimlog:=dimlog+1;
vec[dimlog]:=dato;
leerventas (dato);
end;
end;

procedure mostrarvec (vec:comercio; dimlog:integer);
var
i:integer;
begin 
for i:= 1 to dimlog do
begin
writeln(vec[dimlog].dia);
writeln(vec[dimlog].codigo);
writeln(vec[dimlog].cantidad);
end;
end;

procedure ordenarvector (var vec:comercio; dimlog:integer);
var
i,j,pos:integer;
aux:venta;
begin
for i:= 1 to dimlog-1 do 
begin
	pos:=i;
		for j:= i+1 to dimlog do 
		begin
			if vec[j].codigo > vec[pos].codigo then begin
				aux:=vec[i];
				vec[i]:=vec[j];
				vec[j]:=aux;
			end;
		end;
end;
end;

procedure elimar_rango (var vec:comercio; var dimlog:integer; a:cod; b:cod);
var
j,pos:integer;
begin 
pos:=0;
while vec[pos].codigo < a do  
begin
pos:=pos+1;
end;
while vec[pos].codigo < b do
begin
		for j:= pos to dimlog-1 do
		begin
			vec[j]:=vec[j+1];
		end;
		dimlog:=dimlog-1;
end;
pos:=pos+1
end;

var
vec:comercio;
dimlog:integer;
begin
randomize;
dimlog:=0;
almacenardatos(vec,dimlog);
mostrarvec(vec,dimlog);
ordenarvector(vec,dimlog);
mostrarvec(vec,dimlog);
end.
