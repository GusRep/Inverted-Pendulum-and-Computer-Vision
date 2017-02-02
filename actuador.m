function actuador(F1,F2)
% Archivo que al ejecutarlo, inicializa la salida de la placa de sonido de nuestra PC en modo ESTEREOFONICO.
% Recibe las salidas del controlador difuso F1 y F2, que valen entre 0ms y 50e-3 s.  El controlador difuso 
% permite entregar una salida acondicionada.
% Envia una modulacion PWM por cada canal de la placa de sonido, para indicar la velocidad y sentido de 
% giro al motor que controla la base del pendulo.
% Condicion de Fin del programa:     F1<=0  y  F2<=0
%--------------------------------------------------------------------------
tic
persistent ao Fs    % las variables persistentes, son como variables  globales (trascienden a la funcion que
% las creo), pero a diferencia de las globales (que son vistas por todas las funciones), estas solo pueden ser
% vistas por diversas invocaciones de la funcion que las definio.

Tcycle=0.2;     % periodo del ciclo 200ms

%% Fin del programa
if ((F1<=0)&(F2<=0))
    stop(ao);
    delete ao
    clear ao Fs
    disp('Esta es la DESPEDIDA !!!');
    return
else

end

if length(ao)>0
    stop(ao);
else
    ao=analogoutput('winsound');
    addchannel(ao,1:2);                      % agregamos canal derecho e izquierdo
    Fs=8000;                                       %Fs es la frecuencia de muestreo de la salida

%     set(ao,'SampleRate',Fs,'RepeatOutput',inf);
    set(ao,'SampleRate',Fs,'RepeatOutput',0);

end

ncycle=Tcycle*Fs;    %cant de muestras de salida

len1=ceil(Fs*F1);       % con ceil redondeamos
len2=ceil(Fs*F2);
a1=ones(len1,1);        % variables auxiliares
a2=ones(len2,1);
dat1=[a1;-a1;ones(ceil(ncycle-2*len1),1)];  % concatena en columna
dat2=[a2;-a2;ones(ceil(ncycle-2*len2),1)];  % concatena en columna

putdata(ao,[dat1 dat2])
start(ao)
toc
return
