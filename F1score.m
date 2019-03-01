function [macroF1,microF1] = F1score(predV,Yval)
%SM Summary of this function goes here
%   Detailed explanation goes here

a = max(max(Yval));
if a == 2
    tp =  sum(predV(find(predV==2)) == Yval(find(predV==2)));
    fp =  sum((predV(find(predV==2)) ~= Yval(find(predV==2))));
    fn =  sum((predV(find(predV~=2)) ~= Yval(find(predV~=2))));
    p = tp/(tp+fp)
    r = tp/(tp+fn)
    macroF1 = 2*p*r/(p+r);
    microF1 = macroF1;
else
F1 = zeros(a,1);
TP = zeros(a,1);
FP = zeros(a,1);
FN = zeros(a,1);
for i = 1:a
    TP(i) =  sum(predV(find(predV==i)) == Yval(find(predV==i)));
    FP(i) =  sum((predV(find(predV==i)) ~= Yval(find(predV==i))));
    FN(i) =  sum((predV(find(predV~=i)) ~= Yval(find(predV~=i))))
    p = TP(i) / (TP(i) + FP(i));
    r = TP(i) / (TP(i) + FN(i));
    F1(i) = 2 * p * r/(p+r);
end
macroF1 = mean(F1);
    P = sum(TP) / (sum(TP) + sum(FP));
    R = sum(TP) / (sum(TP) + sum(FN));
microF1 = 2 * P * R/(P+R);
end
end

