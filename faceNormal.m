function normals = faceNormal(surf)
% function normals = faceNormal(surf)
%
% This function calculates the normal vectors for each face of a 2D surface.
% The function calculates the vectors of the first and second edges for each face.
% It then calculates the cross product of these two vectors to get the normal vector 
% for each face. Finally, it normalizes each normal vector.
%
% Input:
% surf - a structure with two fields: 'vertices' and 'faces'. 'vertices' is a 
%        Nx3 matrix that contains the coordinates (x, y, z) of each vertex, where
%        N is the number of vertices. 'faces' is a Mx3 matrix that contains the 
%        indices of the vertices that make up each face, where M is the number of faces.
%
% Output:
% normals - a Mx3 matrix that contains the normal vector (nx, ny, nz) for each face. 
%
%(C) Moo K. Chung
% University of Wisconsin-Madison
%2019 August 23

nodes=surf.vertices; 
faces=surf.faces; 

coord=surf.vertices; 

faces = surf.faces;

v1 = coord(faces(:,2),:) - coord(faces(:,1),:); %first edges 
v2 = coord(faces(:,3),:) - coord(faces(:,1),:); %second edges 

%Calculate the cross product of the two vectors (which gives the normal vector), and normalize it.
normals = cross(v1, v2); 
normals = normals./vecnorm(normals')';
