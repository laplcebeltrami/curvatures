function surfnormal =surf2normal(surf);
%
% normal =surf2normal(surf);
%
% The function computes the unit normal vector of triangulated surface at vertex.
%
%
% The algorithm is based on 
%
% [1] Chung, M.K., 2013 Computational Neuroanatomy: The Methods, World
% Scientific Publishing, pages 100-109
%
% 
% [2] Chung. M.K. 2001, Statistical Morphometry in Computional Neuroanatomy, 
%     PhD Thesis, McGill University, Montreal. 
%     http://www.stat.wisc.edu/~mchung/papers/thesis.pdf
%
%
% (C) 2019 Moo K. Chung
% University of Wisconsin-Madiosn
%
% mkchung@wisc.edu
%
% 
% Update history
% 2019 August 23: Modified from Getarea.m
% 2019 August 26: Gives unit normal vector

area = faceArea(surf); %area of face
normals = faceNormal(surf); %normal of face

faces = surf.faces;
vertices = surf.vertices;
nvertices = size(vertices,1);

surfnormal=zeros(nvertices,3);
for i=1:nvertices
   [ind_tri, ind_ver] = find(faces ==i); 
   areas = area(ind_tri); %areas as weight
   
   %Old code gives normal vector but will not give unit normal vector.
   %areas = areas/sum(areas); %normalize areas
   %surfnormal(i,:) = sum(areas.*normals(ind_tri,:),1); 
   
   unitnormal = sum(areas.*normals(ind_tri,:),1);
   unitnormal = unitnormal/norm(unitnormal);
   surfnormal(i,:) = unitnormal; 
end


end
