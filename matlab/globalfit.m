function x = globalfit(q,E,phiStatic)
x = q.^2 \ (E-phiStatic*q);