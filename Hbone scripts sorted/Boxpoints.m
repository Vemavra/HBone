function [G] = Boxpoints(P, xstart, zstart, ysurface)
%exports a table with qPRS point positions in segmented dataset
%   Detailed explanation goes here

%read table Points
P
Pn=P.('Count')
Point=P.('Point')
Pn=[,1:length(Point)]
%rowl=13
xnCT=P.('xnCT')
ynCT=P.('ynCT')
%outofplane= P.('outofplane')
%inplane= P.('inplane')
L1=length(Pn)
%convert table points
xARp=xnCT+xstart
zARp=zstart-ynCT
epsy=62
eps=62
yAR_surface=ysurface
pixdepth=5000/16,09
yARp=yAR_surface+pixdepth


yARp=yARp(ones(1,L1))'
epsxz=eps(ones(1,L1))'
epsy=epsy(ones(1,L1))'

%table qPRS point boxes
% xARpStart=xARp-eps
% xARpEnd=xARp+eps
% zARpStart=zARp-eps
% zARpEnd=zARp+eps
G=table(Point, xARp, zARp, yARp, epsxz,epsy)

end

