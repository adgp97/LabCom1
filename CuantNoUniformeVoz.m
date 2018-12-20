%% Cuantificacion Uniforme y No Uniforme. LAB5 EC2422 (Comunicaciones I) Universidad Simón Bolívar
%Armando Longart 10-10844
%Yurjelis Briceño 11-11371
%% 

%% Cuantificacion No Uniforme Señal de Voz
close all
N=[6 4];
[entrada, fs]=audioread('prueba.wav');
xmax=max(entrada);
for i=1:2
    n=N(i);
    sim('CuantNoUnifVoz.slx');
    
    if n==4
        figure
        plot(entrada, xqu_decom(1:length(entrada)));
        title('Curva característica del cuantificador con n = 4');
    end
    figure
    subplot(2,1,1)
    plot(t,entrada,'m')
    hold on
    plot(tout,xqu_decom,'g')
    plot(tout,uerror,'c')
    title(sprintf('Gráfica en el dominio temporal. n = %d',n))
    xlabel('Tiempo (s)')
    ylabel('Amplitud')
    legend('Entrada', 'Cuantizada', 'Error')
    
    fs=1/(tout(2)-tout(1));
    [ENTRADA, fe]=espectro(entrada, fs);
    [XQ, fxq]=espectro(xqu_decom, fs);
    [ERROR, ferr]=espectro(uerror, fs);
    
    subplot(2,1,2)
    plot(fe,ENTRADA,'m')
    hold on
    plot(fxq,XQ,'g')
    plot(ferr,ERROR,'b')
    title(sprintf('Gráfica en el dominio frecuencial. n = %d',n))
    xlabel('Frecuencia (Hz)')
    ylabel('Amplitud')
    legend('Entrada', 'Cuantizada', 'Error')
    
    figure
    hist(entrada)
    title(sprintf('Histograma de la entrada n = %d', n))
    
    figure
    hist(xqu_decom)
    title(sprintf('Histograma de la senal cuantizada n = %d', n))
    
    figure
    hist(uerror)
    title(sprintf('Histograma del error n = %d', n))
    
    Sq=mean(xqu_decom.^2);
    Nq=mean(uerror.^2);
    fprintf('Sq/Nq = %d para n = %d', Sq/Nq, n)
    
    sound(xqu_decom, fs)
end