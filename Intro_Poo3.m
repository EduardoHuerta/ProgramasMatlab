Dstart = dateE7(28,1,2019)
Dstart.year.Value
char(Dstart)
Dend = dateE7(31,5,2019)
char(Dend)
%Char, en clase dateE7, manda a allamar a char de clase yearE7 ya que ahi
%est� definido para objetos de la clase yearE7, que en este caso es el a�o
Dstart.year

dayOfYear(Dstart)
dayOfYear(Dend)

Dstart+7 %Revisar linea 42, m�todo p�blico plus, que llama a m�todo privado
         %DateAddN de l�nea 61
         
Dend-Dstart %Funci�n minus, fecha mayor - fecha menor,  = d�as de diferencia

Dend>=Dstart %funci�n mayor o igual que, con objetos tipo dateE7
Dstart>=Dend

% La clase dateE7 define m�todos p�blicos y privados
%PUBLICOS: Accesibles para todo MATLAB, desde otras funciones o en consola
%PRIVADOS: Solo pueden acceder los m�todos de su misma clase

%Tambi�n se define los m�todos STATIC (default no lo son)

%STATIC: Los m�todos de este tipo, no requieren un objeto relativo a la
%clase par apoder funcionar, si la clase es de objetos tipo CHAR, un m�todo
%static puede usar datos numericos a la entrada, pertenece a la clase, pero
%no a instancias espec�ficas, normalmente se definen privados para que sea
%funcionalidad dentro de la clase solamente. Cambia el como se manda a
%llamar classname.staticMethodName(args,...)

%La clase dateE7 puede llamar m�todos de yearE7 ya que los m�todos en la
%clase yearE7 son p�blicos (default) as� que otras clases o programas de
%MATLAB pueden usarlos

%�Como sabe que funci�n llamar MATLAB si hicimos 2 PLUS, mas la interna de MATLAB?
%Orden para invocar m�todos de MATLAB:
%1 Subfunci�n visible en mismo script
%2 Funci�n en folder private
%3 Clases o funci�n en folder de trabajo
%4 El primer argumento de entrada es la clase dominante
%5 B�squeda de directorios internos

%Toda clase creada por usuario tiene preferencia a clases internas