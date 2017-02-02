% Conversion del resultado del controlador en una salida
clear
% n es la salida difusa

n1=1
n2=0

N1=floor(n1*8000);
N2=floor(n2*8000);
a1=ones(N1,1);
a2=ones(N2,1);
b1=zeros(8000-N1,1);
b2=zeros(8000-N2,1);

c1=[a1;b1];	    %vector de salida
c2=[a2;b2];	    %vector de salida

% c al canal correspondiente de la placa de sonido

ao = analogoutput('winsound');
ch = addchannel(ao,1:2);            % agregamos canal derecho e izquierdo
set(ao,'SampleRate',8000);               %Muestras por segundo de nuestra senal
set(ao,'TriggerType','Immediate');     %'Manual' o 'Immediate'


putdata(ao,[c1 c2]);

start(ao);
% waittilstop(ao,1);
pause(0.12)
stop(ao);

