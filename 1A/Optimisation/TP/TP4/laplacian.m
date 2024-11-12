function L = laplacian(nu,dx1,dx2,N1,N2)
%
%  Cette fonction construit la matrice de l'op�rateur Laplacien 2D anisotrope
%
%  Inputs
%  ------
%
%  nu : nu=[nu1;nu2], coefficients de diffusivit� dans les dierctions x1 et x2. 
%
%  dx1 : pas d'espace dans la direction x1.
%
%  dx2 : pas d'espace dans la direction x2.
%
%  N1 : nombre de points de grille dans la direction x1.
%
%  N2 : nombre de points de grilles dans la direction x2.
%
%  Outputs:
%  -------
%
%  L      : Matrice de l'op�rateur Laplacien (dimension N1N2 x N1N2)
%
% 

% Initialisation
L=sparse([]);

beta1 = - nu(1)/(dx1^2);
beta2 = - nu(2)/(dx2^2);
alpha = - 2*(beta1 + beta2); 

e2 = ones(N2,1);
e1 = ones(N1,1);
A = spdiags([beta2*e2 alpha*e2 beta2*e2],-1:1,N2,N2);
D = beta1 * speye(N2);

Ah1 = kron(speye(N1),A);
Ah2 = kron(spdiags([e1 zeros(N1,1) e1],-1:1,N1,N1),D);

L = Ah1 + Ah2;

end    
