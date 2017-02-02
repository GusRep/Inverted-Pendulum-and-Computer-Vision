function pwm(Tp,Tcycle)
%
% Tp:       Pulse Width [sec]   typ.: 0.6-2.8e-3
% Tcycle:   Cycle Time [sec]    typ.: 10e-3
%
% create a pwm like output from the soundcard
% make sure volume control is set to maximum
% 
% stop:     Tp<0, or Tcycle<0

persistent ao Fs    % las variables persistentes, son como variables  globales (trascienden a la funcion que
% las creo), pero a diferencia de las globales (que son vistas por todas las funciones), estas solo pueden ser
% vistas por diversas invocaciones de la funcion que las definio.


%% reset
if ((Tcycle<=0) |(Tp<=0))
    stop(ao);
    delete ao
    clear ao Fs
    return
end

%% create new ao object
if length(ao)>0
    stop(ao);
else
    ao=analogoutput('winsound');
    addchannel(ao,1:2);
    % Sample Rate for SoundCard
    Fs=8000;

    set(ao,...
        'SampleRate',Fs,...
        'RepeatOutput',inf);
end

ncycle=Tcycle*Fs;    %cant de muestras de salida

len=ceil(Fs*Tp);
dat=[ones(1,len) -ones(1,len) ones(1,ceil(ncycle-2*len))]; % concatena
%dat=[ones(1,len)  ones(1,ceil(ncycle-len))]; % concatena

otro = 0.5*ones(length(dat),1);


putdata(ao,[dat' otro])
start(ao)

return
