% Este programa redimensiona una imagen a un tamano tipico de web cam
% de 320x240 en donde puede trabajar a casi 30 FPS (24 FPS seguro), y
% pinta sobre la misma donde caerian los profiles.
% Luego analizaremos sola una capa y encontramos las cordenadas "x"  de
% los minimos en los profiles.
% Nota: el archivo f117.jpg debe estar en el mismo PATH
% --------------------------------------------------------------------
clear
% clc
% Nota: las coordenadas por defecto en matlab tienen el origen (0,0) en el angulo 
% superior izquierdo y ej eje X es positivo hacia la derecha y el eje Y es positivo 
% hacia abajo.
% Los numeros de este archivo se corresponde con una imagen de 240x320

superior=40;       % posicion Y de la linea superior
inferior=200;         % posicion Y de la linea superior

Original = imread('f117.jpg');	%cargamos la imagen
TamanoDeImagen=size(Original)

I=imresize(Original,[240 320],'nearest');       % interpolamos con el algoritmo 'nearest'
TamanoDeImagen=size(I)                              %redimensionada

imshow(I)			%muestra la imagen

%Sobre dibujo imagen anterior pinto menos (-) en los puntos 
X=[1:319];
Y=ones(1,319);
Y1=Y*superior;
Y2=Y*inferior;
hold on;
plot(X,Y1,'g-');
plot(X,Y2,'g-');
hold off

%Grafico los Profiles de las lineas analizadas (analizamos las columnas 20 hasta 300)
n=32;       % resolucion de la intensidad del profile
                % Acota la busqueda del blanco en la pantalla a "n" posiciones equidistantes dentro del profile
tic
% figure(2)
% Analizamos una sola capa "I(:,:,1)"
% subplot(2,1,1);
% improfile(I(:,:,1),[X(1) X(end)],[Y1(1) Y1(end)],n)

sup=improfile(I(:,:,1),[X(1) X(end)],[Y1(1) Y1(end)],n);
[f1,c1]=min(sup);
c1real=c1*n

% title('Profile Superior')
% subplot(2,1,2)
% improfile(I(:,:,1),[X(1) X(end)],[Y2(1) Y2(end)],n)

inf=improfile(I(:,:,1),[X(1) X(end)],[Y2(1) Y2(end)],n);
[f2,c2]=min(inf);
c2real=c2*n

% title('Profile Inferior')
toc                                                 % analisis temporal pedorro
