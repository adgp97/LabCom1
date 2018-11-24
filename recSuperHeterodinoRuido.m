%% Modulacion FM y Receptor Superheterodino. LAB2 EC2422 (Comunicaciones I) Universidad Simón Bolivar

%%
%Receptor Superheterodino más ruido para arch2.mat

msg_RF = msg;
WLPF = 1600;        %Bt de los mensajes y del filtro Pasa Bajo
fc1 = 20000;        %Frecuencia de corte mensaje 1
fc2 = 35000;        %Frecuencia de corte mensaje 2
fif = 14000;        %Frecuencia Intermedia
flo1 = fc1 + fif;   %Frecuencia de oscilación para mensaje 1
flo2 = fc2 + fif;   %Frecuencia de oscilación para mensaje 2
W_IF = 2*1055;      %Bt de frecuencia intermedia                
freqdev = 1000;     %fdelta
fs = 110250;		%frecuencia de muestreo
N = 825000;		    %Numero de muestras
t = 0:1/fs:(N-1)/fs;

%Llamada a receptor Superheterodino
[y_A1, y_B1, y_C1, y_D1, y_E1]=recSuperHeterodino(msg_RF,flo1,freqdev,W_IF,WLPF,fs);
[y_A2, y_B2, y_C2, y_D2, y_E2]=recSuperHeterodino(msg_RF,flo2,freqdev,W_IF,WLPF,fs);

%%
%Demodulacion de los mensajes detectados usando comando fmdemod
 y1 = fmdemod(y_A1,fc1,fs,freqdev);		%freqdev: Desviación frecuencial
 sound(y1, fs);
 pause; 

 y2 = fmdemod(y_A2,fc2,fs,freqdev);
sound(y2, fs);
pause;

%%
%Gráficas para mensaje 1
fftplot(y_A1,fs);
title('Salida RF (y__A1)');
xlabel('f[Hz]');
ylabel('Amplitud[V]');
fftplot(y_B1,fs);
title('Salida mezcador (y__B1)');
xlabel('f[Hz]');
ylabel('Amplitud[V]');
fftplot(y_C1,fs);
title('Salida IF (y__C1)');
xlabel('f[Hz]');
ylabel('Amplitud[V]');
fftplot(y_D1,fs);
title('Salida detector FM (y__D1)');
xlabel('f[Hz]');
ylabel('Amplitud[V]');
fftplot(y_E1,fs);
title('Salida LPF (y__E1)');
xlabel('f[Hz]');
ylabel('Amplitud[V]');
pause;

%Gráficas para mensaje 2
fftplot(y_A2,fs);
title('Salida RF (y__A2)');
xlabel('f[Hz]');
ylabel('Amplitud[V]');
fftplot(y_B2,fs);
title('Salida mezclador (y__B2)');
xlabel('f[Hz]');
ylabel('Amplitud[V]');
fftplot(y_C2,fs);
title('Salida IF (y__C2)');
xlabel('f[Hz]');
ylabel('Amplitud[V]');
fftplot(y_D2,fs);
title('Salida detector FM (y__D2)');
xlabel('f[Hz]');
ylabel('Amplitud[V]');
fftplot(y_E2,fs);
title('Salida LPF (y__E2)');
xlabel('f[Hz]');
ylabel('Amplitud[V]'); 
%%
%Reproduccion de las emisoras por separado
sound(y_E1, fs);
pause;

sound(y_E2, fs);
pause;

%%
%Ruido Blanco Gaussiano al receptor para 5 valores de ruido aleatorio
for i = 1:5
    ngauss=rand(1,length(t));
    [n_A, n_B, n_C, n_D, n_E]=recSuperHeterodino(ngauss,flo1,freqdev,W_IF,WLPF,fs); %Ruido por receptor  aleatorio  
    nSalida(i)=mean(n_D.^2);
    nEntrada(i)=mean(n_C.^2);
    salidamensaje1(i)=mean(y_D1.^2);
    salidamensaje2(i)=mean(y_D2.^2);
    Entradamensaje1(i)=mean(y_C1.^2);
    Entradamensaje2(i)=mean(y_C2.^2);
end

%Relación Señal Ruido para el mensaje 1
SNR1=Entradamensaje1./nEntrada;
SND1=salidamensaje1./nSalida;
figure;
plot(SNR1,SND1), xlabel('{S_{R}/N_{R}}_{1}'), ylabel('{S_{D}/N_{D}}_{1}');
title('{S_{D}/N_{D}}_{1} vs. {S_{R}/N_{R}}_{1}');

%Relación Señal Ruido para el mensaje 2
SNR2=Entradamensaje2./nEntrada;
SND2=salidamensaje2./nSalida;

figure;
plot(SNR2,SND2), xlabel('{S_{R}/N_{R}}_{2}'), ylabel('{S_{D}/N_{D}}_{2}');
title('{S_{D}/N_{D}}_{2} vs. {S_{R}/N_{R}}_{2}');