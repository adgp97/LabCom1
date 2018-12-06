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
    [ngauss_A, ngauss_B, ngauss_C, ngauss_D, ngauss_E]=recSuperHeterodino(ngauss,flo1,freqdev,W_IF,WLPF,fs); %Ruido por receptor  aleatorio  
    power_ngauss_out(i) = mean(ngauss_E.^2);
    power_ngauss_in(i) = mean(ngauss.^2);
    msg_n = ngauss + msg_RF;
    [msg_n_A, msg_n_B, msg_n_C, msg_n_D, msg_n_E]=recSuperHeterodino(msg_n,flo1,freqdev,W_IF,WLPF,fs); %Ruido por receptor  aleatorio  
    power_msg_n_out(i) = mean(msg_n_E.^2);
    power_msg_n_in(i) = mean(msg_n.^2);
    SNR_D(i) = 10*log( power_msg_n_out(i) / power_ngauss_out(i));
    SNR_R(i) = 10*log(power_msg_n_in(i) / power_ngauss_in(i));
end

