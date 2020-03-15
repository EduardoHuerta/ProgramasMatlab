classdef dateE7
    properties (SetAccess = private) %Propiedades solo pueden modificarse a través de métodos
        day = 1;     %Default es 1 de enero año 1
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
        %El método m2m está asociado con la clase dateE7, pero al ser
        %llamado, no hay ningun argumento de dateE7 en su entrada, los
        %métodos con esta característica son STATIC. Este método es privado
        %Solo métodos dentro de clase dateE7 pueden usarlo
        function charMonth = m2m(numericalMonth)
            %Solo cambia de numero a mes, como es STATIC, entonces la
            %manera de invocar a este método es: 
            %outputArg = dateE7.m2m(inputArg)
            %Así MATLAB sabe donde debe buscar este método, en clase dateE7
            M = ['Ene';'Feb';'Mar';'Abr';'May';'Jun';'Jul';'Ago';'Sep';...
                'Oct';'Nov';'Dec'];
            %Es PRIVATE para que solo pueda usarse dentro de esta clase, no
            %fuera de MATLAB
            charMonth = M(numericalMonth,:);
        end
    end
    methods % Funciones básicas de clase
        function C = char(date)
            %Método clásico, convierte un objeto de clase date al texto
            % "Ene 1 19xx" usando el método STATIC para conversión del mes
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
                error('Suma inválida');
            end
        end
        function TF = ge(D1,D2) % dateE7Obj1 >= dateE7Obj2
            Y = D1.year>D2.year; %Método de yearE7
            YM = D1.year==D2.year && D1.month>D2.month;
            YMD = D1.year==D2.year && D1.month==D2.month && D1.day>=D2.day;
            TF = Y||YM||YMD;
        end
        function N = minus(D1,D2) % dateObj1 - dateObj2
            N = daysbetween(D2.year,D1.year) - dayOfYear(D2) + dayOfYear(D1);
        end
    end
    methods (Access = private) %Método solo visible para métodos que
        %pertenezcan a la clase dateE7
        function ndate = DateAddN(dateObj,Na) %(DateE7,INT)
            %Suma Na dias al objeto dateE7 y el resultado es un objeto
            %dateE7
            nDY = nDays(dateObj.year); %Número dias del año
            N = dayOfYear(dateObj); %Número de día de la fecha
            while (N+Na)>nDY %en caso de que la suma sea mayor a 365, ajustar
                Na = (N+Na)-nDY-1;
                dateObj = dateE7(1,1,dateObj.year.Value+1);
                nDY = nDays(dateObj.year); %Método de year E7
                N = 1;
            end
            [d,m] = n2dm(N+Na,dateObj.year); %Método de yearE7
            ndate = dateE7(d,m,dateObj.year);
        end
    end
end

