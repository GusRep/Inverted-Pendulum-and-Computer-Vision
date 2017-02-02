% Veamos los dispositivos de sonido que tenemos
daqhwinfo('winsound')

% Comenzamos:

duration=44;
ao=analogoutput('winsound');
ActualRate = get(ao,'SampleRate');
len = ActualRate*duration;

data = 65535*ones(len,1);
ruido = rand(len,1);

addchannel(ao,1:2);

for i=1:1
putdata(ao,[data 0.1*ruido]);
end
start(ao);

% waittilstop(ao,duration*1.1);
pause(1);
stop(ao);
clear;
