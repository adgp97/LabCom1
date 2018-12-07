%% Cuantificacion Uniforme y No Uniforme. LAB5 EC2422 (Comunicaciones I) Universidad Simón Bolívar
%Armando Longart 10-10844
%Yurjelis Briceño 11-11371
%% 

%% Cuantificacion No Uniforme Señal de Voz
close all
xmax=max(entrada);
for i=1:2
    n=N(i);
    sim('CuantNoUnifVoz.slx');
    
    if n==4
        figure,
        plot(entrada, xqu_decom(1:length(entrada)));
        title('Curva caracteristica del cuantificador con n = 4');
    end
    figure,
    subplot(2,1,1);
    plot(t,entrada), hold on;
    plot(tout,xqu_decom,'r'), hold on;
    plot(tout,uerror,'g');
    title(sprintf('Graficas en tiempo n = %d',n)), xlabel('t'), ylabel('y(t)');
    legend('Entrada', 'Cuantizada', 'Error');
    fs=1/(tout(2)-tout(1));
    [ENTRADA, fe]=espectro(entrada, fs);
    [XQ, fxq]=espectro(xqu_decom, fs);
    [ERROR, ferr]=espectro(uerror, fs);
    subplot(2,1,2);
    plot(fe,ENTRADA), hold on;
    plot(fxq,XQ,'r'), hold on;
    plot(ferr,ERROR,'g');
    title(sprintf('Graficas en frecuencia n = %d',n)), xlabel('f'), ylabel('Y(f)');
    legend('Entrada', 'Cuantizada', 'Error');
    figure,
    hist(entrada);
    title(sprintf('Histograma de la entrada n = %d', n));
    figure,
    hist(xqu_decom);
    title(sprintf('Histograma de la senal cuantizada n = %d', n));
    figure,
    hist(uerror);
    title(sprintf('Histograma del error n = %d', n));
    Sq=mean(xqu_decom.^2);
    Nq=mean(uerror.^2);
    fprintf('Sq/Nq = %d para n = %d', Sq/Nq, n);
    sound(xqu_decom, fs);
end