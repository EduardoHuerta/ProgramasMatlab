classdef empleadoA
    properties
        Name
        Category = 'Trainee'
        IDnumber
        email
    end
    
    methods % funciones u operaciones permitidas
        function E = set.Name(E,name)
            %Name debe ser una sola fila, tipo char
            if ischar(name) && ndims(name)==2 && size(name,1)==1
                E.Name=name;
            else
                error('campo ''Name'' inválido');
            end
        end
        
        function E = set.Category(E,newCategory)
            %Category debe ser una opción específica
            if ismember(newCategory,["Trainee" "Base" "Confianza"])
                E.Category=newCategory;
            else
                error('campo Category debe ser Trainee, Base o Confianza');
            end
        end
        
        function E = set.IDnumber(E,newIDnumber)
            %IDnumber debe ser un número escalar
            if isnumeric(newIDnumber) && isscalar(newIDnumber) && ceil(newIDnumber)==newIDnumber && newIDnumber>0
                E.IDnumber=newIDnumber;
            else
                error('campo IDnumber debe ser un numero entero y positivo');
            end
        end
    end
end