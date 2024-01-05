function [ T ] = nCTPoints( P, kcorrw, kcorrh, sheetnum )
%Translates the coordinate values of input Raman data to the coordinates of
%nano-CT reconstruction using overlay position coordinates, 
%scaling parameters and 2D rotation matrix

C=readtable('Center_coordinates.xlsx')
Ax=C.Ax(sheetnum)%row in the table = sheet number in the output
Ay=C.Ay(sheetnum)
omega=C.Angle(sheetnum)

omegar=deg2rad(omega);

Point= P.('Unnamed')
xRi= P.('x_pix');
yRi= P.('y_pix');
inplane= P.(8);%reads qPRS angle data
outofplane=P.(7);

xR=xRi*kcorrw;%scales Raman point coordinates to the nano-CT scale
yR=yRi*kcorrh;

xR_t=xR-Ax;%translates coordinate center to A
yR_t=yR-Ay;

%2D Rotation matrix
xnCT=yR_t*sin(omegar)+xR_t*cos(omegar);
ynCT=yR_t*cos(omegar)-xR_t*sin(omegar);

%Boundary data for FTT with 1 and 2 um cell size
eps=31;
FTT1_x1nCT=xnCT-eps;
FTT1_x2nCT=xnCT+eps;
FTT1_y1nCT=ynCT-2*eps;
FTT1_y2nCT=ynCT+2*eps;

FTT2_x1nCT=xnCT-eps;
FTT2_x2nCT=xnCT+eps;
FTT2_y1nCT=ynCT-2*eps;
FTT2_y2nCT=ynCT+2*eps;

%Table for correlation algorithm
Count=[1:length(xRi)];
Count=Count.';
T=table(Count, Point, xRi ,yRi, xnCT, ynCT, inplane, outofplane);
filename = 'nCT_coordinates1.xlsx';
writetable(T,filename,'Sheet',sheetnum)

% %Table for FTT analysis
% Point=[1:length(xRi)];
% Point=Point.';
% T_FTT=table(Point,xRi,yRi,xnCT,ynCT, inplane, outofplane, FTT1_x1nCT, FTT1_x2nCT, FTT1_y1nCT, FTT1_y2nCT,FTT2_x1nCT, FTT2_x2nCT, FTT2_y1nCT, FTT2_y2nCT );
% filename = 'nCT_coordinates_FTT.xlsx';
% writetable(T,filename,'Sheet',sheetnum)
% 
% %Table for housekeeping
% Ox=C.Ox(sheetnum)
% Oy=C.Oy(sheetnum)
% Ax_ini=Ax/kcorrw;%finds nCT starting corner and circle center in original image
% Ay_ini=Ay/kcorrh;
% Ox_ini=Ox/kcorrw;
% Oy_ini=Oy/kcorrh;
% Z=table(Ax, Ay, Ax_ini, Ay_ini, Ox, Oy, Ox_ini, Oy_ini,  omega, omegar)
% filename = 'nCT_center.xlsx';
% writetable(Z,filename,'Sheet',sheetnum);
end

