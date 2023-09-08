{Implementar un programa modularizado para una librería que:
a. Almacene los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados la cantidad total de
unidades vendidas y el monto total. De cada venta se lee código de venta, código del
producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las
ventas finaliza cuando se lee el código de venta -1.
b. Imprima el contenido del árbol ordenado por código de producto.
c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el
código de producto con mayor cantidad de unidades vendidas.
d. Contenga un módulo que reciba la estructura generada en el punto a y un código de
producto y retorne la cantidad de códigos menores que él que hay en la estructura.
e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de
producto y retorne el monto total entre todos los códigos de productos comprendidos
entre los dos valores recibidos (sin incluir).}

program ejercicio01;
type
producto=record 
cod_venta:integer;
cod_producto:integer;
unidades:integer;
precio:integer;
total:real;
end;

arbol=^nodo;
nodo=record
hi:arbol;
hd:arbol;
elemento:producto;
end;

procedure calcular_total(var info:producto);
begin
info.total:=info.precio*info.unidades;
end;

procedure leer_informacion(var info:producto);
begin
writeln('Ingrese codigo de venta (-1 para terminar)');
readln(info.cod_venta);
if info.cod_venta <> -1 then begin
writeln('Ingrese codigo del producto');
readln(info.cod_producto);
writeln('Ingrese unidades vendidas');
readln(info.unidades);
writeln('Ingrese precio del producto');
readln(info.precio);
calcular_total(info);

end;

end;
procedure generar_arbol(var a:arbol;info:producto);
begin
if a = nil then begin
	new(a);
	a^.hi:=nil;
	a^.hd:=nil;
	a^.elemento:=info;
end
else 
if a^.elemento.cod_producto = info.cod_producto then begin 
	a^.elemento.total:=a^.elemento.total+info.total;
	a^.elemento.unidades:=a^.elemento.unidades+info.unidades;
end
else begin
if info.cod_producto >= a^.elemento.cod_producto then
	generar_arbol(a^.hd,info)
else
	generar_arbol(a^.hi,info);
end;
end;

procedure cargar_arbol(var a:arbol);
var
info:producto;
begin
leer_informacion(info);
while info.cod_venta <> -1 do begin
generar_arbol(a,info);
leer_informacion(info);
end;
end;

procedure imprimir_arbol(a:arbol);
begin
if a <> nil then begin
	imprimir_arbol(a^.hi);
	writeln(a^.elemento.cod_producto);
	imprimir_arbol(a^.hd);
end;
end;
procedure max_unidades(a:arbol;var max:integer);
begin
if a <> nil then begin
	if a^.elemento.unidades > max then 
		max:=a^.elemento.unidades;
	max_unidades(a^.hd,max);
	max_unidades(a^.hi,max);
end;
end;
procedure contar_productos_menores(a:arbol;codigo:integer;var cant:integer);
begin
if a <> nil then begin
	if a^.elemento.cod_producto < codigo then begin
			cant:=cant+1;
			contar_productos_menores(a^.hd,codigo,cant);
			contar_productos_menores(a^.hi,codigo,cant);
	end
	else
		contar_productos_menores(a^.hi,codigo,cant);
end;
end;
procedure calcular_monto_enrango(a:arbol;var total:real;codigo:integer;codigo2:integer);
begin
if a <> nil then begin
	if (a^.elemento.cod_producto > codigo) and (a^.elemento.cod_producto < codigo2) then begin
		total:=a^.elemento.total+total;
		calcular_monto_enrango(a^.hi,total,codigo,codigo2);
		calcular_monto_enrango(a^.hd,total,codigo,codigo2);
		end;
	end
	else begin
	if a^.elemento.cod_producto < codigo then 
		calcular_monto_enrango(a^.hd,total,codigo,codigo2)
	else
		calcular_monto_enrango(a^.hi,total,codigo,codigo2);
end;
end;
var
a:arbol;
max,cant,codigo,codigo2:integer;
total:real;
begin
a:=nil;
max:=0;
cant:=0;
cargar_arbol(a);
imprimir_arbol(a);
max_unidades(a,max);
writeln('El codigo maximo es: ',max);
writeln('Ingrese codigos menores a buscar que él ingresado que hay en la estructura');
readln(codigo);
contar_productos_menores(a,codigo,cant);
writeln('Ingrese extremo inferior del rango a contabilizar');
readln(codigo);
writeln('Ingrese extremo superior del rango a contabilizar');
readln(codigo2);
calcular_monto_enrango(a,total,codigo,codigo2);
writeln('El monto total en el rango es de: ',total);
end.
