function center = faceCenter(surf)
% function normals = faceNormal(surf)
%
% This function calculates the centroid (geometric center) of each face on
% a 3D surface. The function calculates the average of the coordinates of the vertices of each face,
% which results in the centroid of that face.
%
% Input:
% surf - a structure with two fields: 'vertices' and 'faces'. 'vertices' is a 
%        Nx3 matrix that contains the coordinates (x, y, z) of each vertex, where
%        N is the number of vertices. 'faces' is a Mx3 matrix that contains the 
%        indices of the vertices that make up each face, where M is the number of faces.
%
% Output:
%  center - a Mx3 matrix that contains the centroid (x, y, z) for each face. 
%
%(C) Moo K. Chung
% University of Wisconsin-Madison
% 2019 August 23

nodes=surf.vertices;
faces=surf.faces;

coord=surf.vertices;

faces = surf.faces;

% Calculate the centroid of each face
center = (coord(faces(:,1),:) + coord(faces(:,2),:) + coord(faces(:,3),:))/3;



