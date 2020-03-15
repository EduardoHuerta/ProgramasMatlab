f = uifigure;
flag=myprogress(f);
   if flag==false
        uialert(f,'Proceso fue terminado','Status del proceso','Icon','success');
   else
       uialert(f,'Proceso fue cancelado','Status del proceso','Icon','error');
   end

function flag=myprogress(f)
    
    d = uiprogressdlg(f,'Title','aproximando Pi',...
        'Message','1','Cancelable','on','icon','info');

    % Approximate pi^2/8 as: 1 + 1/9 + 1/25 + 1/49 + ...
    pisqover8 = 1;
    denom = 3;
    valueofpi = sqrt(8 * pisqover8);
    steps = 20000;
    flag=false;
    for step = 1:steps 
        % Check for Cancel button press
        if d.CancelRequested
            flag = true;
            break
        end
        % Update progress, report current estimate
        d.Value = step/steps;
        d.Message = sprintf('%12.9f',valueofpi);

        % Calculate next estimate
        pisqover8 = pisqover8 + 1 / (denom * denom);
        denom = denom + 2;
        valueofpi = sqrt(8 * pisqover8);
    end

    % cierra cuadro de diálogo
    
    close(d);
   
    msg = 'El proceso ha terminado ¿Que desea hacer?';
title = 'Acción a seguir';
selection = uiconfirm(f,msg,title,...
           'Options',{'Terminar','Repetir'},'DefaultOption',1);
   if isequal(selection,'Repetir')
       flag=myprogress(f);
   end
   

    
    
end

