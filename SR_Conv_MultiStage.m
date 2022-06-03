function [y] = SR_Conv_MultiStage(x)

% prime factors of L and M 
upSample = [2,2,2,2,2,2,5];
downSample = [3,7,7];

upSampledSignal = x;


for i = 1:length(upSample)
    upSampledSignal = upsample(upSampledSignal,upSample(i));
    wp = 1/upSample(i);
    d = designfilt('lowpassfir','PassbandFrequency',wp,'StopbandFrequency',1.2*wp,'PassbandRipple', 0.03, 'StopbandAttenuation',85)
    upSampledSignal = filter(d,upSampledSignal);
end

out = upSampledSignal;

for j = 1:length(downSample)
    wp = 1/downSample(j);
    d = designfilt('lowpassfir','PassbandFrequency',wp,'StopbandFrequency',1.2*wp,'PassbandRipple', 0.03, 'StopbandAttenuation',85);
    filtSignal = filter(d,out);
    out = downsample(filtSignal,downSample(j));
end

y = out;


