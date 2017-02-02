function PWMSound(Tp,Tcycle)
%
% Tp:       Pulse Width [sec]   typ.: 0.6-2.8e-3
% Tcycle:   Cycle Time [sec]    typ.: 10e-3
%
% create a pwm like output from the soundcard
% make sure volume control is set to maximum
% 
% stop:     Tp<0, or Tcycle<0
%
% mwunder@mathworks.de, December 2005
%
persistent ao Fs

%% reset
if Tcycle*Tp<0
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
    Fs=22050;

    set(ao,...
        'SampleRate',Fs,...
        'RepeatOutput',inf);
end

% cycle time typically: 10ms
ncycle=Tcycle*Fs;

len=ceil(Fs*Tp);
dat=[ones(1,len) -ones(1,len) zeros(1,ceil(ncycle-2*len))];

% dat=dat(1:ncycle);  agregando el ancho de pulso


% same for both channels 
% two channels planned for future
cero=0.*(dat');

putdata(ao,[dat' cero])
start(ao)

return
