==================================================== 
Data files 
====================================================
(1) 'rr.mat'
It contains neural activity data around ME (megazine entry) and MX (Megazine exit) from all mice that underwent RR training. The middle latter '0' or 'z' refers to normalization by dividing F with F0 and z-score, respectively. The last latter 'e' or 'x' refers to ME and MX, respectively. The second last latter 'n' or 'r' means 'no reward trial' and 'rewarded trial', respectively. 

For example, 'rr0ne' means fluorecence data around ME in non rewarded trials which are normalized by being divided by F0. 

---
(2) Variables in 'ri.mat' were named in a similar way. 

---
(3) 'rrNPrnr.mat'
It contains neural activity data around NP (nose-poke) from all mice that underwent RR experiment. 'np' in the variable names refers to nose-poke. The middle latter '0' or 'z' refers to normalization by dividing F with F0 and z-score, respectively. The last latter 'n' or 'r' means 'no reward trial' and 'rewarded trial', respectively. 

For example, 'rr_0npr' refers to fluorecence data around NP in rewarded trials which are normalized by being divided by F0. 

---
(4) Variables in'riNPrnr.mat' were named in a similar way. 


==================================================== 
Codes 
====================================================
(1) 'svmME.m' uses neural activity immediately before and after ME to predict reward delivery and returns SVM AUC values (riRwME and rrRwME). It also predicts the experimental type (RR or RI) using reward delivery information and neural activity immediately before and after ME. 

It uses 'ri.mat' and 'rr.mat' 

(2) 'svmMX.m' is similar to 'svmME.m'

(3) 'svmNP.m' is similar to 'svmME.m' but it uses 'riNPrnr.mat' and 'rrNPrnr.mat' instead of 'ri.mat' and 'rr.mat'. 

(4) (1)~(3) uses 'SampleNsvm.m' and 'svmAUC.m'.

(5) 'toSaveFigs.' uses the outputs files of (1)~(3) to generate figures. It uses 'SampleNplot.m' and 'adjust_unique_points.m'. 

