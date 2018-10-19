% hilbert_demo.m -- Demonstration of Hilbert transform and an application
%                   to single sideband (SSB) amplitude modulation.
%
% ELEC 470, Rich Kozick, Spring 1998

Ts = 0.05;    % Sample spacing
Fs = 1/Ts;    % Sampling frequency
t= -5:Ts:5;   % Sample times

g = sinc(t);  % Time signal

N = 2^13;     % Number of samples in FFT
G = fftshift(fft(g, N));
f = (-(N/2):(N/2-1))/N*Fs;

figure(1)
subplot(211)
plot(t,g)
title('g(t) = sinc(t)');
subplot(212)
plot(f,abs(G))
title('Amplitude of FFT of g(t)')

gplus = hilbert(g);    % Hilbert transform is in imaginary part of gplus
ghat = imag(gplus);

Gplus = fftshift(fft(gplus, N));
Ghat = fftshift(fft(ghat, N));

figure(2)
subplot(211)
plot(t,ghat)
title('Hilbert transform of g(t) = sinc(t)');
subplot(212)
plot(f,abs(Ghat))
title('Amplitude of FFT')

% Plot the pre-envelope
figure(3)
plot(f,abs(Gplus))
title('Amplitude of FFT of gplus(t)')

% Modulate by cos with frequency 5 Hz

xdsb = g .* cos(2*pi*5*t);
Xdsb = fftshift(fft(xdsb,N));
xssb = g .* cos(2*pi*5*t) - ghat .* sin(2*pi*5*t);
Xssb = fftshift(fft(xssb,N));

figure(4)
subplot(211)
plot(t, xdsb)
title('Double sideband (DSB) time signal')
subplot(212)
plot(f, abs(Xdsb))
title('Amplitude of FFT of DSB signal')

figure(5)
subplot(211)
plot(t, xssb)
title('Single sideband (SSB) time signal')
subplot(212)
plot(f, abs(Xssb))
title('Amplitude of FFT of SSB signal')
