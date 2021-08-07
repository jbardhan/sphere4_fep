loadOrigin
loadOff05
newLoadOff10
newLoadOff15
newLoadOff20
newLoadOff25
newLoadOff30
newLoadOff35

figure; set(gca,'fontsize',16);
plot(origin.Qdata,origin.Edata,'rd','linewidth',2);
hold on;
plot(off05.Qdata,off05.Edata,'bo','linewidth',2);
plot(off10.Qdata,off10.Edata,'kx','linewidth',2);
plot(off15.Qdata,off15.Edata,'ms','linewidth',2);
plot(off20.Qdata,off20.Edata,'g>','linewidth',2);
plot(off25.Qdata,off25.Edata,'r*','linewidth',2);
plot(off30.Qdata,off30.Edata,'bv','linewidth',2);
plot(off35.Qdata,off35.Edata,'k^','linewidth',2);
qfine = (-1:0.001:1)';
vdm = [qfine.^2 qfine];
plot(qfine,vdm*origin.xConstrained,'r');
plot(qfine,vdm*off05.xConstrained,'b');
plot(qfine,vdm*off10.xConstrained,'k');
plot(qfine,vdm*off15.xConstrained,'m');
plot(qfine,vdm*off20.xConstrained,'g');
plot(qfine,vdm*off25.xConstrained,'r-.');
plot(qfine,vdm*off30.xConstrained,'b-.');
plot(qfine,vdm*off35.xConstrained,'k-.');


xlabel('q');
ylabel('\Delta G (kcal/mol)');
legend('(0, 0, 0)','(0.5, 0, 0)','(1.0, 0, 0)','(1.5, 0, 0)', ...
       '(2.0, 0, 0)', '(2.5, 0, 0)', '(3.0, 0, 0)', '(3.5, 0, 0)',...
       'location', 'southeast');
