function area = faceArea(surf)
%function area = faceArea(surf)
%
%The function computes the area of each triangle face.
%
%(C) Moo K. Chung
% University of Wisconsin-Madison
%
%2019 August 23


faces=surf.faces;
coord=surf.vertices;

v1 = coord(faces(:,2),:) - coord(faces(:,1),:); %first edges
%v1 = v1./vecnorm(v1,2,2);  %unit vector 
v2 = coord(faces(:,3),:) - coord(faces(:,1),:); %second edges
%v2 = v2./vecnorm(v2,2,2);  %unit vector
%angels = acos(sum(v1.*v2,2)); %cosine angle between v1 and v2 

area = vecnorm(cross(v1,v2),2,2);

