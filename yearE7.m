classdef yearE7
    properties (SetAccess = private) %Al definir como privadas, estas
        %propiedades se pueden leer solamente, no podemos usar SET fuera de
        %sus métodos de clase
        
        Value = 1; 
        Bisiesto = false;
        M=[31 28 31 30 31 30 31 31 30 31 30 31];
        
    end
    methods
        function Y = yearE7(Yv) %constructor method mismo nombre de clase y archivo
% El usuario va a poder construir objetos de clase yearE7, ymandando a
% llamar un valor entero (Yv), un objeto Y se creará con los métodos de
% clase en una primera instancia
            if nargin==1
                if isscalar(Yv) && isnumeric(Yv) && floor(Yv)==ceil(Yv) && Yv>0
                    Y.Value = Yv;
                    Y.Bisiesto = rem(Yv,4)==0 && (rem(Yv,100)~=0 || rem(Yv,400)==0);
                    if Y.Bisiesto
                        Y.M(2)=29;
                    end
                elseif isa(Yv,'yearE7') %si es E7 el año, entonces pasa
                    Y = Yv;
                else
                    error('Invalid Yv')
                end
            end
        end
        % todas estas funciones son métodos públicos, deben tener argumento
        % de entrada Y, que es la salida del constructor, se probaran de
        % uno en uno, quitando comentarios de cada función
        function N = nDays(Y) % Obtener los días del año
            N = sum(Y.M); 
        end
        function C = char(Y) %convertir año en tipo char
            C = int2str(Y.Value);
        end
        function [d,m] = n2dm(Nday,Y) % Nos indique a que mes pertenece un dia del año
            cM = cumsum(Y.M); %dia 200, año 202 cM=[31 60 91 121 152 182 213 244 274 305 335 366]
            m = find(Nday<=cM,1); % Encuentra la posición donde el dia sea menor, para 200 es 213, pos 7
            d = Nday - sum(Y.M(1:m-1)); % solo resta dias hasta mes anterior, 200-182 = 18
        end
        %Tercera parte
        function Y2 = plus(Y1,Y2) %Habilitamos operador '+' para esta clase
            Y2 = yearE7(Y2.Value+Y1.Value);
        end
        function Y2 = minus(Y1,Y2) %Habilitamos operador '-' para esta clase
            Y2 = yearE7(Y1.Value-Y2.Value);
        end
        function F = eq(Y1,Y2) % Habilitamos operador == para esta clase
            F = Y1.Value==Y2.Value;
        end
        function F = ge(Y1,Y2) % Habilitamos operador >= para esta clase
            F = Y1.Value>=Y2.Value;
        end
        function F = gt(Y1,Y2) % Habilitamos operador > para esta clase
            F = Y1.Value>Y2.Value;
        end
        function F = le(Y1,Y2) % Habilitamos operador <= para esta clase
            F = Y1.Value<=Y2.Value;
        end
        function F = lt(Y1,Y2) % Habilitamos operador < para esta clase
            F = Y1.Value<Y2.Value;
        end
        function DB = daysbetween(Y1,Y2) % Calcula número de días entre 2 años
            DB = 0;
            for k=Y1.Value:Y2.Value-1
                tmp = yearE7(k);
                DB = DB + nDays(tmp);
            end
        end
        
    end
    
end