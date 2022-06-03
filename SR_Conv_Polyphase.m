function [y]= SR_Conv_Polyphase(x)

% prime factors of L for multistage
% polyphase decomposition of the interpolation
upSample = [2,2,2,2,2,2,5];
M = 147;

inSample = x;


%loop through all factors
for i = 1:length(upSample)
    currSum = [];
% polyphase decomposition of each factor    
    for j = 1:upSample(i)
        wp = 1/upSample(i); % passband frequency
        d = designfilt('lowpassfir','PassbandFrequency',wp,'StopbandFrequency',1.2*wp,'PassbandRipple', 0.03, 'StopbandAttenuation',85);
        
        % get e0 and e1 for 2
        % e0,e1,e2,e3,e4 for 5
        
        coeff = d.Coefficients; %store the numerical coefficients from the digitalfilt object
        
        % coeff array padded with zeros to make it multiple of upSample(i)
        if upSample(i) == 2
            zPadding = coeff;
        elseif upSample(i) == 5
            zPadding = [coeff 0];
        end
        % reshape the array to have upSample(i) number of rows and same
        % number of cols
        rows = upSample(i);
        cols = length(zPadding)/rows;
        zeroPadCoeff = reshape(zPadding, rows,cols);
        %From block diagram, decomposition operation
        
        % filtering the input signal with the jth row, j=1 for the first
        % row j = 2 second row...
        filtSignal = filter(zeroPadCoeff(j,:),1,inSample);
        %upsampling the filtered signal and storing it in an array 
        %padding zero to add delays to sum correctly
        upSampledSignal = [zeros(j-1,1);upsample(filtSignal,upSample(i))];
        
        % zero padding at the end to match the array size 
        currSum = [currSum; zeros(1,1)] + upSampledSignal;
        size(currSum);
    end  
    inSample = currSum;
    out = currSum;
end

y = downsample(out,M);


