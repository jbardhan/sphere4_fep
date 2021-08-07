function x = localfit(q,E)
I = find(abs(q) <= 0.2);
x = [q(I).^2 q(I)] \ E(I);