function [ S3, count, A ] = FindSegments( P, Sini, xstart, zstart, ysurface,omega, a, b, c, d, e, f )
%FindSegments takes P table of Raman points translated by Coordinates.m
%script and S table of segments data
%Coordinates of R are converted to inner Arivis coordinates of a particular
%reconstructed volume
%3 for loops choose segments included in raman point volume

%read table Points
P
%Pn=P.('Count')
% Point=P.('Point')
Pn=[1:length(P.Point)]'
Point=Pn
%%
xnCT=P.('xnCT');
ynCT=P.('ynCT');
outofplane= P.('outofplane');
inplane= P.('inplane');
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
xARpStart=xARp-eps
xARpEnd=xARp+eps
zARpStart=zARp-eps
zARpEnd=zARp+eps



%read table segments
S=Sini
ID = S.ID;
x1_ARs = S.x1_ARs;
x2_ARs = S.x2_ARs;
z1_ARs = S.z1_ARs;
z2_ARs = S.z2_ARs;
y1_ARs = S.y1_ARs;
y2_ARs = S.y2_ARs;
x_ARs= S.x_ARs;
z_ARs= S.z_ARs;
y_ARs= S.y_ARs;
angleXY= S.angleXY
angleXZ= S.angleXZ
angleYZ= S.angleYZ
S=table(ID, y1_ARs, y2_ARs, x1_ARs, x2_ARs, z1_ARs, z2_ARs, y_ARs, x_ARs, z_ARs, angleXY, angleXZ, angleYZ); 
rowl=size(S,2)

% %compare depth positions
L=length(ID)
k=1
klog=[0]
statusy={}
centery=[0]


  for i=1:L
      count=i
      disp(y1_ARs(i))
      disp(y_up)
      disp(y_down)
      if (y1_ARs(i) > y_up && y2_ARs(i) < y_down)
          S1(k,1:rowl)=S(i,1:rowl);
          klog(k)=k;
          S1.k=klog';
          statusy(k)={'small Y'}
          S1.statusy=statusy';
          centery(k)= y2_ARs(i) - y_ARs(i)/2;
          S1.centery=centery';
          k=k+1
      elseif (y1_ARs(i) < y_up && y2_ARs(i)> y_down) 
          disp('Very big segment Y')
          S1(k,1:rowl)=S(i,1:rowl);
          klog(k)= k;
          S1.k=klog';
          statusy(k)= {'very big Y'}
          S1.statusy=statusy';
          centery(k)=y2_ARs(i) - y_ARs(i)/2;
          S1.centery=centery';
          k=k+1    
      elseif (y1_ARs(i) < (yARp+epsy/2) && y2_ARs(i)> y_down) 
          disp('Big down segment Y');
          S1(k,1:rowl)=S(i,1:rowl);
          klog(k)= k;
          S1.k=klog';
          statusy(k) = {'big down Y'}
          S1.statusy = statusy';
          centery(k)=y2_ARs(i) - y_ARs(i)/2;
          S1.centery=centery';
          k=k+1
      elseif (y1_ARs(i)< y_up && y2_ARs(i) > (yARp-epsy/2)) 
          disp('Big up segment Y')
          centery(k)=y2_ARs(i) - y_ARs(i)/2;
          S1(k,1:rowl)=S(i,1:rowl);
          klog(k)=k;
          S1.k=klog';
          statusy(k)= {'big up Y'}
          S1.statusy=statusy';
          S1.centery=centery';
          k=k+1
      else
          disp('object not foundY')
     
      end
      
  end

S1.Properties.VariableNames([1:rowl])= {'ID' 'y1_ARs' 'y2_ARs' 'x1_ARs' 'x2_ARs' 'z1_ARs' 'z2_ARs' 'y_ARs' 'x_ARs' 'z_ARs' 'angleXY' 'angleXZ' 'angleYZ' }

%Compare horizontal positions X
ID = S1.('ID');
x1_ARs = S1.('x1_ARs');
x2_ARs = S1.('x2_ARs');
z1_ARs = S1.('z1_ARs');
z2_ARs = S1.('z2_ARs');
y1_ARs = S1.('y1_ARs');
y2_ARs = S1.('y2_ARs');
x_ARs= S1.('x_ARs');
z_ARs= S1.('z_ARs');
y_ARs= S1.('y_ARs');
angleXY= S1.('angleXY');
angleXZ= S1.('angleXZ');
angleYZ= S1.('angleYZ');
L1=length(Pn)
L2=length(S1.ID)  

f1=figure;
for i=1:L2 
    hold on
    plot ([x1_ARs(i) x1_ARs(i) x2_ARs(i) x2_ARs(i) x1_ARs(i)], [z1_ARs(i) z2_ARs(i) z2_ARs(i) z1_ARs(i) z1_ARs(i)],'LineWidth',2)
    daspect([1 1 1])
    axis([a b c d])
end
% 
hold on
sz=eps*2
h=scatter(xARp, zARp,'red','s')
currentunits = get(gca,'Units');
set(gca, 'Units', 'Points');
axpos = get(gca,'Position');
set(gca, 'Units', currentunits);
markerWidth = sz/diff(xlim)*axpos(3); % Calculate Marker width in points
set(h, 'SizeData', markerWidth^2)
hold off

i=1
p=1
plog=[0]
statusx={}
centerx=[0]
pointn=[]
pointx =[0]
rowl=rowl+3

for j=1:L1
    for i=1:L2
        if (x1_ARs(i) > xARp(j)-eps && x2_ARs(i) < xARp(j)+eps)
          S2(p,1:rowl)=S1(i,1:rowl);
          plog(p)=p;
          S2.p=plog';
          class(pointn)
          class(Point)
          Point(j)
          pointn(p)= Point(j);
          S2.point=pointn';
          pointx(p)=xARp(j);
          S2.point_x=pointx';
          statusx(p)={'small X'};
          S2.statusx=statusx';
          centerx(p)= x2_ARs(i) - x_ARs(i)/2;
          S2.centerx=centerx';
          p=p+1
        elseif (x1_ARs(i) < xARp(j)-eps && x2_ARs(i)> xARp(j)+eps) 
          disp('Very big segment X')
          S2(p,1:rowl)=S1(i,1:rowl);
          plog(p)= p;
          S2.p =plog';
          pointn(p)=Point(j);
          S2.point=pointn';
          pointx(p)=xARp(j);
          S2.point_x=pointx';
          statusx(p)= {'very big X'};
          S2.statusx=statusx';
          centerx(p)=x2_ARs(i) - x_ARs(i)/2;
          S2.centerx=centerx';
          p=p+1    
      elseif (x1_ARs(i) < (xARp(j)+eps/2) && x2_ARs(i)> xARp(j) + eps)           
          disp('Big down segment X');
          S2(p,1:rowl)=S1(i,1:rowl);
          plog(p)= p;
          S2.p=plog';
          pointn(p)=Point(j);
          S2.point=pointn';
          pointx(p)=xARp(j);
          S2.point_x=pointx';
          statusx(p) = {'big down X'};
          S2.statusx = statusx';
          centerx(p)=x2_ARs(i) - x_ARs(i)/2;
          S2.centerx=centerx';
          p=p+1
      elseif (x1_ARs(i)< xARp(j)-eps && x2_ARs(i) > (xARp(j)-eps/2)) 
          disp('Big up segment X')
          S2(p,1:rowl)=S1(i,1:rowl);
          plog(p)=p;
          S2.p=plog';
          pointn(p)=Point(j);
          S2.point=pointn';
          pointx(p)=xARp(j);
          S2.point_x=pointx';
          statusx(p)= {'big up X'};
          S2.statusx=statusx';
          centerx(p)=x2_ARs(i) - x_ARs(i)/2;
          S2.centerx=centerx';
          p=p+1
          
        else
            disp('object not foundX')
        end
    end
end

S2.Properties.VariableNames([1:rowl])= {'ID' 'y1_ARs' 'y2_ARs' 'x1_ARs' 'x2_ARs' 'z1_ARs' 'z2_ARs' 'y_ARs' 'x_ARs' 'z_ARs' 'angleXY' 'angleXZ' 'angleYZ' 'k' 'status_y' 'center_y'};


%Compare horizontal positions Z

ID = S2.('ID');
x1_ARs = S2.('x1_ARs');
x2_ARs = S2.('x2_ARs');
z1_ARs = S2.('z1_ARs');
z2_ARs = S2.('z2_ARs');
y1_ARs = S2.('y1_ARs');
y2_ARs = S2.('y2_ARs');
x_ARs= S2.('x_ARs');
z_ARs= S2.('z_ARs');
y_ARs= S2.('y_ARs');
angleXY = S2.('angleXY');
angleXZ = S2.('angleXZ');
angleYZ = S2.('angleYZ');
point= S2.('point');

L3=length(S2.ID)  

f2=figure;
for i=1:L3 
    hold on
    plot ([x1_ARs(i) x1_ARs(i) x2_ARs(i) x2_ARs(i) x1_ARs(i)], [z1_ARs(i) z2_ARs(i) z2_ARs(i) z1_ARs(i) z1_ARs(i)],'LineWidth',2) 
    daspect([1 1 1])
    axis([a b c d])
end
% 
hold on
sz=eps*2
h=scatter(xARp, zARp,'red','s')
currentunits = get(gca,'Units');
set(gca, 'Units', 'Points');
axpos = get(gca,'Position');
set(gca, 'Units', currentunits);
markerWidth = sz/diff(xlim)*axpos(3); % Calculate Marker width in points
set(h, 'SizeData', markerWidth^2)
hold off


i=1
j=1
m=1
mlog=[0]
statusz={}
centerz=[0]
point1={}
pointz =[0]
outofplangle=[0]
inplangle=[0]
rowl=rowl+5

Point(j) 
pointn(i)
L1
L3
strcmp(Point(j), pointn'(i))

for j=1:L1
    for i=1:L3
        z1_ARs(i)
        zARp(j)-eps
        z2_ARs(i)
        zARp(j)+eps
        if (strcmp(Point(j), pointn(i)) && z1_ARs(i) > zARp(j)-eps && z2_ARs(i) < zARp(j)+eps)
          S3(m,1:rowl)=S2(i,1:rowl)
          mlog(m)=m;
          S3.m=mlog';
          point1(m)=Point(j);
          S3.point1=point1';
          pointz(m)=zARp(j);
          S3.point_z=pointz';
          outofplangle(m)=outofplane(j);
          S3.outofplane= outofplangle';
          inplangle(m)=inplane(j);
          S3.inplane=inplangle';
          statusz(m)={'small Z'};
          S3.statusz=statusz';
          centerz(m)= z2_ARs(i) - z_ARs(i)/2 ;
          S3.centerz=centerz';
          m=m+1
        elseif (strcmp(Point(j), pointn(i)) && z1_ARs(i) < zARp(j)-eps && z2_ARs(i)> zARp(j)+eps) 
          disp('Very big segment Z')
          S3(m,1:rowl)=S2(i,1:rowl)
          mlog(m)= m;
          S3.m =mlog';
          point1(m)=Point(j);
          S3.point1=point1';
          pointz(m)=zARp(j);
          S3.point_z=pointz';
          outofplangle(m)=outofplane(j);
          S3.outofplane= outofplangle';
          inplangle(m)=inplane(j);
          S3.inplane=inplangle';
          statusz(m)= {'very big Z'};
          S3.statusz=statusz';
          centerz(m)=z2_ARs(i) - z_ARs(i)/2;
          S3.centerz=centerz';
          m=m+1    
      elseif (strcmp(Point(j), pointn(i)) && z1_ARs(i) < (zARp(j)+eps/2) && z2_ARs(i)> zARp(j)+eps)          
          disp('Big down segment Z');
          S3(m,1:rowl)=S2(i,1:rowl)
          mlog(m)= m;
          S3.m=mlog';
          point1(m)=Point(j);
          S3.point1=point1';
          pointz(m)=zARp(j);
          S3.point_z=pointz';
          outofplangle(m)=outofplane(j);
          S3.outofplane= outofplangle';
          inplangle(m)=inplane(j);
          S3.inplane=inplangle';
          statusz(m) = {'big down Z'};
          S3.statusz = statusz';
          centerz(m)=z2_ARs(i) - z_ARs(i)/2;
          S3.centerz=centerz';
          m=m+1
      elseif (strcmp(Point(j), pointn(i)) && z1_ARs(i)< zARp(j)-eps && z2_ARs(i) > (zARp(j)-eps/2))
          disp('Big up segment Z')
          S3(m,1:rowl)=S2(i,1:rowl)
          mlog(m)=m;
          S3.m=mlog';
          point1(m)=Point(j);
          S3.point1=point1';
          pointz(m)=zARp(j);
          S3.point_z=pointz';
          outofplangle(m)=outofplane(j);
          S3.outofplane= outofplangle';
          inplangle(m)=inplane(j);
          S3.inplane=inplangle';
          statusz(m)= {'big up Z'};
          S3.statusz=statusz';
          centerz(m)=z2_ARs(i) - z_ARs(i)/2;
          S3.centerz=centerz';
          m=m+1
          
        else
            disp('object not foundZ')
        end
    end
end

if S3==false
    S3=0
    A=0
    count=0
    return
end
S3.Properties.VariableNames([1:rowl])= {'ID' 'y1_ARs' 'y2_ARs' 'x1_ARs' 'x2_ARs' 'z1_ARs' 'z2_ARs' 'y_ARs' 'x_ARs' 'z_ARs' 'angleXY' 'angleXZ' 'angleYZ' 'k' 'status_y' 'center_y' 'p' 'point' 'point_x' 'status_x' 'center_x'}
count=size(S3)

ID = S3.('ID');
x1_ARs = S3.('x1_ARs');
x2_ARs = S3.('x2_ARs');
z1_ARs = S3.('z1_ARs');
z2_ARs = S3.('z2_ARs');
y1_ARs = S3.('y1_ARs');
y2_ARs = S3.('y2_ARs');
x_ARs= S3.('x_ARs');
z_ARs= S3.('z_ARs');
y_ARs= S3.('y_ARs');
angleXY= S3.('angleXY');
angleXZ= S3.('angleXZ');
angleYZ= S3.('angleYZ');

point= S3.('point');
outofplane=S3.('outofplane');
inplane=S3.('inplane');
A=table( ID, angleXY, angleXZ, angleYZ, point, outofplane, inplane);

% f5=figure;
% histogram(angleXY,9)
% hold on
% histogram(outofplanepitch,9)
% hold off
% 
% f6=figure;
% scatter(point, outofplanepitch,'red')
% hold on
% scatter(point, angleXY,'blue')
% 
% i=1
% sumangleXY=angleXY(1)
% n=1
% for j=2:length(A.ID)
%     if point(j)== point(j-1)
%         sumangleXY=sumangleXY+angleXY(j)
%         n=n+1
%     else
%         Avg(i,1:2)=A(j-1,3:4)
%         Avg.avgangle(i)=sumangleXY/n
%         i=i+1
%         n=1
%         sumangleXY=angleXY(j)
%     end
%     Avg(i,1:2)=A(j-1,3:4)
%     Avg.avgangle(i)=sumangleXY/n
% end
% 
% hold on
% Avg.Properties.VariableNames([1:2])= {'point' 'outofplane'}
% point=Avg.point
% avgangle=Avg.avgangle
% scatter(point, avgangle,'green') 
% hold off

L4=length(S3.ID)  

%Stick segments
% f3=figure;
% for i=1:L4 
%     hold on
%     plot ([x1_ARs(i) x2_ARs(i)], [z1_ARs(i) z2_ARs(i)],'LineWidth',2) 
%     daspect([1 1 1])
%     axis([a b c d])
% end
% % 
% hold on
% sz=62*2
% h=scatter(xARp, zARp,'red','s')
% currentunits = get(gca,'Units');
% set(gca, 'Units', 'Points');
% axpos = get(gca,'Position');
% set(gca, 'Units', currentunits);
% markerWidth = sz/diff(xlim)*axpos(3); % Calculate Marker width in points
% set(h, 'SizeData', markerWidth^2)
% hold off

f8=figure;
for i=1:L4 
    hold on
    plot ([x1_ARs(i) x1_ARs(i) x2_ARs(i) x2_ARs(i) x1_ARs(i)], [z1_ARs(i) z2_ARs(i) z2_ARs(i) z1_ARs(i) z1_ARs(i)],'LineWidth',2) 
    daspect([1 1 1])
    axis([a b c d])
end
% 
hold on
sz=eps*2
h=scatter(xARp, zARp,'red','s')
currentunits = get(gca,'Units');
set(gca, 'Units', 'Points');
axpos = get(gca,'Position');
set(gca, 'Units', currentunits);
markerWidth = sz/diff(xlim)*axpos(3); % Calculate Marker width in points
set(h, 'SizeData', markerWidth^2)
hold off

% f4=figure;
% i=1
% 
% for i=1:L4 
%     hold on
%     plot3([x1_ARs(i) x2_ARs(i)],[z1_ARs(i) z2_ARs(i)],[y1_ARs(i) y2_ARs(i)],'LineWidth',2 )
%     grid on
%     axis equal
%     axis([a b c d  e f])
%     
% end

% view(3);


end

