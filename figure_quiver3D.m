function figure_quiver3surface(coord, disp, res);
%
%figure_quiver3surface(surf, disp, res);
%
% The function displays vector field disp along the surface surf.
%
% coord : node coordinates
% disp  : displacement vector of size n x 3, where n is the number of
%            vertices
% res   :  sampling rate. If you want to diplay vectors at every 4 vertices,
%            let res = 4.
%
% (C) Moo K. Chung 
%  mkchung@wisc.edu
%  Department of Biostatisics and Medical Informatics
%  University of Wisconsin, Madison


%p=patch(surf);
%set(p,'FaceColor','w','EdgeColor','w');



n=1:res:size(coord,1);

hold on;
quiver3(coord(n,1), coord(n,2), coord(n,3), ...
    disp(n,1), disp(n,2), disp(n,3), 0, 'LineWidth',1, 'Color', 'k' );

%daspect([1 1 1]);
%axis tight
%camlight; 

%lighting gouraud
%material shiny; 

%background='white';
%set(gcf,'Color',background,'InvertHardcopy','off');
