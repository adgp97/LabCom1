%% Modulacion FM y Receptor Superheterodino. LAB2 EC2422 (Comunicaciones I) Universidad Simón Bolivar

%% 
% Gráfica del mensaje tono en el tiempo y su espectro de magnitud.

%Constantes
fs=110250;
fm=500;
fc=30000;
N=825000;
Am=2;
%t =-fs/2:fs/(length(msg)-1):fs/2;
%t=0:1/fs:N/(fs-1);
t=0:1/fs:(N-1)/fs;

%Gráficas del mensaje Tono en Tiempo
figure(1)
plot(t,msg);
title('Mensaje Tono en el Dominio Temporal');
xlabel('Tiempo[s]');
xlim([0 0.01]);
ylabel('Amplitud[V]');
grid on

%Gráficas del mensaje Tono en Frecuencia
MSG=fftplot(msg,fs);    %Transf Fourier y gráfica del tono
title('Espectro del Tono');
xlabel('Frecuencia[Hz]');
ylabel('Amplitud[V]');
grid on

%%
%Modulación FM con fmmod. La frecuencia del tono usado como
%mensaje es constante. En consecuencia se varía la amplitud.
%beta = kf*Am/fm => Am = beta*fm/kf
kf = 4000;  %Valor arbitratio
Am0 = fm/kf; 
Am1 = Am0;      %beta=1
Am2 = 2*Am0;    %beta=2 
Am3 = 5*Am0;    %beta=5
%La frecuencia de desviacion viene dada como deltaf = beta*fm
deltaf1 = 1*fm;%deltaf = beta*fm con beta = 1
deltaf2 = 2*fm;%deltaf = beta*fm con beta = 2
deltaf3 = 5*fm;%deltaf = beta*fm con beta = 5


%Señales con la variación de amplitud dado por beta
xAM1 = Am1*cos(2*pi*fm*t);
xAM2 = Am2*cos(2*pi*fm*t); 
xAM3 = Am3*cos(2*pi*fm*t); 

%Modulación con beta=1
XAM1=fmmod(xAM1,fc,fs,deltaf1);    %Comando modulacionFM MATLAB 
fftplot(XAM1,fs);
title('Modulación FM del Tono para beta=1 y Amplitud Am1=0.125');
xlabel('frecuencia [Hz]');
ylabel('Amplitud [V]');


XAM2=fmmod(xAM2,fc,fs,deltaf2);    %Comando modulacionFM MATLAB 
fftplot(XAM2,fs);
title('Modulación FM del Tono para beta=2 y Amplitud Am2=0.625');
xlabel('frecuencia [Hz]');
ylabel('Amplitud [V]');


XAM3=fmmod(xAM3,fc,fs,deltaf3);    %Comando modulacionFM MATLAB
fftplot(XAM3,fs);
title('Modulación FM del Tono para beta=5 y Amplitud Am3=0.8');
xlabel('frecuencia [Hz]');
ylabel('Amplitud [V]');
    
    
    
%%
%Modulación FM con fmmod. La amplitud del tono usado como
%mensaje es constante. En consecuencia se varía la frecuencia.
%beta = kf*Am/fm => fm = kf*Am/beta
kf = 4000;  %Valor arbitrario
fm0 = kf*Am;
fm1 = fm0;   %beta=1;  
fm2 = fm0/2; %beta=2; 
fm3 = fm0/5; %beta=5;
%Frecuencias de desviacion
deltaf1 = 1*fm1;%deltaf = beta*fm con beta = 1
deltaf2 = 2*fm2;%deltaf = beta*fm con beta = 2
deltaf3 = 5*fm3;%deltaf = beta*fm con beta = 5

%Señales con la variación de frecuencia de beta
xfAM1=Am*cos(2*pi*fm1*t);
xfAM2=Am*cos(2*pi*fm2*t); 
xfAM3=Am*cos(2*pi*fm3*t); 

%Modulación con beta=1
XfAM1=fmmod(xfAM1,fc,fs,deltaf1);    %Comando modulacionFM MATLAB 
fftplot(XfAM1,fs);
title('Modulación FM del Tono para beta=1 y Frecuencia fm1=8000');
xlabel('frecuencia [Hz]');
ylabel('Amplitud [V]');


XfAM2=fmmod(xfAM2,fc,fs,deltaf2);    %Comando modulacionFM MATLAB 
fftplot(XfAM2,fs);
title('Modulación FM del Tono para beta=2 y Frecuencia fm2=4000');
xlabel('frecuencia [Hz]');
ylabel('Amplitud [V]');


XfAM3=fmmod(xfAM3,fc,fs,deltaf3);    %Comando modulacionFM MATLAB
fftplot(XfAM3,fs);
title('Modulación FM del Tono para beta=5 y Frecuencia fm3=1600');
xlabel('frecuencia [Hz]');
ylabel('Amplitud [V]');
