 function [outSample] = SR_Conv_SingleStage(inSample)

%------------------------------------------------------
% takes a input signal inSample @ S/R 22050 Hz
% outputs a outSample single @ S/R 48000 Hz
% with Resampling factor (L/M) = 48000/22050 = 320/147
%------------------------------------------------------
L = 320; M = 147;
upSampledSignal = upsample(inSample,L);

% 5th-order LP elliptic IIR filter with 0.1 db passband ripple
% and 70 dB stopband attenuation

[b,a] = ellip(5,0.1,70,(1/320)); %wn in normalized frequency
% pi/320 divided by pi

fSignal = filter(b,a,upSampledSignal);

downSampledSignal = downsample(fSignal,M);

outSample = downSampledSignal