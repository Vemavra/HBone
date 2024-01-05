function [surfpiped] = Parapiped(x1, x2, y1, y2, z1, z2)
%clear
% x1=0; x2=4; y1=1; y2=3; z1=0; z2=2;
%plots a box
coord= [...
    x1 y1 z1;
    x2 y1 z1;
    x2 y2 z1;
    x1 y2 z1;
    x1 y1 z2;
    x2 y1 z2;
    x2 y2 z2;
    x1 y2 z2;]
% coord = [...
%     0    0    0;
%     0.5  0    0;
%     0.5  0.5  0;
%     0    0.5  0;
%     0    0    0.5;
%     0.5  0    0.5;
%     0.5  0.5  0.5;
%     0    0.5  0.5;];

idx = [4 8 5 1 4; 1 5 6 2 1; 2 6 7 3 2; 3 7 8 4 3; 5 8 7 6 5; 1 4 3 2 1]'
xc = coord(:,1)
yc = coord(:,2)
zc = coord(:,3)
% xc(idx)
% yc(idx)
% zc(idx)
%ax(1) = subplot(1,1,1)
% patch(xc(idx), yc(idx), zc(idx), 'y', 'facealpha', 0.1)
% stlwrite('parapiped_test.stl', xc(idx), yc(idx), zc(idx))
surfpiped=surf(xc(idx), yc(idx), zc(idx),'facealpha', 0.1)
% stlwrite('parapiped_test.stl', faces_all, vertices_all);


% surf2stl('parapiped_test3.stl', xc(idx), yc(idx), zc(idx))
view(3);
end