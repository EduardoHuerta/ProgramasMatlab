% Intro_POO

% Comandos a ejecutar en clase

M=[2 3; 4 5; 6 7]
C=[{M} {'ew7'}; {pi} {[]}; {[2 7]} {3}]
size(M)
size(C)
M(1,2)
C(1,2)
% M+M
% C+C
% M{3,2}
% C{3,2}

%¿Porque no usar struct?

X(1).Name = 'Pedro picapiedra';
X(2).name = 'Pablo marmol';
X(3).Name = 'Bam Bam';
X(1).ID = '123456';
X(2).ID = 56974;
X(3).ID = 002598;

% Creación de clase empleado, ejemplo de uso
% Ver empleado.m antes
E=empleado;
whos E
E.Name='Juan Perez';
E.IDnumber=12345;
E.Category='Confianza';
E %muestra contenido de variable
% E.category='Base'; %No se puede crear propiedad nueva

%Aun puedo modificar contenidos sin restricción
E.Name=eye(5);
E.IDnumber = {};
E.Category = 'Fulano';

% ¿Como restringir datos?
% ver empleadoA.m antes 
E=empleado;
E.Name=eye(5);
%Probamos métodos con restricciones
A=empleadoA;
% A.Name = [1 2 3];
A.Name = 'Sam Bigotes';
% A.Category = 'Patrón';
A.Category = 'Base';
% A.IDnumber = -5.36
A.IDnumber = 100021;