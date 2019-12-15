function [ Ftransform, NFFT ] = Take1DfourierTransform( func )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

L = length(func);
NFFT = 2^nextpow2(L);
Ftransform = fft(func, NFFT);


% Ftransform = abs(Ftransform);
% F = [0: (NFFT -1)]/NFFT;
% 
% plot(F, Ftransform);

end

