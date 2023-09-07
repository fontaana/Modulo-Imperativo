{
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee
código de producto, fecha y cantidad de unidades vendidas. La lectura finaliza con el código de
producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendida.
Nota: El módulo debe retornar los dos árboles.

b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.

c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.
}
program ejercicio2;
type
venta=record
cod:integer;
mes:integer;
dia:integer;
ano:integer;
cant:integer;
end;

arbol=^nodo;
nodo=record
hi:arbol;
hd:arbol;
dato:venta;
end;

procedure leer_dato(var info:venta);
begin
	writeln('Ingresa codigo');
    readln(info.cod);
    if info.cod <> 0 then begin
{
    writeln('Ingresa mes');
    readln(info.mes);
    writeln('Ingresa dia');
    readln(info.dia);
    writeln('Ingresa año');
    readln(info.ano);
}
    writeln('Ingresa cantidad vendida');
    readln(info.cant);
end;
end;

procedure cargar_arbol_1 (var a:arbol;info:venta);
begin
    if a=nil then begin
    new(a);
    a^.hi:=nil;
    a^.hd:=nil;
    a^.dato := info;
    end
    else begin
    if info.cod >= a^.dato.cod then
        cargar_arbol_1(a^.hd,info)
    else 
        cargar_arbol_1(a^.hi,info)
end;
end;
procedure cargar_arbol_2(var a:arbol;info:venta);
begin
    if a=nil then begin
    new(a);
    a^.hi:=nil;
    a^.hd:=nil;
    a^.dato := info;
    end
    else begin 
    if info.cod=a^.dato.cod then
        a^.dato.cant:=a^.dato.cant+info.cant
    else begin
    if info.cod >= a^.dato.cod then
        cargar_arbol_2(a^.hd,info)
    else 
        cargar_arbol_2(a^.hi,info);
    end;
    end;
end;
procedure generar_arboles(var a1:arbol;var a2:arbol);
var
info:venta;
begin
leer_dato(info);
while info.cod <> 0 do begin
cargar_arbol_1(a1,info);
cargar_arbol_2(a2,info);
leer_dato(info);
end;
end;
procedure cant_producto_a2(a:arbol;codigo:integer;var cant:integer);
begin
if a <> nil then begin
if codigo = a^.dato.cod then
    cant:=a^.dato.cant
else begin
    if codigo >= a^.dato.cod then
        cant_producto_a2(a^.hd,codigo,cant)
    else
        cant_producto_a2(a^.hi,codigo,cant);
end;
end;
end;

procedure cant_producto_a1(a:arbol;codigo:integer;var cant:integer);
begin
if a<> nil then begin
if codigo = a^.dato.cod then
    cant:=cant+a^.dato.cant;
        if codigo >= a^.dato.cod then
            cant_producto_a1(a^.hd,codigo,cant)
        else
            cant_producto_a1(a^.hi,codigo,cant);
end;
end;

var
a1,a2:arbol; 
cant,codigo:integer;
begin
generar_arboles(a1,a2);
writeln('Ingrese el codigo del producto a buscar');
readln(codigo);
cant_producto_a1(a1,codigo,cant);
writeln('La cantidad vendida del producto ', codigo ,' es ', cant);
cant:=0;
cant_producto_a2(a2,codigo,cant);
writeln('La cantidad vendida del producto ', codigo ,' es ', cant);
end.
