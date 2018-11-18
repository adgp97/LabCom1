%% Modulacion FM y Receptor Superheterodino. LAB2 EC2422 (Comunicaciones I) Universidad Simón Bolivar

%% 
% Una vez seleccionado arch1.mat, se grafica el mensaje en el
% tiempo y su espectro de magnitud.

%Constantes
fs=110250;
fc=30000;
N=825000;
%t =-fs/2:fs/(length(msg)-1):fs/2;
%t=0:1/fs:N/(fs-1);
t=0:1/fs:(N-1)/fs;

%Gráficas del mensaje arch1 en Tiempo
plot(t,msg);
title('Mensaje arch1 en el Dominio Temporal');
xlabel('Tiempo[s]');
ylabel('Amplitud[V]');

%Gráficas del mensaje Tono en Frecuencia
MSG=fftplot(msg,fs/10);    %Transf Fourier y gráfica de arch1
title('Espectro de arch1');
xlabel('Frecuencia[Hz]');
xlim([-600 600]);
ylabel('Amplitud[V]');

%%
%Modulando mensaje usando comando fmmod

B=1000; %Ancho de banda del mensaje arch1.mat
Delta1=1;   %Coeficiente de desviación
deltaf1=Delta1*B;	%Desviación frecuencial

XD1=fmmod(msg,fc,fs,deltaf1);
fftplot(XD1,fs/10);
title('Modulación FM de arch1 para Delta=1');
xlabel('frecuencia [Hz]');
ylabel('Amplitud [V]');


Delta2=5;   %Coeficiente de desviación
deltaf2=Delta2*B;

XD2=fmmod(msg,fc,fs,deltaf2); 
fftplot(XD2,fs/10);
title('Modulación FM de arch1 para Delta=5');
xlabel('frecuencia [Hz]');
ylabel('Amplitud [V]');


Delta3=10;  %Coeficiente de desviación
deltaf3=Delta3*B;

XD3=fmmod(msg,fc,fs,deltaf3);  
fftplot(XD3,fs/10);
title('Modulación FM de arch1 para Delta=10');
xlabel('frecuencia [Hz]');
ylabel('Amplitud [V]');