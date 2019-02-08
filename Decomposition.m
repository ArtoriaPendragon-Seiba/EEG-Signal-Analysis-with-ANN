function [cA,cD1,cD2,cD3,cD4,cD5] = Decomposition5(EEGS)
%DECOMPOSITION Function is to decompose A EEG signal as 5 levels
%   EEGS is a set of EEG discrete signal
[c,l] = wavedec(EEGS,5,'db4');
cA = appcoef(c,l,'db4');
[cD1,cD2,cD3,cD4,cD5] = detcoef(c,l,[1 2 3 4 5]);
end

