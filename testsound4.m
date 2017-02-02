% Archivo que al ejecutarlo, inicializa la salida de la placa de sonido de 
% nuestra PC en modo ESTEREOFONICO.
% Con respecto al testsoun.m , aqui necesitamos el doble de memoria
% porque son 2 canales de informacion, igual se lo dejamos a Matlab.
% Con LOOP.
% Nota: saludo.m y despedida.m deben estar en el mismo PATH
% ---------------------------------------------------------------
clear

AO = analogoutput('winsound');
ch = addchannel(AO,1:2);            % agregamos canal derecho e izquierdo
duration = 0;           %segundos
set(AO,'SampleRate',8000);               %Muestras por segundo de nuestra senal

set(AO,'TriggerType','Immediate');     %'Manual' o 'Immediate'
set(AO,'StartFcn','saludo');                  % llamada a funcion
% set(AO,'StopFcn','despedida');            % llamada a funcion
ActualRate = get(AO,'SampleRate');
% len = ActualRate*duration;
len = ActualRate;

silencio=zeros(len,1);
% ruido = rand(len,1);
ruido = 65535*ones(len,1);
% ruido = 100*ones(len,1);


 
putdata(AO,[ruido silencio]);
% for i=1:300
%     putdata(AO,[ruido silencio]);
% end

start(AO);

