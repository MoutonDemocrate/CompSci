%%% QUESTION 1

Fs = 24000; % Sampling frequency
Ts = 1/Fs; % Sampling period
Rb = 3000; % Binary rate in bits per second
Tb = 1/Rb; % Binary period
n = 1 ; % Bits per symbols
Tsym = log2(2^n)*Tb; % Symbolic period
Nsym = Tsym/Ts; % Symbolic length
Rsym = Rb/log2(2^n);

entry_string = 'This is a test string that I can use for testing. It is quite long, so that my power spectral density is not fucked up';
bits = reshape(dec2bin(entry_string),1,[]) - '0';
N = length(bits);

symbols = symbols1(bits);

x = kron(symbols,[1 zeros(1,Nsym-1)]);

h = ones(1,Nsym);

signal = filter(h,1,x);

time = linspace(0,Ts,length(signal));

Y1 = pwelch(signal, [],[],[],Fs,'twosided');

frequency_scale1 = linspace(-Fs/2,Fs/2,length(Y1));

tiledlayout(2,2)

nexttile

macro_trace(time,signal,'Modulator 1 - Signal','Time','Signal');

%%% QUESTION 2

n = 2 ; % Bits per symbols
Tsym = log2(2^n)*Tb; % Symbolic period
Nsym = Tsym/Ts; % Symbolic length
Rsym = Rb/log2(2^n);

symbols = symbols2(bits);

x = kron(symbols,[1 zeros(1,Nsym-1)]);

h = ones(1,Nsym);

signal = filter(h,1,x);

time = linspace(0,Ts,length(signal));

Y2 = pwelch(signal, [],[],[],Fs,'twosided');

frequency_scale2 = linspace(-Fs/2,Fs/2,length(Y2));

nexttile

macro_trace(time,signal,'Modulator 2 - Signal','Time','Signal');

%%% QUESTION 3

n = 1 ; % Bits per symbols
Tsym = log2(2^n)*Tb; % Symbolic period
Nsym = Tsym/Ts; % Symbolic length
Rsym = Rb/log2(2^n);

symbols = symbols1(bits);

x = kron(symbols,[1 zeros(1,Nsym-1)]);

h = rcosdesign(0.5,3,Nsym);
size(h)

signal = filter(h,1,x);

time = linspace(0,Ts,length(signal));

Y3 = pwelch(signal, [],[],[],Fs,'twosided');

frequency_scale3 = linspace(-Fs/2,Fs/2,length(Y3));

nexttile

macro_trace(time,signal,'Modulator 3 - Signal','Time','Signal');

nexttile

grid
semilogy(frequency_scale1,fftshift(abs(Y1)))
hold
semilogy(frequency_scale2,fftshift(abs(Y2)))
semilogy(frequency_scale3,fftshift(abs(Y3)))
legend("Modulator 1","Modulator 2","Modulator 3");
xlabel("Frequency (Hz)");
ylabel("PSD");
title("Power Spectral Density of Modulators 1, 2 and 3");



function out = symbols1(in)
out = 2*in - 1;
end

function out = symbols2(in)
tmp = reshape(in, 2, []);
out = zeros(1,length(tmp));
map_mat = [-3 -1 ; 1 3];
for i = 1:length(tmp)
    i1 = tmp(1,i) + 1;
    i2 = tmp(2,i) + 1;
    out(i) = map_mat(i1,i2);
end
end

function macro_trace(x,y,tit,xlab,ylab)
plot(x, y);
grid
xlabel(xlab);
ylabel(ylab);
title(tit);
end