boxlength = 26.8483333587646;
ksi = 2.837;
CONV = 332.112;
forwardNegQ = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1 ]';
forwardNegTotals = [11.5438 22.5785 32.6434 40.9817 48.8842 55.8241 60.8742 64.9133 67.6711 69.2637 69.9596 70.0795 69.2013 67.7316 65.7678 62.8932 59.1374 54.8298 49.6036 43.3088 ]';
reversedBackwardNegTotals = [ 10.9364 21.4583 30.83032 39.24437 46.65819 53.35301 58.24748 61.42667 63.4013 65.33929 65.556208 65.034279 63.580139 61.997659 59.771529 56.725139 52.908439 48.586949 43.289189 37.376159 ]';
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
off35 = struct('boxlength',boxlength,'q',q,'forwardNegQ',forwardNegQ,'forwardNegTotals',forwardNegTotals,'reversedBackwardNegTotals',reversedBackwardNegTotals, 'correctedFNtotals',correctedFNtotals,'correctedBNtotals',correctedBNtotals,'Qdata',Qdata,'Edata',Edata,'lsmatConstrained',lsmatConstrained,'lsmatUnconstrained',lsmatUnconstrained,'xConstrained',xConstrained,'xUnconstrained',xUnconstrained,'L_constrained',L_constrained,'L_unconstrained',L_unconstrained,'phiStatic_constrained',phiStatic_constrained,'phiStatic_unconstrained',phiStatic_unconstrained,'offset_unconstrained',offset_unconstrained);