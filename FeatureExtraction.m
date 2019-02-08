function [m,SD,energy,v] = FeatureExtraction(S)
%FEATUREEXTRACTION is to extract feature from the given signal
m = mean(abs(S));
SD = std(S);
energy = sum(S.^2);
v = var(S);
end

