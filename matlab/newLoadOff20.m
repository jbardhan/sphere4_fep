boxlength = 26.8483333587646;
ksi = 2.837;
CONV = 332.112;
forwardNegQ = [0.02 0.04 0.06 0.08 0.1 0.12 0.14 0.16 0.18 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52 0.54 0.56 0.58 0.6 0.62 0.64 0.66 0.68 0.7 0.72 0.74 0.76 0.78 0.8 0.82 0.84 0.86 0.88 0.9 0.92 0.94 0.96 0.98 1 ]';
forwardNegTotals = [2.16833 4.27523 6.30486 8.28561 10.1174 11.8951 13.6364 15.3468 16.8987 18.3862 19.7766 21.1312 22.4111 23.586 24.681 25.7295 26.6903 27.6062 28.4303 29.1674 29.852 30.4757 30.987 31.5259 31.9877 32.3641 32.6698 32.8931 33.0869 33.2574 33.2939 33.2969 33.239 33.1275 32.9541 32.7202 32.3984 32.0271 31.5821 31.0838 30.529 29.9097 29.2368 28.4971 27.7096 26.8518 25.9632 24.9824 23.9671 22.8986 ]';
reversedBackwardNegTotals = [ 2.1787 4.30763 6.33049 8.28257 10.16693 11.90262 13.59804 15.22376 16.78679 18.29671 19.75241 21.05769 22.30638 23.47517 24.60066 25.61646 26.56363 27.496394 28.366812 29.170377 29.879254 30.515391 31.093193 31.583999 32.051965 32.435935 32.74981 32.982632 33.155815 33.2539326 33.3056834 33.30112822 33.26728582 33.12813782 32.94145282 32.70340482 32.40992382 32.05594682 31.61470682 31.11954882 30.56967882 29.97572282 29.31884782 28.58566382 27.77707982 26.96005082 26.04714582 25.08014282 24.02682282 22.94170282 ]';
q = [-1; -1+((1)-(-1))*forwardNegQ];
Izero = find(abs(q)< 1e-3);
correctedFNtotals = [0; forwardNegTotals] - 0.5*ksi*CONV*(q.^2 - (-1).^2) / boxlength;
correctedFNtotals = correctedFNtotals - correctedFNtotals(Izero);
correctedBNtotals = [0;reversedBackwardNegTotals] -reversedBackwardNegTotals(Izero) - 0.5*ksi*CONV*(q.^2-(-1).^2) / boxlength;
correctedBNtotals = correctedBNtotals - correctedBNtotals(Izero);
Qdata = [q; q]; 
Edata = [correctedFNtotals; correctedBNtotals;];
lsmatConstrained = [Qdata.^2 Qdata];
lsmatUnconstrained = [Qdata.^2 Qdata ones(length(Qdata),1)];
xConstrained = lsmatConstrained \ Edata;
xUnconstrained = lsmatUnconstrained \ Edata;
L_constrained = xConstrained(1);
L_unconstrained = xUnconstrained(1);
phiStatic_constrained = xConstrained(2);
phiStatic_unconstrained = xUnconstrained(2);
offset_unconstrained = xUnconstrained(3);
off20 = struct('boxlength',boxlength,'q',q,'forwardNegQ',forwardNegQ,'forwardNegTotals',forwardNegTotals,'reversedBackwardNegTotals',reversedBackwardNegTotals, 'correctedFNtotals',correctedFNtotals,'correctedBNtotals',correctedBNtotals,'Qdata',Qdata,'Edata',Edata,'lsmatConstrained',lsmatConstrained,'lsmatUnconstrained',lsmatUnconstrained,'xConstrained',xConstrained,'xUnconstrained',xUnconstrained,'L_constrained',L_constrained,'L_unconstrained',L_unconstrained,'phiStatic_constrained',phiStatic_constrained,'phiStatic_unconstrained',phiStatic_unconstrained,'offset_unconstrained',offset_unconstrained);
