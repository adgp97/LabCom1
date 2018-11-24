%% Modulacion FM y Receptor Superheterodino. LAB2 EC2422 (Comunicaciones I) Universidad Simón Bolivar


%% Función msg
% Función creada para seleccionar el mensaje a utilizar

function [msg] = selmensajeFM(selector)

if (selector==0)    %Selecciona el mensaje de Tono
    Am=2;           %Amplitud del mensaje
    fm=500;         %Frecuencia del mensaje
    fs=110250;      %frecuencia de muestreo.
    N=825000;       %Numero de muestras
    %t =-fs/2:fs/(length(msg)-1):fs/2;
    %t=0:1/fs:N/(fs-1);
    t=0:1/fs:(N-1)/fs;
    msg = Am*cos(2*pi*fm*t);    %Expresión tono
end

if (selector==1)    %Selecciona el mensaje arch1.mat
    load arch1.mat;
    msg = msg1;  
    
end

if (selector==2)    %Selecciona el mensaje arch2.mat
    load arch2.mat;
    msg = y_rf_tot;    
end