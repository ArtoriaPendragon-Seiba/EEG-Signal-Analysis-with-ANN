files = dir('.\F\*.txt');
l = length(files);
P = zeros(30,l*5);
T1 = zeros(2,l*5);%ZONF-S
T2 = zeros(2,l*5);%Z-S
T3 = zeros(3,l*5);%ZO-NF-S
T4 = zeros(3,l*5);%Z-F-S
T5 = zeros(5,l*5);%Z-O-N-F-S
for i=1:1:l
    file_name{i}=files(i).name;
    x = load(['.\F\' file_name{i}]);
    [cA cD1 cD2 cD3 cD4 cD5] = Decomposition(x);
    F = FeatureCombination(cA, cD1, cD2, cD3, cD4, cD5);
    P(:,i) = F;
    T1(1,i) = 1;
    T3(2,i) = 1;
    T4(2,i) = 1;
    T5(4,i) = 1;
    %T{1,i} = 0%'F';
    
end
files = dir('.\N\*.txt');
for i=1:1:l
    file_name{i}=files(i).name;
    x = load(['.\N\' file_name{i}]);
    [cA cD1 cD2 cD3, cD4 cD5] = Decomposition(x);
    F = FeatureCombination(cA, cD1, cD2, cD3, cD4, cD5);
    P(:,i+100) = F;
    T1(1,i+100) = 1;
    T3(2,i+100) = 1;
    T5(3,i+100) = 1;
  %  T{1,i+100} = 0%'N';
end
files = dir('.\O\*.txt');
for i=1:1:l
    file_name{i}=files(i).name;
    x = load(['.\O\' file_name{i}]);
    [cA cD1 cD2 cD3 cD4 cD5] = Decomposition(x);
    F = FeatureCombination(cA, cD1, cD2, cD3, cD4, cD5);
    P(:,i+200) = F;
    T1(1,i+200) = 1;
    T3(1,i+200) = 1;
    T5(2,i+200) = 1;
    %T{1,i+200} = 0% 'O';
end
files = dir('.\S\*.txt');
for i=1:1:l
    file_name{i}=files(i).name;
    x = load(['.\S\' file_name{i}]);
    [cA cD1 cD2 cD3 cD4 cD5] = Decomposition(x);
    F = FeatureCombination(cA, cD1, cD2, cD3, cD4, cD5);
    P(:,i+300) = F;
    T1(2,i+300) = 1;
    T2(2,i+300) = 1;
    T3(3,i+300) = 1;
    T4(3,i+300) = 1;
    T5(5,i+300) = 1;
    %T{1,i+300} = 1%'S';
end
files = dir('.\Z\*.txt');
for i=1:1:l
    file_name{i}=files(i).name;
    x = load(['.\Z\' file_name{i}]);
    [cA cD1 cD2 cD3 cD4 cD5] = Decomposition(x);
    F = FeatureCombination(cA, cD1, cD2, cD3, cD4, cD5);
    P(:,i+400) = F;
    T1(1,i+400) = 1;
    T2(1,i+400) = 1;
    T3(1,i+400) = 1;
    T4(1,i+400) = 1;
    T5(1,i+400) = 1;
   % T{1,i+400} = 0%'Z';
end
save('P','P');
save('Tzonf_s','T1');
save('Tz_s','T2');
save('Tzo_nf_s','T3');
save('Tzo_nf_s','T4');
save('Tz_o_n_f_s','T5');
fprintf('data processing completed');