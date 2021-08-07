function Lrow = posnegfit(q, E, phiStatic)

Ipos = find(q>=0);
xpos = [q(Ipos).^2]\(E(Ipos)-phiStatic*q(Ipos));
Ineg = find(q<=0);
xneg = [q(Ineg).^2]\(E(Ineg)-phiStatic*q(Ineg));

Lrow = [xpos xneg];