N = 10000;
x1 = randi([0, 1], 1, N);
% x1 = [0 0 0 1 1 0 1 1];
%x2 = [0 0 1 1 1 0];
y = 1:N/2;
k = 1;
for i=1:2:length(x1)
    if x1(i) == 0 && x1(i+1) == 0
        y(k) = exp(1j*pi/4);
    elseif x1(i) == 0 && x1(i+1) == 1
        y(k) = exp(1j*3*pi/4);
    elseif x1(i) == 1 && x1(i+1) == 0
        y(k) = exp(1j*5*pi/4);
    elseif x1(i) == 1 && x1(i+1) == 1
        y(k) = exp(1j*7*pi/4);
    end
    k = k+1;
end
k = 1;
awgn = randn(1, N/2) + 1j*randn(1, N/2);
snrdb = 0:24;
snr = 0:24;
err = 0:24;
err2 = 0:24;
err_rate = 0:24;
err_theo = 0:24;
yr = 1:N;
for l=1:length(snrdb)
    snr(l) = 10^(snrdb(l)/10);
    sigma = 1/sqrt(snr(l));
    signal_power = 1;
    noise_power = sigma^2;
    y1 = y + sigma*awgn;% + sigma*awgn;
    k = 1;
    for i=1:length(y)
        if real(y1(i))>0 && imag(y1(i))>0
            yr(k) = 0;
            yr(k+1) = 0;
        elseif real(y1(i))<0 && imag(y1(i))>0
            yr(k) = 0;
            yr(k+1) = 1;
        elseif real(y1(i))<0 && imag(y1(i))<0
            yr(k) = 1;
            yr(k+1) = 0;
        elseif real(y1(i))>0 && imag(y1(i))<0
            yr(k) = 1;
            yr(k+1) = 1;
        end
        k = k+ 2;
    end
    k=1;
    err(l)= sum(abs(yr - x1))/N;
end
semilogy(snrdb, err);