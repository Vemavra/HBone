function [ G ] = RecordPoints( P, xstart, zstart, ysurface,omega)
%FindSegments takes P table of Raman points translated by Coordinates.m
%script and S table of segments data
%Coordinates of R are converted to inner Arivis coordinates of a particular
%reconstructed volume
%3 for loops choose segments included in raman point volume

%read table Points
P
%Pn=P.('Count')
Point=P.('Point')
Pn=[,1:length(Point)]
rowl=13
xnCT=P.('xnCT')
ynCT=P.('ynCT')
outofplane= P.('outofplane')
inplane= P.('inplane')
L1=length(Pn)
%convert table points
xARp=xnCT+xstart
zARp=zstart-ynCT
epsy=62
eps=62
yAR_surface=ysurface
pixdepth=5000/16,09
yARp=yAR_surface+pixdepth
y_up=yARp-epsy
y_down=yARp+epsy

%table qPRS point boxes
% xARpStart=xARp-eps
% xARpEnd=xARp+eps
% zARpStart=zARp-eps
% zARpEnd=zARp+eps
G=table(Point,xARp, zARp, yARp, eps,epsy)


end

