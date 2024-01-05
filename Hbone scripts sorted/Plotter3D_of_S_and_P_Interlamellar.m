clear
format longG;

%write back EV1 
%solve code for empty match case
%fix Anlges in FindSegmentsIL

%read Raman point coordinates in nano-CT notation
P=readtable('nCT_coordinates1.xlsx', 'Sheet',3);%lookup green dataset sheetnum
%%
%Arivis axis parameters Dataset 1
xstart=0;
zstart=994;
ysurface=(194+170)/2;
omega=47.9

%plot parameters
a=-800; b=1200; c=-600; d=1400; e=-400; f=1000;

%read segments Interlamellar
fp ='D:\Programs\MATLAB\MATLAB Hbone\Hbone scripts sorted';
fns = {'green_interlam_Y-45_features_EV1_BadAngles_translated.xlsx','green_interlam_Y-45_features_LV1_BadAngles_translated.xlsx','green_interlam_Y-45_features_LV2_BadAngles_translated.xlsx','green_interlam_Y-45_features_LV3_BadAngles_translated.xlsx','green_interlam_Y-45_features_EV2_BadAngles_translated.xlsx'};
lamcolor={'cyan','green','blue','red','magenta'}

f1a=figure
for ii=1:size(fns,2)
    cfn=fns{ii}
    S = readtable(cfn);
    % 
    %3D figure of the Segments before filtering
    
    L_S=length(S.ID)

    for i=1:L_S
        plot1=plot3([S.x1_ARs(i), S.x2_ARs(i)], [S.y1_ARs(i),S.y2_ARs(i)], [S.z1_ARs(i),S.z2_ARs(i)]);
        plot1.Color=lamcolor{ii};
        i=i+1
        hold on
    end
    xlabel('x')
    ylabel('y')
    zlabel('z')
    daspect([1 1 1])
    axis([a b c d e f])
    i=0
    hold on
end
%%
% f1b=figure
% for i=1:L_S 
%     hold on
%     plot ([x1_ARs(i) x1_ARs(i) x2_ARs(i) x2_ARs(i) x1_ARs(i)], [z1_ARs(i) z2_ARs(i) z2_ARs(i) z1_ARs(i) z1_ARs(i)],'LineWidth',2)
%     daspect([1 1 1])
%     axis([a b c d])
% end
% % 
% hold on
% sz=eps*2
% h=scatter(xARp, zARp,'red','s')
% currentunits = get(gca,'Units');
% set(gca, 'Units', 'Points');
% axpos = get(gca,'Position');
% set(gca, 'Units', currentunits);
% markerWidth = sz/diff(xlim)*axpos(3); % Calculate Marker width in points
% set(h, 'SizeData', markerWidth^2)
% hold off
%%
%( P, Sini, xstart, zstart, ysurface,omega, a, b, c, d, e, f )    
Pn=P.('Count')
Point=P.('Point')

xnCT=P.('xnCT');
ynCT=P.('ynCT');
outofplane= P.('outofplane');
inplane= P.('inplane');
L_P=length(Pn)

%%
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

%%
%table qPRS point boxes
xARpStart=xARp-eps
xARpEnd=xARp+eps
zARpStart=zARp-eps
zARpEnd=zARp+eps

%3D plot Raman points
i=0
for i=1:L_P
    Parapiped(xARpStart(i),xARpEnd(i), y_up, y_down, zARpStart(i),zARpEnd(i))
    hold on
end
xlabel('x')
ylabel('y')
zlabel('z')
daspect([1 1 1])


%%
ii=0
f2=figure
for ii=3:4
    cfn=fns{ii}
    S = readtable(cfn);
    %read table segments
    rowl=size(S,2)
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
    %%
    % %compare depth positions
    k=1
    klog=[0]
    statusy={}
    centery=[0]
    %%
    for i=1:L_S
          count=i
          y1_ARs(i)
          y2_ARs(i)
          y_up
          y_down
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
%%
    L_S1=length(S1.ID)
    i=0
    for i=1:L_S1
        plot1=plot3([S.x1_ARs(i), S.x2_ARs(i)], [S.y1_ARs(i),S.y2_ARs(i)], [S.z1_ARs(i),S.z2_ARs(i)]);
        plot1.Color=lamcolor{ii};
        i=i+1
        hold on
    end
    xlabel('x')
    ylabel('y')
    zlabel('z')
    daspect([1 1 1])
    axis([a b c d e f])
    i=0
    hold on

end
%%
%3D plot Raman points
i=0
for i=1:L_P
    Parapiped(xARpStart(i),xARpEnd(i), y_up, y_down, zARpStart(i),zARpEnd(i))
    hold on
end
xlabel('x')
ylabel('y')
zlabel('z')
daspect([1 1 1])

% %%
%     f1=figure
%     L_S1=length(S1.ID)
% 
%     for i=1:L_S1
%         plot3([S1.x1_ARs(i), S1.x2_ARs(i)], [S1.y1_ARs(i),S1.y2_ARs(i)], [S1.z1_ARs(i),S1.z2_ARs(i)])
%         i=i+1
%         hold on
%     end
%     xlabel('x')
%     ylabel('y')
%     zlabel('z')
%     axis([a b c d e f])
%     i=0

%%
% if Ag ~= 0
%     outputFilename = fullfile(fp,[cfn(1:end-15),'_matched.xlsx']); 
%     writetable(Ag, outputFilename);
% end


