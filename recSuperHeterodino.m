%% Modulacion FM y Receptor Superheterodino. LAB2 EC2422 (Comunicaciones I) Universidad Simón Bolivar

%%
%Receptor Superheterodino para arch2.mat
%Esta funcion crea los filtros para ser aplicados al archivo arch2.mat
%y asi separar las emisoras del mensaje

function [y_A, y_B, y_C, y_D, y_E] = recSuperHeterodino(msg_RF, flo, freqdev, W_IF, W, fs)
    
    N=825000;               %Numero de muestras
    t = 0:1/fs:(N-1)/fs;    %fs: frecuencia de muestreo
    fif = 14000;            %Frecuencia intermedia
    fc = flo - fif;         %Frecuencia Corte dependiente de frecuencia oscilador local
    
    %Filtro de RadioFrecuencia
    W_RF = 5500;        %Ancho de banda filtro pasabanda = 5.5KHz
    f3dB1_RF = fc - W_RF/2; % Frecuencia de corte inicial del filtro RF
    f3dB2_RF = fc + W_RF/2; % Frecuencia de corte final del filtro RF
    RF = fdesign.bandpass('N,F3dB1,F3dB2', 4, f3dB1_RF, f3dB2_RF, fs);
    RF = design(RF, 'butter');
    y_A = filter(RF, msg_RF);       % Obtener y_A msg_RF es el mensaje arch2.mat
    
    %Mezclador de Oscilador Local
	y_B = y_A .* cos(2*pi*flo*t);     % Obtener y_B
    
    %Filtro de Frecuencia Intermedia
    f3dB1_IF = fif - W_IF/2;        % Frecuencia de corte del inicial del filtro IF
    f3dB2_IF =  fif + W_IF/2;       % Frecuencia de corte final del filtro IF
	IF = fdesign.bandpass('N,F3dB1,F3dB2', 4, f3dB1_IF, f3dB2_IF, fs); 
    IF = design(IF, 'butter');
    y_C = filter(IF, y_B);      % Obtener y_C
    
    %Detección FM (llevarlo a banda base y a 2fm)
    y_D = fmdemod(y_C, fif, fs, freqdev);       % Obtener y_D
    
    %Filtro PasaBajo para guardar sólo la frecuencia base
    LPF = fdesign.lowpass('N,F3dB', 4, W, fs);
    LPF = design(LPF, 'butter');
    y_E = filter(LPF, y_D);     % Obtener y_E
end
