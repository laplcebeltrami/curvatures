function curvatures=surf2curvature(beta)
%function beta= curvatures=surf2curature(beta)
%
%The function computes the curvatuers at the orgin (0,0,0) from quadaratic surface
% f(x,y) = b1 x + b2 y + b3 x^2 + b4 xy + b5 y^2
% locally at each vertex after alinging the z-axis to be surface normal n.
% The function returns the coefficients of the quadratic surfaces. 
%
% INPUT
% beta = (b1, b2, b3, b4, b5) coeffient vector in masurf.facesx form
%
% OUTPUT
%  curvatures.mean  mean curvatures
%  curvatures.K Gaussian curvatures
%
%
% The algorithm is based on 
% [1] Chung, M.K., 2013 Computational Neuroanatomy: The Methods, World
% Scientific Publishing, pages 100-109
% 
% [2] Chung. M.K. 2001, Statistical Morphometry in Computional Neuroanatomy, 
%     PhD Thesis, McGill University, Montreal. 
%     http://www.stat.wisc.edu/~mchung/papers/thesis.pdf
%
%
% (C) Moo K. Chung mkchung@wisc.edu
% University of Wisconsin-Madison
%
% Created: 2001
% Updated: 2007 Nov. 16
% Modifed: 2019 Aug. 23 from function beta=get_quadratic(surf.faces, coord, normal)


%First fundamental form

nvertex = size(beta,1);


%mean= zeros(1,nvertex);
%guassian =zeros(1,nvertex);
%principal = zeros(1,nvertex);

for i = 1:nvertex
   g=[[1 + beta(i,1)^2, beta(i,1)* beta(i,2)];
      [beta(i,1)* beta(i,2), 1 + beta(i,2)^2]];
   h = [[beta(i,3),beta(i,4)];
      [beta(i,4),beta(i,5)]];
   curvatures.gaussian(i) = det(inv(g)*h);
   curvatures.mean(i) = trace(inv(g)*h)/2;
   %curvatures.principal(i) = min(eig(inv(g)*h))^2 + max(eig(inv(g)*h))^2;                    
end
