% Archivo que al ejecutarlo, inicializa la salida de la placa de sonido de 
% nuestra PC en modo ESTEREOFONICO.
% Mueve el motor hacia la derecha.
% ---------------------------------------------------------------
 clear
tic
AO = analogoutput('winsound');
ch = addchannel(AO,1:2);            % agregamos canal derecho e izquierdo
%duration = 0.4;           %segundos
set(AO,'SampleRate',8000);               %Muestras por segundo de nuestra senal

set(AO,'TriggerType','Immediate');     %'Manual' o 'Immediate'
%set(AO,'StartFcn','saludo');                  % llamada a funcion
%set(AO,'StopFcn','despedida');            % llamada a funcion
%ActualRate = get(AO,'SampleRate');
%len = ActualRate*duration;

ruido = sin([0:0.01:4*pi]);
len=size (ruido);

silencio=zeros(len(2),1);

% ruido = 65535*ones(len,1);


% for i=1:4
%     if (rem(i,2)==0)
        putdata(AO,[silencio ruido']);
%     else
%         putdata(AO,[ruido silencio]);
%     end
% end

start(AO);
toc

