% conduct svm analysis with given cross-validation # (crossN) and
% repetition # (repeatN) 

function [auc, acc, spec, sens, xxs, yys] = SampleNsvm (x, y, crossN, repeatN) 

auc = []; acc = []; spec = []; sens = [];
xxs={}; yys={};
k=0; 


for r = 1:repeatN
    [aucs, xs, ys, tf] = svmAUC (x,y, crossN);
    
    auc = [auc; aucs];
    acc = [acc; cell2mat(tf.accuracy)];
    spec = [spec; cell2mat(tf.speci)];
    sens = [sens; cell2mat(tf.sensi)];
    
    for j=1:crossN
        k = k+1;
        xxs{k,1} = xs{j,1};
        yys{k,1} = ys{j,1};
    end
end
end


  