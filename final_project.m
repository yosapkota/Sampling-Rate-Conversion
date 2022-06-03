% [y,Fs] = audioread(filename) reads data from the file
% named filename, and returns sampled data and a sample rate for that
% data,Fs
[y,Fs] = audioread('speech_dft.wav');
%soundsc(y,Fs);
figure
 n_o = 1:110033;
subplot(4,1,1)
title('Original plot')
plot(n_o',y);
% hold on
output = SR_Conv_SingleStage(y);
soundsc(output,48000);
n = 1:239528;
subplot(4,1,2)
plot(n',output);
title('Resampling by a Non-integer Factor')
hold on
out2 = SR_Conv_MultiStage(y);
pause(3);
soundsc(out2,48000);
subplot(4,1,3)
plot(n',out2);
title('Multistage Upsampling')
hold on
out3 = SR_Conv_Polyphase(y);
pause(3);
soundsc(out3,48000);
subplot(4,1,4)
n1 = 1:239530;
plot(n1',out3);
title('Polyphase decomposition of Multistage Upsampling')

