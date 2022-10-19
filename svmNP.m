clear all;  
c1 = [121 180; 136 180; 151 180; 166 180]; % window before NP, 1s = 30units
c2 = [181 240; 181 225; 181 210; 181 195]; % window after NP
c = [c1 c2]; 

load('riNPrnr.mat'); load('rrNPrnr.mat')
crossN = 4; repeatN = 1; sampleN = 400; 


%% rr reward or not

rrRw={};
for i=1:size(c,1)
    t = c(i,:); 
    i
    aucs=[];accs=[];specs=[]; senss=[]; xxs={}; yys={}; k=0; 
    for s=1:sampleN
        n = randperm(841,203);
        n = rr_0npn(n,:);
        [n] = svmdata(n, t(1), t(2), t(3), t(4));
        r = svmdata (rr_0npr, t(1), t(2), t(3), t(4));
        x = [n; r];
        y = [zeros(length(r),1); ones(length(n),1)];
        [auc, acc, spec, sens, xx, yy] = SampleNsvm (x, y, crossN, repeatN);
        
        aucs=[aucs; auc];
        accs=[accs; acc];
        specs=[specs; spec];
        senss=[senss; sens];
        
        for j=1:size(xx,1)
            k=k+1;
            xxs{k,1} = xx{j,1};
            yys{k,1} = yy{j,1};
        end
    end    
    
    rrRw{i,1}.aucs = aucs; 
    rrRw{i,1}.accs = accs; 
    rrRw{i,1}.specs = specs; 
    rrRw{i,1}.senss = senss; 
    rrRw{i,1}.xxs = xxs; 
    rrRw{i,1}.yys = yys;  
    rrRw{i,1}.input = t; 
end
rrRwNP = rrRw;
save rrRwNP rrRwNP


%% ri rewarded or not
aucs=[];accs=[];specs=[]; senss=[]; xxs={}; yys={};
rrRw={};
for i=1:size(c,1)
    i
    t = c(i,:);
    aucs=[];accs=[];specs=[]; senss=[]; xxs={}; yys={}; k=0; 
    for s=1:sampleN
        n = randperm(121,36);
        n = ri_0npn(n,:);
        n = svmdata (n, t(1), t(2), t(3), t(4));
        r = svmdata (ri_0npr, t(1), t(2), t(3), t(4));
        x = [n; r];
        y = [zeros(length(n),1); ones(length(r),1)];
        [auc, acc, spec, sens, xx, yy] = SampleNsvm (x, y, crossN, repeatN);
        
        aucs=[aucs; auc];
        accs=[accs; acc];
        specs=[specs; spec];
        senss=[senss; sens];
        
        for j=1:size(xx,1)
            k=k+1;
            xxs{k,1} = xx{j,1};
            yys{k,1} = yy{j,1};
        end
    end
    
    rrRw{i,1}.aucs = aucs;
    rrRw{i,1}.accs = accs;
    rrRw{i,1}.specs = specs;
    rrRw{i,1}.senss = senss;
    rrRw{i,1}.xxs = xxs;
    rrRw{i,1}.yys = yys;
    rrRw{i,1}.input = t;
end
riRwNP = rrRw;
save riRwNP riRwNP


%% ri or rr; used reward info as additional input
rrRw={};
for i=1:size(c,1)
    i
    t = c(i,:);
    aucs=[];accs=[];specs=[]; senss=[]; xxs={}; yys={}; k=0; 
    for s=1:sampleN
        % rr = 841nr+203r = 1046
        % ri = 121nr+36r = 157
        rin = svmdata (ri_0npn, t(1), t(2), t(3), t(4));
        rir = svmdata (ri_0npr, t(1), t(2), t(3), t(4));
        
        rrr = randperm(203,36);
        rrr = rr_0npr(rrr,:);
        rrr = svmdata (rrr, t(1), t(2), t(3), t(4));
        
        rrn = randperm(841,121);
        rrn = rr_0npn(rrn,:);
        rrn = svmdata (rrn, t(1), t(2), t(3), t(4));
        
        % svm
        % indata = [frn; frr; rrn; rrr; rin; rir];
        indata = [rrn; rrr; rin; rir];
        r = [zeros(121,1); ones(36,1); zeros(121,1); ones(36,1)];
        indata = [indata r];
        x = ones(157,1);
        x2 = zeros(157,1);
        outdata = [x; x2];
        [auc, acc, spec, sens, xx, yy] = SampleNsvm (indata, outdata, crossN, repeatN);
        
        aucs=[aucs; auc];
        accs=[accs; acc];
        specs=[specs; spec];
        senss=[senss; sens];
        
        for j=1:size(xx,1)
            k=k+1;
            xxs{k,1} = xx{j,1};
            yys{k,1} = yy{j,1};
        end
    end
    
    rrRw{i,1}.aucs = aucs;
    rrRw{i,1}.accs = accs;
    rrRw{i,1}.specs = specs;
    rrRw{i,1}.senss = senss;
    rrRw{i,1}.xxs = xxs;
    rrRw{i,1}.yys = yys;
    rrRw{i,1}.input = t;
end
% rirrNP = rrRw;
rirrNP_matchTn = rrRw;
save rirrNP_matchTn rirrNP_matchTn

%% ri or rr; used reward info as additional input
rrRw={};
for i=1:size(c,1)
    i
    t = c(i,:);
    aucs=[];accs=[];specs=[]; senss=[]; xxs={}; yys={}; k=0; 
    for s=1:sampleN
        % rr = 841nr+203r = 1046
        % ri = 121nr+36r = 157
        rrn = randperm(841,36);
        rrn = rr_0npn(rrn,:);
        rrn = svmdata (rrn, t(1), t(2), t(3), t(4));
        
        rrr = randperm(203,36);
        rrr = rr_0npr(rrr,:);
        rrr = svmdata (rrr, t(1), t(2), t(3), t(4));
        
        % ri   64 in reward 1045 in noreward
        rir = svmdata (ri_0npr, t(1), t(2), t(3), t(4));
        
        rin = randperm(121,36);
        rin = ri_0npn(rin,:);
        rin = svmdata (rin, t(1), t(2), t(3), t(4));
        
        % svm
        % indata = [frn; frr; rrn; rrr; rin; rir];
        indata = [rrn; rrr; rin; rir];
        r = [zeros(36,1); ones(36,1); zeros(36,1); ones(36,1)];
        indata = [indata r];
        
        x = ones(72,1);
        x2 = zeros(72,1);
        outdata = [x; x2];
        [auc, acc, spec, sens, xx, yy] = SampleNsvm (indata, outdata, crossN, repeatN);
        
        aucs=[aucs; auc];
        accs=[accs; acc];
        specs=[specs; spec];
        senss=[senss; sens];
        
        for j=1:size(xx,1)
            k=k+1;
            xxs{k,1} = xx{j,1};
            yys{k,1} = yy{j,1};
        end
    end
    
    rrRw{i,1}.aucs = aucs;
    rrRw{i,1}.accs = accs;
    rrRw{i,1}.specs = specs;
    rrRw{i,1}.senss = senss;
    rrRw{i,1}.xxs = xxs;
    rrRw{i,1}.yys = yys;
    rrRw{i,1}.input = t;
end
% rirrNP = rrRw;
rirrNP_matchRwTn = rrRw;
save rirrNP_matchRwTn rirrNP_matchRwTn

