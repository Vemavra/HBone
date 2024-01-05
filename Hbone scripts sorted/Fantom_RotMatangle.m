clear
% % %Apply rotation matrix

%Tables={'Fantom_xz35-features_5','Fantom_xz35-features_10','Fantom_xz35-features_20','Fantom_xz35-features_30', ...
%    'Fantom_xz35-features_40','Fantom_xz35-features_50','Fantom_xz35-features_70','Fantom_xz35-features_90'}
Tables={'Fantom_xz35-features_20new','Fantom_xz35-features_40new'}
%Omegas=[5,10,20,30,40,50,70,90]   
Omegas=[20,40]

%%
for d=1:1
    dataset=Tables(d)
    
    T=readtable(char(dataset));
    O=Omegas(d)
% 
% %Rotation matrix to translate between Arivis intr XYZ to the new 
% %intr Z'Y'X' which is (-Y Z X)
% %new system and angles are analogous to the airplane picture in the slides
% %psit is used because psi() is a matlab function
% %T is an imput table generated in PositionCorrelation.m 
syms xy xz yz phi theta psit xy2 xz2 yz2 omega


xy_grad=T.('AngleXY');
xz_grad=T.('AngleXZ');
yz_grad=T.('AngleYZ');

L1=length(xy_grad);
%new angle value array created
xy2=[0];
xz2=[0];
yz2=[0];

%%
%for loop through all the table rows
for i=1:L1
    %transformed into radians
    xy = xy_grad(i)*pi/180;
    yz = yz_grad(i)*pi/180;
    xz = xz_grad(i)*pi/180 %*sign(xy_grad(i)); %sign decoupled from YZ
    
%Test for Fantom 35

SystemB= Rz(xy2) * Ry(xz2) * Rx(yz2)
SystemA= Rz(xy) * Ry(xz) * Rx(yz)
%SystemB= SystemA *Ry(omega)
Ry(omega)*SystemA
%SystemA*Ry(omega)
% Ry(omega)
% inv(Ry(omega))
% SystemB*inv(Ry(omega))
omega=-O*pi/180

% %equations1 
%  xz2_all(i)=-asin(-cos(omega)*sin(xz) - cos(xz)*cos(yz)*sin(omega))
% % xy2= rad2deg(asin((sin(omega)*(cos(xy)*sin(yz) - cos(yz)*sin(xy)*sin(xz)) + cos(omega)*cos(xz)*sin(xy))/cos(deg2rad(xz2))))
%  xy2_all(i)= atan((sin(omega)*(cos(xy)*sin(yz) - cos(yz)*sin(xy)*sin(xz)) + cos(omega)*cos(xz)*sin(xy))/(cos(omega)*cos(xy)*cos(xz) - sin(omega)*(sin(xy)*sin(yz) + cos(xy)*cos(yz)*sin(xz))))
% % yz2= rad2deg(asin( cos(xz)*sin(yz)/cos(deg2rad(xz2))))
%  yz2_all(i)= atan((cos(xz)*sin(yz))/(cos(omega)*cos(xz)*cos(yz) - sin(omega)*sin(xz))) 

%equations2
 xz2_all(i)=-asin(- cos(omega)*sin(xz) - cos(xy)*cos(xz)*sin(omega));
 xy2_all(i)= atan((cos(xz)*sin(xy))/(cos(omega)*cos(xy)*cos(xz) - sin(omega)*sin(xz)));
 yz2_all(i)= atan((sin(omega)*(cos(yz)*sin(xy) - cos(xy)*sin(xz)*sin(yz)) + cos(omega)*cos(xz)*sin(yz))/(cos(omega)*cos(xz)*cos(yz) - sin(omega)*(sin(xy)*sin(yz) + cos(xy)*cos(yz)*sin(xz))));
    
    %equations2
    
%     theta_all(i)=rad2deg(abs(-asin(cos(xy)*sin(xz)*sin(yz) - cos(yz)*sin(xy))));
%     psi_all(i)=rad2deg(pi/2-sign(xy)*pi/2+atan2(sin(xy)*sin(yz) + cos(xy)*cos(yz)*sin(xz), cos(xy)*cos(xz)));
%     phi_all(i)=rad2deg(atan2(cos(xz)*sin(yz), cos(xy)*cos(yz) + sin(xy)*sin(xz)*sin(yz)));
    
    
    
%     %equations deduced from comparing rotation matrices above
%     phi_all(i) = rad2deg( yz) ;%have no idea if it is correct but screw it we dont need it
%     psi_all(i) = rad2deg(pi/2-sign(xy)*pi/2+atan2(-sin(xz), cos(xy)*cos(xz))) ;%-pi/2 to pi/2
%     theta_all(i) = rad2deg(abs(asin(cos(xz)*sin(xy)))) ;%0 to pi/2


 end

%Test for Fantom 45-30
%     R_orig_ZYX= Rz(xy) * Ry(xz) * Rx(yz)
% %     Rxyz= Rx(phi) *Ry(theta) *Rz(psit)
% %     R_needed_new_axis = Ry(-psit) * Rz(theta) * Rx(phi)
% %    R_new_XZY = Rx(phi) * Rz(theta) * Ry(psit);
%     R_new_XYZ = Rx(yz2) * Ry(xz2) * Rz(xy2)
% 
% xy=-49.077784*pi/180
% xz=20.690111*pi/180
% yz=44.758613*pi/180
% 
% 
%     xz2=rad2deg(asin(sin(xy)*sin(yz) + cos(xy)*cos(yz)*sin(xz)))
%     yz2=rad2deg(asin(cos(yz)*sin(xy)*sin(xz) - cos(xy)*sin(yz)/-cos(xz2)))
%     xy2=rad2deg(asin(cos(xy)*sin(xz)*sin(yz) - cos(yz)*sin(xy)/-cos(xz2)))


%%
%add new columns to the table
T.xy2=rad2deg(xy2_all');
T.xz2=rad2deg(xz2_all');
T.yz2=rad2deg(yz2_all');


%%
%statistics
xy2mean=rad2deg(circ_mean(xy2_all'))
[sr sr0] = circ_std(xy2_all');
stdeva_xy2=sr
xz2mean=rad2deg(circ_mean(xz2_all'))
[sr sr0] = circ_std(xz2_all');
stdeva_xz2=sr
yz2mean=rad2deg(circ_mean(yz2_all'))
[sr sr0] = circ_std(yz2_all');
stdeva_yz2=sr
% 

%%
%write excel
Tstat= table(xy2mean,stdeva_xy2,xz2mean,stdeva_xz2,yz2mean,stdeva_yz2)

dataset
ending='_angles.xlsx'
newfile = strcat(dataset,ending)
% filename = {dataset(1:end-5),'_angles.xlsx'};
writetable(T,char(newfile), 'Sheet', 1);
writetable(Tstat,char(newfile), 'Sheet', 2);

%outputFilename = fullfile(fp,[dataset(1:end-5),'_angles.xlsx']);

end
