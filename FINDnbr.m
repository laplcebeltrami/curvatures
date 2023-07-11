function [nbr, degree] = FINDnbr(tri)
%[nbr, degree] = FINDnbr(tri)
%
% The function finds the first ring neighbors and degree from a given a triangle mesh.  
% tri    : list of triangle elements
% nbr    : first order neihbor vertex list 
% degree : degree of each vertex
%
%
%(C) Moo K. Chung   mkchung@wisc.edu
% University of Wisconsin-Madison
%
% http://www.stat.wisc.edu/~mchung/softwares/softwares.html
%
%
% Updates
%    2004 Feb 5; Nov 14
%    2007 
%    2010 July 24  : It works for planer mesh as well
%    2018 January 1: Fixed inconsistent degree for some nodes. 
%    2019 August 23: documentaiton updated


%degree computation

n_tri=size(tri,1);
%n_vertex = (n_tri+4)/2;
% this equation only works for spherical object
%
% V = number of vertices
% F = number of faces
% For spherical mesh we have
% F = 2V - 4: Euler characteristic equation.


% maximum node index becomes the number of vertices
n_vertex=max(max(tri));

if (2*n_vertex-n_tri) ==4
    % this only works for spherical mesh
    % it uses the fact the total number of edge is counted twice
    degree=zeros(n_vertex,1);
    for j=1:n_tri
        degree(tri(j,:))=degree(tri(j,:))+1;
    end
    max_degree=max(degree);

    % 1st order neighbor computation

    nbr=zeros(n_vertex,max_degree);

    for i_tri=1:n_tri
        for j=1:3
            cur_point = tri(i_tri,j);
            for k=1:3
                if (j ~= k)
                    nbr_point= tri(i_tri,k);
                    if find(nbr(cur_point,:)==nbr_point)
                        ;
                    else
                        n_nbr = min(find(nbr(cur_point,:) == 0));
                        nbr(cur_point,n_nbr) = nbr_point;
                    end;
                end;
            end;
        end;
    end;
    
else
    %planer mesh
    adj = mesh2adj(tri); % computes the adjaceny matrix
    degree= sum(adj,2); % sum the adjacency matrix to compute the node degree

    max_degree=max(degree);
    nbr=zeros(n_vertex,max_degree);
    for i=1:n_vertex
        nbr(i,1:degree(i))=find(adj(i,:));
    end;
end;

degree = sum(nbr>0,2); %fix inconsistent node degree

%--------------------------------------
function adj = mesh2adj(tri)
%adj = mesh2adj(tri)
%
% MESH2ADJ computes the adjacency matrix of given triangulation
%
% tri    : list of triangle elements that form triangles
% adj    : adjacency matrix
%
%(C) Moo K. Chung   mkchung@wisc.edu
%
% Department of Statistics and Medical Informatics
% University of Wisconsin-Madison
%
%
% Update history:
% July 24, 2010: function created


n_tri=size(tri,1);  % number of triangles
n_vertex = max(max(tri));  % number of nodes

adj=zeros(n_vertex,n_vertex);

for i=1:n_tri
    adj(tri(i,1), tri(i,2))=1;
    adj(tri(i,2), tri(i,3))=1;
    adj(tri(i,3), tri(i,1))=1;
end;


adj=(adj'+adj); % make it symmetric

[I, J] = find(adj);

% renormalize
for i=1:length(I)
    adj(I(i),J(i)) = 1;
end;
