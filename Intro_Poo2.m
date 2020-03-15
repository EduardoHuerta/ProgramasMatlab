%Clase 2 de MATLAB orientado a objetos, primer ver archivo yearE7, se
%definen propiedades privadas y una funci�n como constructor, la cual va a
%crear el objeto con m�todos que definamos o bien ciertas propiedades de
%default
% Ejemplo yearE7 hasta linea 30
yearE7 %Crea objeto con propiedades default

Y = yearE7(2019) %Crea objeto usando constructor y define nuevas propiedades
                 % Las porpiedades son las que definimos co el constructor
% Y = yearE7(125.3) %En caso de numero inv�lido arroja error
Y = yearE7(2020)
% Y.M(5) = 32     % Las propiedades al ser privadas, solo se pueden leer
% Y = yearE7(2020,2021) % Solo acepta 1 argumento

% Ahora vamos a definir m�todos p�blicos para la clase y aumentar sus funciones,
% pasamos a yearE7.m despu�s de linea 30

Y = yearE7(2020) %notar que muestra propiedades
nDays(Y) % Podemos aplicar m�todo p�blico, exclusivo de clase yearE7
% nDays(1999) %Da error porque 1999 es clase double, no clase yearE7
% Quitamos comentario a m�todos p�blicos restantes
char(Y) %entrega a�o en caracteres
[d,m] = n2dm(200,Y) %debuguear ejemplo en c�digo de yearE7
%Ahora a�adiremos operadores para hacer algunas operaciones adicionales
YN = yearE7(2019);
YB = yearE7(1995);
YN>=YB
YN-YB
daysbetween(YB,YN)
