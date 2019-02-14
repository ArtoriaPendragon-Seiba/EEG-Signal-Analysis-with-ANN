function [F] = FeatureCombination(cA,cD1,cD2,cD3,cD4,cD5)
%FEATURE Summary of this function goes here
F = zeros(24,1);
F(1:5) = FeatureExtraction(cA);
F(6:10) = FeatureExtraction(cD1);
F(11:15) = FeatureExtraction(cD2);
F(16:20) = FeatureExtraction(cD3);
F(21:25) = FeatureExtraction(cD4);
F(26:30) = FeatureExtraction(cD5);

end

