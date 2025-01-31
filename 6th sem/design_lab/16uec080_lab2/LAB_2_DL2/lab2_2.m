clc;
clear all;
close all;

N = 100000;
X = randi([0,1],[1,N]);
% N = 8;
% X = [0 0 0 1 1 0 1 1];

n = 1;
for i = 1:2:N
    if (X(i) == 0) && (X(i+1) == 0)
        bpsk(n) = (1+1j)/sqrt(2);
    elseif (X(i) == 0) && (X(i+1) == 1)
        bpsk(n) = (-1+1j)/sqrt(2);
    elseif (X(i) == 1) && (X(i+1) == 0)
        bpsk(n) = (-1-1j)/sqrt(2);
    elseif (X(i) == 1) && (X(i+1) == 1)
        bpsk(n) = (1-1j)/sqrt(2);
    end
    n = n+1;
end

h = complex(randn(1,N/2),randn(1,N/2));
noise = complex(randn(1,N/2),randn(1,N/2));

SNR_dB = 0:4:24;
l = length(SNR_dB);

for i = 1:l
    SNR_lin(i) = 10^(SNR_dB(i)/10);
    sigma(i) = 1/sqrt(SNR_lin(i));
    y = h.*bpsk + sigma(i)*noise;
    Dec1 = y./h;
    n = 1;
    for j = 1:N/2
        if (real(Dec1(j))>0) && (imag(Dec1(j))>0)
            X_rcvd(n) = 0;
            X_rcvd(n+1) = 0;
        elseif (real(Dec1(j))<0) && (imag(Dec1(j))>0)
            X_rcvd(n) = 0;
            X_rcvd(n+1) = 1;
        elseif (real(Dec1(j))<0) && (imag(Dec1(j))<0)
            X_rcvd(n) = 1;
            X_rcvd(n+1) = 0;
        elseif (real(Dec1(j))>0) && (imag(Dec1(j))<0)
            X_rcvd(n) = 1;
            X_rcvd(n+1) = 1;
        end
        n = n+2;
    end
    e(i) = sum(abs(X-X_rcvd))/N;
end

semilogy(SNR_dB,e);
xlabel('SNR');ylabel('Error');
title('SNR vs ERROR');