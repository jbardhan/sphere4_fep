boxlength = 26.8483333587646;
ksi = 2.837;
CONV = 332.112;
forwardNegQ = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1 ]';
forwardNegTotals = [4.32073 8.45692 12.0977 15.2618 18.0624 20.7164 22.8909 24.4884 25.9455 27.2266 28.2238 28.4315 28.7349 28.7847 28.468 27.8291 26.7593 25.4296 23.7667 21.785 ]';
reversedBackwardNegTotals = [ 4.00686 7.62153 10.94709 14.14502 16.92926 19.42851 21.40529 23.08015 24.62787 25.94742 26.63404 27.117822 27.431597 27.322455 26.901829 26.268346 25.255876 23.881826 22.342756 20.503916 ]';
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
off10 = struct('boxlength',boxlength,'q',q,'forwardNegQ',forwardNegQ,'forwardNegTotals',forwardNegTotals,'reversedBackwardNegTotals',reversedBackwardNegTotals, 'correctedFNtotals',correctedFNtotals,'correctedBNtotals',correctedBNtotals,'Qdata',Qdata,'Edata',Edata,'lsmatConstrained',lsmatConstrained,'lsmatUnconstrained',lsmatUnconstrained,'xConstrained',xConstrained,'xUnconstrained',xUnconstrained,'L_constrained',L_constrained,'L_unconstrained',L_unconstrained,'phiStatic_constrained',phiStatic_constrained,'phiStatic_unconstrained',phiStatic_unconstrained,'offset_unconstrained',offset_unconstrained);
