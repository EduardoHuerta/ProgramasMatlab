classdef dateE7
    properties (SetAccess = private) %Propiedades solo pueden modificarse a trav�s de m�todos
        day = 1;     %Default es 1 de enero a�o 1
        month = 1;
        year = yearE7(1);
    end
    methods %constructor simple
        function D=dateE7(d,m,y)
            D.year = yearE7(y);
            D.month = m;
            D.day = d;
        end
    end
    
    methods (Static = true, Access = private)
        %El m�todo m2m est� asociado con la clase dateE7, pero al ser
        %llamado, no hay ningun argumento de dateE7 en su entrada, los
        %m�todos con esta caracter�stica son STATIC. Este m�todo es privado
        %Solo m�todos dentro de clase dateE7 pueden usarlo
        function charMonth = m2m(numericalMonth)
            %Solo cambia de numero a mes, como es STATIC, entonces la
            %manera de invocar a este m�todo es: 
            %outputArg = dateE7.m2m(inputArg)
            %As� MATLAB sabe donde debe buscar este m�todo, en clase dateE7
            M = ['Ene';'Feb';'Mar';'Abr';'May';'Jun';'Jul';'Ago';'Sep';...
                'Oct';'Nov';'Dec'];
            %Es PRIVATE para que solo pueda usarse dentro de esta clase, no
            %fuera de MATLAB
            charMonth = M(numericalMonth,:);
        end
    end
    methods % Funciones b�sicas de clase
        function C = char(date)
            %M�todo cl�sico, convierte un objeto de clase date al texto
            % "Ene 1 19xx" usando el m�todo STATIC para conversi�n del mes
            C = [dateE7.m2m(date.month) ' ' int2str(date.day) ', '...
                char(date.year)];
        end
        function N = dayOfYear(date)
            N = date.day + sum(date.year.M(1:date.month-1));
        end
        function ndate = plus(D,N) %dateE7Obj1 + numeric ORDEN IMPORTA
            if isa(D,'dateE7') && isnumeric(N)
                ndate = DateAddN(D,N);
            else
                error('Suma inv�lida');
            end
        end
        function TF = ge(D1,D2) % dateE7Obj1 >= dateE7Obj2
            Y = D1.year>D2.year; %M�todo de yearE7
            YM = D1.year==D2.year && D1.month>D2.month;
            YMD = D1.year==D2.year && D1.month==D2.month && D1.day>=D2.day;
            TF = Y||YM||YMD;
        end
        function N = minus(D1,D2) % dateObj1 - dateObj2
            N = daysbetween(D2.year,D1.year) - dayOfYear(D2) + dayOfYear(D1);
        end
    end
    methods (Access = private) %M�todo solo visible para m�todos que
        %pertenezcan a la clase dateE7
        function ndate = DateAddN(dateObj,Na) %(DateE7,INT)
            %Suma Na dias al objeto dateE7 y el resultado es un objeto
            %dateE7
            nDY = nDays(dateObj.year); %N�mero dias del a�o
            N = dayOfYear(dateObj); %N�mero de d�a de la fecha
            while (N+Na)>nDY %en caso de que la suma sea mayor a 365, ajustar
                Na = (N+Na)-nDY-1;
                dateObj = dateE7(1,1,dateObj.year.Value+1);
                nDY = nDays(dateObj.year); %M�todo de year E7
                N = 1;
            end
            [d,m] = n2dm(N+Na,dateObj.year); %M�todo de yearE7
            ndate = dateE7(d,m,dateObj.year);
        end
    end
end

