% Preliminares
clc;
clear;

% Frecuencia de muestreo
fs = 10000;
% Vector de tiempo
t = -pi/4:1/fs:pi/4-1/fs;

% Construccion de la señal
fo = 20;
x = 2*cos(2*pi*fo*t);

% Graficar la señal
figure(1);
plot(t,x);
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%% METODO 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vector de frecuencia
l = length(x);
o = nextpow2(l);
N = 2.^o;
f = fs.*(-N/2:N/2-1)/N;

% Transformada de Fourier
xfft = fft(x,N)/l;

% Grafica de la trnasformada
 modulo = abs(fftshift(xfft));
 %fase = atan2(imag(xfft),real(xfft));
 fase = atan(xfft);
 
 figure(2)
 subplot(2,1,1);plot(f,modulo);title('Modulo de la Transformada de Fourier')
 subplot(2,1,2);plot(f,fase);title('Fase de la Transformada de Fourier')
 
% % Antitransformada de Fourier
% x2 = ifft(xfft)*l;
% b = x2(1:length(t));
% 
% % Graficar la antitransformada
% figure(3);
% plot(t,b);

%%%%%%%%%%%%%%%%%%%%%%%%%%%% METODO 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Nsamps = length(x);
x_fft = abs(fftshift(fft(x)))./Nsamps;            %Retain Magnitude
%x_fft = x_fft(1:Nsamps/2);      %Discard Half of Points
f = fs*[-1*fliplr(0:Nsamps/2 - 1) (0:Nsamps/2)]/Nsamps;   %Prepare freq data for plot

%Plot Sound File in Frequency Domain
figure
plot(f, x_fft)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('Frequency Response of Tuning Fork A4')

