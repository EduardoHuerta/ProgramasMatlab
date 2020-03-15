%% (1) Indexado lógico 
%Podemos realizar operaciones lógicas en el mismo índice, por ejemplo para
%etiquetar valores que cumplan cierta condición

a=magic(5) %creamos matriz 5x5
a(a>10)=0 % todos los valores que sean mayores a 10, cambiarlos por cero

%Podemos relacionar etiquetas de una matriz, en otra
b=ones(5) %Creamos matriz de 5x5 de 1's
b(a==0)=NaN %Todos los valores que sean cero en matriz a, en esa posición 
%pondremos NaN para la matriz b
% Pueden ponerse varias condiciones a la vez
% islogical(x) nos da 0 o 1 si valor es clase lógica
islogical(1)
islogical(true(2))
C = {1,true(3),3;'text',rand(5,10,2),{11; 22; 33}}
%uso de cell para leer datos
C(1,2) %Resultado es tipo cell
C{1,2} %Resultado es el contenido de esa celda
islogical(C)
cellfun(@islogical,C)
arrayfun(@islogical,magic(4))
xor(true, true) %lógica boobleana

%% Repetición y expansión de matrices

a=[1 2; 3 4]
b=repmat(a,2,3) %repetirá matriz o valor a 2 veces en filas, 3 en columnas
% Si Queremos vector [1 2 3] repetido hacia abajo 10 veces
a=[1 2 3]
b=repmat(a,10,1)
% Quiero definir vector de 1 a 10, de 0.5 incrementos 
%y repetirlo en 8 columnas
a=1:0.5:10
b=repmat(a,8,1)

% En caso de 2D, que querramos expandir en filas y columnas, preferible usar meshgrid
x = 1:3
y = 1:3
[X,Y] = meshgrid(x,y)

%¿Que hace meshgrid?

X = repmat(x,3,1)
Y = repmat(y',1,3)

%% Expansión implícita
%Creamos matriz 4x4 y vector columna 1x4
n=4
a=magic(n)
b=randi(9,n,1)
%Sin vectorización
tic
c1=zeros(size(a))
for cols=1:n
    temp_a = a(:,cols)
    temp_a = temp_a.*b
    c1(:,cols) = temp_a
end
toc        
%Para multiplicar por columnas, podemos aumentar vector b a matriz
tic
b_mat = repmat(b,1,n)
c2 = a.*b_mat
toc
%Expansión implícita (R2016b)
tic
c3=a.*b
toc
isequal(c1,c2,c3)

%% Tipo de dato struct

paciente(1).name = 'Juan Perez';
paciente(1).saldo = 1270.00;
paciente(1).examen = [79 75 73; 180 178 177.5; 220 210 205];

paciente(2).name = 'Fulano Menganillo';
paciente(2).saldo = 280.50;
paciente(2).examen = [68 70 68; 118 118 119; 172 170 169];

paciente
paciente(3).name = 'Nuevo nombre';
paciente(3)

%Podemos leer datos de un struct

saldo_pendiente = paciente(1).saldo

bar(paciente(1).examen)
title(['Resultados de exámenes para ', paciente(1).name])

direccion.calle = 'Av Hidalgo';
direccion.colonia = 'Juarez';
direccion.num = 34;

paciente(1).localizar = direccion;

%% String (procesamiento texto)

str = ["Mary Ann Jones","Christopher Matthew Burns","John Paul Smith"]
pattern = ["Ann","Paul"];
TF = contains(str,pattern)

str = 'bat cat can car coat court CUT ct CAT-scan'
expression = 'c[aeiou]+t'
startIndex = regexp(str,expression)

