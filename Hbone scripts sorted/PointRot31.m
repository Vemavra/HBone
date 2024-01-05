function [A31, A31check] = PointRot31(A3)
%PointRot31 Translates coordinates of the points in Dataset 3 (interlamellar)
%to their corresponding coordinates in dataset 1 (Vertical segmented)

%Datasets position correlation
format shortG;

%0- horizontal cut, 
%1- vertical cut (bulk segmented)(X-90), 
%2- ortholamellar cut,
%3- intralamellar cut (segmented)

%Oik =coordinate of the dataset i center on k axis


%3 Final interlamellar
syms x3 y3 z3
a3=-206;
b3=-15;
c3=0;

length3x=1406;
length3y=1024;
length3z=1406;
O3x= length3x*(1/2)+a3;
O3y= length3y*(1/2)+b3;
O3z= length3z*(1/2)+c3;
O3=[O3x;O3y;O3z]; % Center of the dataset 3
%Move (0,0,0) to O3
A3new=A3-O3; %coordinate of A3 in the center-snapped coordinates

%2 ortholamellar
syms x2 y2 z2
a2=-206;
b2=-15;
c2=0;
A2=[a2;b2;c2]; % starting corner of the dataset 2
length2x=1406;
length2y=1024;
length2z=1406;
O2x= length2x*(1/2)+a2;
O2y= length2y*(1/2)+b2;
O2z= length2z*(1/2)+c2;
O2=[O2x;O2y;O2z];
A2new=A2-O2;

%1 Initial bulk segmented
syms x1 y1 z1
a1=0;
b1=-15;
c1=0;
A1=[a1;b1;c1]; %starting corner of dataset 1
length1x=994;
length1y=1024;
length1z=994;
O1x= length1x*(1/2)+a1;
O1y= length1y*(1/2)+b1;
O1z= length1z*(1/2)+c1;
O1=[O1x;O1y;O1z];
A1new=A1-O1;

%%
%Transformation 3 to 2
Rdy(90);

M3=[x3;y3;z3];
x2y2z2=Rdy(-90)*M3; %new axis=rotation*old axis
A3new;
A2new;
A3new2=Rdy(-90)*A3new;
A32=A3new2+O2;

%Transformation 3 to 2
Rdy(45);

M2=[x2;y2;z2];
x1y1z1=Rdy(45)*M3; %new axis=rotation*old axis
A3new2; % A3 in coord x2y2z2 centered
A2new; % A2 in coord x2y2z2 centered
A1new; % A1 in coord x1y1z1 centered
A2new1=Rdy(45)*A2new; %A2 in coord x1y1z1 centered
A21=A2new1+O1; %A2 in coord x1y1z1 
A3new1=Rdy(45)*A3new2; %A3 in coord x1y1z1 centered
A31=A3new1+O1; %A3 in coord x1y1z1

A31check=O1+Rdy(45)*(Rdy(-90)*(A3-O3));

end

