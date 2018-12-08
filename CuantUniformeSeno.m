%% Cuantificacion Uniforme y No Uniforme. LAB4 EC2422 (Comunicaciones I) Universidad Simón Bolívar
%Armando Longart 10-10844
%Yurjelis Briceño 11-11371
%% 

%% Cuantificacion Uniforme de Señal Seno
%close all
N = [4 3 2];
for i=1:3
    n=N(i);
    sim('CuantUnifSin.slx');
    figure
    subplot(2,1,1)
    plot(tout,entrada,'m') 
    hold on
    plot(tout,xq,'g') 
    plot(tout,error,'c')
    title(sprintf('Señales en el dominio temporal. n = %d',n))
    xlabel('Tiempo (s)'), 
    ylabel('Amplitud');
    legend('Entrada', 'Cuantizada', 'Error');
    
    
    fs = 1/(tout(2)-tout(1));
    [ENTRADA, fe] = espectro(entrada,fs);
    [XQ, fxq] = espectro(xq,fs);
    [ERROR, ferr] = espectro(error,fs);
    subplot(2,1,2)
    plot(fe,ENTRADA,'m')
    hold on
    plot(fxq,XQ, 'g')
    plot(ferr,ERROR, 'c')
    title(sprintf('Señales en el dominio frecuencial. n = %d',n))
    xlabel('Frecuencia (Hz)')
    ylabel('Magnitud')
    legend('Entrada','Cuantizada','Error')
    
    figure,
    hist(entrada);
    %hist(entrada/length(entrada),100);
    title(sprintf('Histograma de la entrada. n = %d', n));
    figure,
    hist(xq);
    %hist(xq/length(xq),100);
    title(sprintf('Histograma de la señal cuantizada. n = %d', n));
    figure,
    hist(error);
    %hist(error/length(error),100);
    title(sprintf('Histograma del error. n = %d', n));
    Sq=mean(xq.^2);
    Nq=mean(error.^2);
    fprintf('Sq/Nq = %d para n = %d', Sq/Nq, n);
end