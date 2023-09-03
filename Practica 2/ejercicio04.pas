{a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 0 y
menores a 100.
b. Un módulo recursivo que devuelva el máximo valor del vector.
c. Un módulo recursivo que devuelva la suma de los valores contenidos en el vector.}


program ejercicio04;
const
dimf=20;
type
numeros=array[1..dimf] of integer;

procedure cargar_vector (var vec:numeros;var dimlog:integer);
begin
if dimlog < dimf then begin
dimlog:=dimlog+1;
vec[dimlog]:=random(100);
cargar_vector(vec,dimlog);
end;
end;
procedure encontrar_max (dimlog:integer ;vec:numeros; var max:integer);
begin
if dimlog > 0 then begin
	if max < vec[dimlog] then 
		max:=vec[dimlog];
encontrar_max(dimlog-1,vec,max);
end
else
writeln('Numero maximo:',max);
end;
procedure encontrar_min (dimlog:integer ;vec:numeros; var min:integer);
begin
if dimlog > 0 then begin
	if min > vec[dimlog] then 
		min:=vec[dimlog];
encontrar_min(dimlog-1,vec,min);
end
else
writeln('Numero minimo:',min);
end;
procedure sumar_numeros(dimlog:integer ;vec:numeros ;var res:integer);
begin
if dimlog > 0 then begin
	res:=res+vec[dimlog];
	sumar_numeros(dimlog-1,vec,res);
end
else
writeln(res);
end;
var
vec:numeros;
dimlog,max,min,res:integer;
begin
randomize;
dimlog:=0;
min:=999;
max:=0;
res:=0;
cargar_vector(vec,dimlog);
encontrar_max(dimlog,vec,max);
encontrar_min(dimlog,vec,min);
sumar_numeros(dimlog,vec,res);
end.
