function beta=surf2quadratic(surf)
%function beta=surf2quadratic(surf)
%
%The function fit a quadratic surface of the form
% f(x,y) = b1 x + b2 y + b3 x^2 + b4 xy + b5 y^2
% locally at each vertex after alinging the z-axis to be surface normal n.
% The function returns the coefficients of the quadratic surfaces. 
%
% INPUT
% surf: surface mesh
% 
% OUTPUT
% beta = (b1, b2, b3, b4, b5) coeffient vector in masurf.facesx form
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




[nbr, degree] = FINDnbr(surf.faces); %find neighboring vertices of given vertex. 
                              %degree is the number of edges connecting to
                              %the vertex.

normal =surf2normal(surf); %unit surface normal vector at vertex
                              
                              
coord=surf.vertices';
n_vertex=size(coord,2);
beta=zeros(n_vertex,5); %OUTPUT variable

%gdet=zeros(n_points,1);
%conformal_coord=zeros(n_points,2,6);


for i=1:n_vertex
   
   %translate vertex to the origin (0,0,0)
   nbr_list=nbr(i,1:degree(i));

   %vector represneting edges connecting to the i-th vertex. In book
   %notation, this is p_i - p. 
   coord_nbr = coord(:,nbr_list)-kron(ones(1,degree(i)),coord(:,i));
   
   %surface normal vector estimation at vertex using neighboring surf.facesangles
   
   n=normal(i,:);
   
   
   % Rotation by the Eulerian Angles   
   % Q1 rotation to align to x-axis.
   % Q2 rotation to align to z-axis.
   
   
   deno= sqrt(n(1)^2+n(2)^2);   
   if deno < 0.1
      Q=eye(3);
   else
      Q1 = [[n(1)/deno,n(2)/deno,0];
         [-n(2)/deno,n(1)/deno,0];
         [0,     0,      1]];
      Q2 = [[n(3),0, -deno];
         [0,      1,      0];
         [deno,0,n(3)]];
      Q=Q2*Q1;
   end;
   %if Q*n = (0,0,1), the algorithm is correct
   
   rot_coord_nbr = Q*coord_nbr;
   
   % beta = (X'X)^(-1)X'z 
   z = [rot_coord_nbr(3,:)]';
   x = [rot_coord_nbr(1,:)]';
   y = [rot_coord_nbr(2,:)]';
  
   % X : design masurf.facesx 
   X=[x, y, x.^2, 2*x.*y, y.^2]; %Xbeta =z
   beta(i,:) = (X\z)';
   % Conformal Coordinate Transform
   
   %temp1=[[1+beta(i,1)^2,beta(i,1)*beta(i,2)];
   %   [beta(i,1)*beta(i,2),1+beta(i,2)^2]];
   %gdet(i)=det(temp1);
   %ghalf=sqrtm(temp1);
   %temp=ghalf*[x';y'];
   %if size(temp,2)==5
   %   conformal_coord(i,:,:)=[temp,[0;0]];
   %else
   %  conformal_coord(i,:,:)=temp;
   %end;
end; 

   