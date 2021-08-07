%%% loading
cd ../sph4/
origin
cd ../offsetsFine_sph4

xOrigin = localfit(Qdata, Edata);
off00 = struct('Qdata',Qdata,'Edata',Edata);

loadOff05
x05 = localfit(Qdata, Edata);
newLoadOff10
x10 = localfit(Qdata, Edata);
newLoadOff15
x15 = localfit(Qdata, Edata);
newLoadOff20
x20 = localfit(Qdata, Edata);
newLoadOff25
x25 = localfit(Qdata, Edata);
fixLoad30 %%%%%%% 
x30 = localfit(Qdata, Edata);
newLoadOff35
x35 = localfit(Qdata, Edata);

qfine = -1:0.01:1; qfine = qfine';
qfineVDM = [qfine.^2 qfine];

phiStaticProfile = [xOrigin(2) x05(2) x10(2) x15(2) x20(2) x25(2) ...
		    x30(2) x35(2)];
meanPhiStatic = mean(phiStaticProfile);

g00 = globalfit(off00.Qdata, off00.Edata, meanPhiStatic);
g05 = globalfit(off05.Qdata, off05.Edata, meanPhiStatic);
g10 = globalfit(off10.Qdata, off10.Edata, meanPhiStatic);
g15 = globalfit(off15.Qdata, off15.Edata, meanPhiStatic);
g20 = globalfit(off20.Qdata, off20.Edata, meanPhiStatic);
g25 = globalfit(off25.Qdata, off25.Edata, meanPhiStatic);
g30 = globalfit(off30.Qdata, off30.Edata, meanPhiStatic);
g35 = globalfit(off35.Qdata, off35.Edata, meanPhiStatic);


%%% Plotting
figure(1);
H_origin=plot(off00.Qdata,off00.Edata,'ko');
set(gca,'fontsize',16);
xlabel('q');
ylabel('\Delta G^{charging} (kcal/mol)');
hold on;
lw = 1.4;
H_05 = plot(off05.Qdata,off05.Edata,'rx','markersize',4);
H_10 = plot(off10.Qdata,off10.Edata,'m+');
H_15 = plot(off15.Qdata,off15.Edata,'b*');
H_20 = plot(off20.Qdata,off20.Edata,'g^');
H_25 = plot(off25.Qdata,off25.Edata,'k>');
H_30 = plot(off30.Qdata,off30.Edata,'b<');
H_35 = plot(off35.Qdata,off35.Edata,'ms','linewidth',1.5);
H_origin_fit = plot(qfine, qfineVDM*[xOrigin(1); meanPhiStatic],'k','linewidth',lw);
H_05_fit = plot(qfine, qfineVDM*[x05(1); meanPhiStatic],'r','linewidth',lw);
H_10_fit = plot(qfine, qfineVDM*[x10(1); meanPhiStatic],'m','linewidth',lw);
H_15_fit = plot(qfine, qfineVDM*[x15(1); meanPhiStatic],'b','linewidth',lw);
H_20_fit = plot(qfine, qfineVDM*[x20(1); meanPhiStatic],'g--','linewidth',lw);
H_25_fit = plot(qfine, qfineVDM*[x25(1); meanPhiStatic],'k--','linewidth',lw);
H_30_fit = plot(qfine, qfineVDM*[x30(1); meanPhiStatic],'b--','linewidth',lw);
H_35_fit = plot(qfine, qfineVDM*[x35(1); meanPhiStatic],'m--','linewidth',lw);
axis([-1 1 -88 4])
legend('0.0','0.5','1.0','1.5','2.0','2.5','3.0','3.5','location','southeast');
print -dpng sph4-charges-local-fit.png
print -depsc2 sph4-charges-local-fit.eps
legend off;
axis([-.15 0.15 -2 1]);
plot(qfine,meanPhiStatic*qfine,'k','linewidth',2);
print -dpng sph4-charges-static-potential.png
print -depsc2 sph4-charges-static-potential.eps

L(1,:) = posnegfit(off00.Qdata,off00.Edata,meanPhiStatic);
L(2,:) = posnegfit(off05.Qdata,off05.Edata,meanPhiStatic);
L(3,:) = posnegfit(off10.Qdata,off10.Edata,meanPhiStatic);
L(4,:) = posnegfit(off15.Qdata,off15.Edata,meanPhiStatic);
L(5,:) = posnegfit(off20.Qdata,off20.Edata,meanPhiStatic);
L(6,:) = posnegfit(off25.Qdata,off25.Edata,meanPhiStatic);
L(7,:) = posnegfit(off30.Qdata,off30.Edata,meanPhiStatic);
L(8,:) = posnegfit(off35.Qdata,off35.Edata,meanPhiStatic);
xVector = 0:0.5:3.5;
figure(2);
set(gca,'fontsize',16);

% the curvature is d^2/dx^2 E.  this is TWICE the
% reaction-potential operator.
plot(xVector,L(:,1),'bo','markersize',8,'linewidth',1.5);
hold on;
xlabel('Position (Angstrom)');
ylabel('Curvature (kcal/mol/e^2)');
plot(xVector,L(:,2),'rs','markersize',8,'linewidth',1.5);
legend('Fit for q >= 0', 'Fit for q <= 0','location','northeast');

print -dpng sph4-asymmetry-curvatures.png
print -depsc2 sph4-asymmetry-curvatures.eps


Ipos = find(qfine>=0); Ipos = Ipos(1:10:end);
Ineg = find(qfine<=0); Ineg = Ineg(1:10:end);
ms = 10;
figure(3);
set(gca,'fontsize',16);
[junk,Iall] = sort(off20.Qdata);
plot(off20.Qdata(Iall),off20.Edata(Iall),'k-.','linewidth',1.5);
hold on;

[junk,Iall] = sort(off25.Qdata);
plot(off25.Qdata(Iall),off25.Edata(Iall),'m-.','linewidth',1.5);
hold on;

[junk,Iall] = sort(off30.Qdata);
plot(off30.Qdata(Iall),off30.Edata(Iall),'r--','linewidth',1.5);
hold on;

[junk,Iall] = sort(off35.Qdata);
plot(off35.Qdata(Iall),off35.Edata(Iall),'b','linewidth',1.5);


plot(qfine(Ipos),qfine(Ipos).^2*L(5,1)+meanPhiStatic*qfine(Ipos),'k<','markersize',ms,'linewidth',lw);
plot(qfine(Ineg),qfine(Ineg).^2*L(5,2)+meanPhiStatic*qfine(Ineg),'k>','markersize',ms,'linewidth',lw);
plot(qfine(Ipos),qfine(Ipos).^2*L(6,1)+meanPhiStatic*qfine(Ipos),'mx','markersize',ms,'linewidth',lw);
plot(qfine(Ineg),qfine(Ineg).^2*L(6,2)+meanPhiStatic*qfine(Ineg),'md','markersize',ms,'linewidth',lw);
plot(qfine(Ipos),qfine(Ipos).^2*L(7,1)+meanPhiStatic*qfine(Ipos),'r^','markersize',ms,'linewidth',lw);
plot(qfine(Ineg),qfine(Ineg).^2*L(7,2)+meanPhiStatic*qfine(Ineg),'rv','markersize',ms,'linewidth',lw);
plot(qfine(Ipos),qfine(Ipos).^2*L(8,1)+meanPhiStatic*qfine(Ipos),'bs','markersize',ms,'linewidth',lw);
plot(qfine(Ineg),qfine(Ineg).^2*L(8,2)+meanPhiStatic*qfine(Ineg),'bo','markersize',ms,'linewidth',lw);

legend('2.0', '2.5', '3.0', '3.5','location','southeast');
xlabel('q');
ylabel('\Delta G^{charging} (kcal/mol)');

print -dpng sph4-asymmetric-fits.png
print -depsc2 sph4-asymmetric-fits.eps

return


%figure(2);
%H_phiStatic = plot(0:0.5:3.5,phiStaticProfile,'bs');
%set(gca,'fontsize',16);
%xlabel('Position (Angstrom)');
%ylabel('Static potential (kcal/mol/e)');

figure(2);
set(gca,'fontsize',16);
xlabel('q');
ylabel('\Delta G^{charging} (kcal/mol)');
H_origin=plot(off00.Qdata,off00.Edata,'ko','linewidth',1.5);
hold on;
H_origin_fit = plot(qfine, qfineVDM*[g00(1); meanPhiStatic],'k');
H_05 = plot(off05.Qdata,off05.Edata,'rx');
H_05_fit = plot(qfine, qfineVDM*[g05(1); meanPhiStatic],'r');
H_10 = plot(off10.Qdata,off10.Edata,'m+');
H_10_fit = plot(qfine, qfineVDM*[g10(1); meanPhiStatic],'m');
H_15 = plot(off15.Qdata,off15.Edata,'b*');
H_15_fit = plot(qfine, qfineVDM*[g15(1); meanPhiStatic],'b');
H_20 = plot(off20.Qdata,off20.Edata,'g^');
H_20_fit = plot(qfine, qfineVDM*[g20(1); meanPhiStatic],'g');
H_25 = plot(off25.Qdata,off25.Edata,'k>');
H_25_fit = plot(qfine, qfineVDM*[g25(1); meanPhiStatic],'k');
H_30 = plot(off30.Qdata,off30.Edata,'b<');
H_30_fit = plot(qfine, qfineVDM*[g30(1); meanPhiStatic],'b');
H_35 = plot(off35.Qdata,off35.Edata,'ms','linewidth',1.5);
H_35_fit = plot(qfine, qfineVDM*[g35(1); meanPhiStatic],'m');
