clear all;  

c1 = [121 180; 136 180; 151 180; 166 180]; % window before ME, 1s = 30units
c2 = [181 240; 181 225; 181 210; 181 195];  % window after ME

load('ri.mat'); load('rr.mat')
crossN = 4; repeatN = 1; sampleN = 400;


%% rr reward or not
i=0; rrRw={};
for ci=1:size(c1,1)
    ci
%     for cj=1:size(c2,1)
        t = [c1(ci,1) c1(ci,2) c2(ci,1) c2(ci,2)];
        i = i+1;
        aucs=[];accs=[];specs=[]; senss=[]; xxs={}; yys={}; k=0; 
        
        for s=1:sampleN
            n = randperm(296,205);
            n = rr0ne(n,:);            
            [n] = svmdata(n, t(1), t(2), t(3), t(4));
            r = svmdata (rr0re, t(1), t(2), t(3), t(4));
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
%     end
end
rrRwME = rrRw;
save rrRwME rrRwME


%% ri rewarded or not
i=0; rrRw={};
for ci=1:size(c1,1)
    ci
%     for cj=1:size(c2,1)
        t = [c1(ci,1) c1(ci,2) c2(ci,1) c2(ci,2)];
        i = i+1;
        aucs=[];accs=[];specs=[]; senss=[]; xxs={}; yys={}; k=0;
        
        for s=1:sampleN
            n = randperm(267,36);
            n = ri0ne(n,:);
            n = svmdata (n, t(1), t(2), t(3), t(4));
            r = svmdata (ri0re, t(1), t(2), t(3), t(4));
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
%     end
end
riRwME = rrRw;
save riRwME riRwME


%% ri or rr; used reward info as additional input 
i=0; rrRw={};
for ci=1:size(c1,1)
    ci
%     for cj=1:size(c2,1)
        t = [c1(ci,1) c1(ci,2) c2(ci,1) c2(ci,2)];
        i = i+1;
        aucs=[];accs=[];specs=[]; senss=[]; xxs={}; yys={}; k=0;
        
        for s=1:sampleN
            % rr   205 in reward 296 in noreward
            % ri   36 in reward 267 in noreward
            % rr = 296+205 = 501       
            % ri = 267+36 = 303            
            rin = svmdata (ri0ne, t(1), t(2), t(3), t(4));            
            rir = svmdata (ri0re, t(1), t(2), t(3), t(4));
            
            % rr
            rrr = randperm(205,36);
            rrr = rr0re(rrr,:);
            rrr = svmdata (rrr, t(1), t(2), t(3), t(4));
            
            rrn = randperm(296,267);
            rrn = rr0ne(rrn,:);
            rrn = svmdata (rrn, t(1), t(2), t(3), t(4));
            
            % svm
            % indata = [frn; frr; rrn; rrr; rin; rir];
            indata = [rrn; rrr; rin; rir];
            r = [zeros(267,1); ones(36,1); zeros(267,1); ones(36,1)];
            indata = [indata r];
            x = ones(303,1);
            x2 = zeros(303,1);
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
%     end
end
rirrME_matchTn = rrRw;
save rirrME_matchTn rirrME_matchTn

%% ri or rr; used reward info as additional input 
i=0; rrRw={};
for ci=1:size(c1,1)
    ci
%     for cj=1:size(c2,1)
        t = [c1(ci,1) c1(ci,2) c2(ci,1) c2(ci,2)];
        i = i+1;
        aucs=[];accs=[];specs=[]; senss=[]; xxs={}; yys={}; k=0;
        
        for s=1:sampleN
            % rr   205 in reward 296 in noreward
            % ri   36 in reward 267 in noreward
            % rr = 296+205 = 501       
            % ri = 267+36 = 303            
            rrn = randperm(296,36);
            rrn = rr0ne(rrn,:);
            rrn = svmdata (rrn, t(1), t(2), t(3), t(4));
            
            rrr = randperm(205,36);
            rrr = rr0re(rrr,:);
            rrr = svmdata (rrr, t(1), t(2), t(3), t(4));
            
            % ri   58 in reward 549 in noreward
            % 290-58 = 232
            rir = svmdata (ri0re, t(1), t(2), t(3), t(4));
            
            rin = randperm(267,36);
            rin = ri0ne(rin,:);
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
%     end
end
rirrME_matchRwTn = rrRw;
save rirrME_matchRwTn rirrME_matchRwTn

