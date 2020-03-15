Dstart = dateE7(28,1,2019)
Dstart.year.Value
char(Dstart)
Dend = dateE7(31,5,2019)
char(Dend)
%Char, en clase dateE7, manda a allamar a char de clase yearE7 ya que ahi
%está definido para objetos de la clase yearE7, que en este caso es el año
Dstart.year

dayOfYear(Dstart)
dayOfYear(Dend)

Dstart+7 %Revisar linea 42, método público plus, que llama a método privado
         %DateAddN de línea 61
         
Dend-Dstart %Función minus, fecha mayor - fecha menor,  = días de diferencia

Dend>=Dstart %función mayor o igual que, con objetos tipo dateE7
Dstart>=Dend

% La clase dateE7 define métodos públicos y privados
%PUBLICOS: Accesibles para todo MATLAB, desde otras funciones o en consola
%PRIVADOS: Solo pueden acceder los métodos de su misma clase

%También se define los métodos STATIC (default no lo son)

%STATIC: Los métodos de este tipo, no requieren un objeto relativo a la
%clase par apoder funcionar, si la clase es de objetos tipo CHAR, un método
%static puede usar datos numericos a la entrada, pertenece a la clase, pero
%no a instancias específicas, normalmente se definen privados para que sea
%funcionalidad dentro de la clase solamente. Cambia el como se manda a
%llamar classname.staticMethodName(args,...)

%La clase dateE7 puede llamar métodos de yearE7 ya que los métodos en la
%clase yearE7 son públicos (default) así que otras clases o programas de
%MATLAB pueden usarlos

%¿Como sabe que función llamar MATLAB si hicimos 2 PLUS, mas la interna de MATLAB?
%Orden para invocar métodos de MATLAB:
%1 Subfunción visible en mismo script
%2 Función en folder private
%3 Clases o función en folder de trabajo
%4 El primer argumento de entrada es la clase dominante
%5 Búsqueda de directorios internos

%Toda clase creada por usuario tiene preferencia a clases internas