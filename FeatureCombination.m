function [F] = FeatureCombination(cA,cD1,cD2,cD3,cD4,cD5)
%FEATURE Summary of this function goes here
F = zeros(24,1);
[F(1) F(2) F(3) F(4)] = FeatureExtraction(cA);
[F(5) F(6) F(7) F(8)] = FeatureExtraction(cD1);
[F(9) F(10) F(11) F(12)] = FeatureExtraction(cD2);
[F(13) F(14) F(15) F(16)] = FeatureExtraction(cD3);
[F(17) F(18) F(19) F(20)] = FeatureExtraction(cD4);
[F(21) F(22) F(23) F(24)] = FeatureExtraction(cD5);

end

