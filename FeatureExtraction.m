function [m,SD,energy,v,range] = FeatureExtraction(S)
%FEATUREEXTRACTION is to extract feature from the given signal
m = mean(abs(S));
SD = std(S);
energy = sum(S.^2);
v = var(S);
range = max(S) - min(S);
end

