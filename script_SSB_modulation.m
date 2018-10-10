%Preliminares
clear; clc;
fs = 1000;                  %Frecuencia de muestreo

%SE�AL TRIANGULAR ORIGINAL (MENSAJE)
fm = 16;                    %Frecuencia del mensaje
T = 1/fm;                   %Periodo fundamental
A = 2;                      %Amplitud de la se�al
pendiente = 4*A/T;          %Pendiente de la recta
t1 = (-T/4):(0.001*T):(T/4);
t2 = (T/4):(0.001*T):(3*T/4);
tfund = [t1 t2];            %Intervalo fundamental
t3 = tfund - T;             %Desplazamientos en funcion de T
t4 = tfund + T;
t = [t3 tfund t4];          %Intervalo de tiempo para 3T
x1 = [pendiente*t1 (-1*pendiente*t2+2*A)];%Se�al en el intervalo fundamental
m = [x1 x1 x1];             %Se�al para 3T

figure(1)
subplot(2,1,1); 
plot(t,m);
title('Mensaje a transmitir m(t)');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

%Gr�fica de la transformada de Fourier del mensaje
l = length(t);
f = fs*(-l/2:l/2-1)/l;%C�lculo del vector de frecuencias
m_fft = abs(fftshift(fft(m)))./l;%Transformada del mensaje

subplot(2,1,2);             %Gr�fica de la transformada del mensaje
plot(f,m_fft);
title('Transformada de Fourier de m(t)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');
xlim([-20,20]);
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MODULACION SSB                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CREACION DE LA SE�AL PORTADORA
Ac = 1;                     %Amplitud de la se�al portadora
Ka = 1;                     %Sensibilidad del transmisor
fc = 500;                   %Frecuencia de la portadora
c1 = Ac/2*cos(2*pi*fc*t);   %Portadora coseno
c2 = Ac/2*sin(2*pi*fc*t);   %Portadora seno (desfase de pi/2)

%MODULACION
mh = imag(hilbert(m));      %Transformada de Hilbert del mensaje
m_ussb = Ka*(m.*c1 - mh.*c2);%Mensaje modulado con banda lateral superior
m_lssb = Ka*(m.*c1 + mh.*c2);%Mensaje modulado con banda lateral inferior

figure(2)
subplot(2,2,1);             %Gr�fico de la se�al LSSB
plot(t,m_lssb); 
title('Se�al modulada LSSB');
xlabel('Time (s)');
ylabel('Amplitud (V)');
subplot(2,2,2);             %Gr�fico de la se�al USSB
plot(t,m_ussb);
title('Se�al modulada USSB');
xlabel('Time (s)');
ylabel('Amplitud (V)');

%Gr�fica de la transformada de Fourier de las se�ales moduladas
l = length(t);
f = fs*(-l/2:l/2-1)/l;      %C�lculo del vector de frecuencias
m_ussb_fft = abs(fftshift(fft(m_ussb)))./l;%Transformada de la se�al USSB
m_lssb_fft = abs(fftshift(fft(m_lssb)))./l;%Transformada de la se�al LSSB

subplot(2,2,3);             %Gr�fico de la transformada de la se�al 
plot(f,m_lssb_fft);         %modulada LSSB
title('Transformada de Fourier de la se�al modulada LSSB');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

subplot(2,2,4);             %Gr�fico de la transformada de la se�al
plot(f,m_ussb_fft);         %modulada LSSB
title('Transformada de Fourier de la se�al modulada USSB');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            DEMODULACION                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CREACION DEL OSCILADOR LOCAL
A_lo = 1;                   %Amplitud del oscilador local
lo = A_lo*cos(2*pi*fc*t);   %Se�al del oscilador local

%CREACION DEL FILTRO PASABAJOS
W = 20;                     %Ancho de banda del mensaje
wn = W/(fs/2);              %Frecuencia de corte normalizada: frecuencia
                            %de corte entre la mitad de la frecuencia de 
                            %muestreo
[num,den] = butter(4,wn,'low');%Obtencion del numerador y denominador de la 
                               %funcion de transferencia del filtro de tipo
                               %butterworth
H_pos = freqz(num,den,floor(length(m)/2));%Filtro para f>0
H_neg = fliplr(H_pos');                   %Filtro para f<0
H = [H_neg H_pos'];                       %Filtro para toda f

figure(3)
plot(f,abs(H))                %Grafica del filtro junto con
                              %la transformada de las senales
                              %moduladas

%DEMODULACION
y_ussb = m_ussb.*lo;         %Multiplicacion de la se�al USSB por el 
                             %oscilador local
y_lssb = m_lssb.*lo;         %Multiplicacion de la se�al LSSB por el 
                             %oscilador local
hold on
plot(f,abs(fftshift(fft(y_ussb)))/l) 

yd_ussb = filter(num,den,y_ussb);%Aplicacion del filtro a la USSB
yd_lssb = filter(num,den,y_lssb);%Aplicacion del filtro a la LSSB
figure(4)
plot(t,yd_ussb)

