clc;
clear all;
close all;

N = 100000;
X = randi([0,1],[1,N]);

for i = 1:N
    if X(i) == 0
        bpsk(i) = -1;
    else
        bpsk(i) = 1;
    end
end

h = complex(randn(1,N),randn(1,N));
noise = complex(randn(1,N),randn(1,N));

SNR_dB = 0:4:24;
l = length(SNR_dB);

for i = 1:l
    SNR_lin(i) = 10^(SNR_dB(i)/10);
    sigma(i) = 1/sqrt(SNR_lin(i));
    y = h.*bpsk + sigma(i)*noise;
    Dec1 = y./h;
    for j = 1:N
        if Dec1(j) > 0
            X_rcvd(j) = 1;
        else
            X_rcvd(j) = 0;
        end
    end
    e(i) = sum(abs(X-X_rcvd))/N;
    P(i) = 0.5*(1-sqrt(SNR_lin(i)/(1+SNR_lin(i))));
end

semilogy(SNR_dB,e);
hold on
semilogy(SNR_dB,P,'o');
xlabel('SNR');ylabel('Error');
title('SNR vs ERROR');
legend('prac','theo');