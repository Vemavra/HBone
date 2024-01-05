function [ T1, Tstat ] = RotMatangle( T, omega, Folder )
%Rotation matrix to translate between Arivis intr XYZ to the new 
%intr Z'Y'X' which is (-Y Z X)
%new system and angles are analogous to the airplane picture in the slides
%psit is used because psi() is a matlab function
%T is an imput table generated in PositionCorrelation.m 
syms xy xz yz phi theta psit

% transform qPRS angles

T.outofplanepitch=90-T.('outofplane');
T.inplaneomega=180-T.('inplane')-omega
T.inplaneomega2=-T.('inplane')-omega
% T.inplaneomega=90-(T.('inplane')+omega);
% T.inplaneomega2=180+90-T.('inplane')-omega;

xy_grad=T.('angleXY');
xz_grad=T.('angleXZ');
yz_grad=T.('angleYZ');

L1=length(T.ID);
%new angle value array created
phi_all=[0];
theta_all=[0];
psi_all=[0];

%for loop through all the table rows
for i=1:L1
    %transformed into radians
    xy = xy_grad(i)*pi/180;
    yz = yz_grad(i)*pi/180;
    xz = xz_grad(i)*pi/180 %*sign(xy_grad(i)); %sign decoupled from YZ
    
    
    %Rotation matrices, can call separately to analyse, Rx Ry Rz are
    %matrix functions
    R_orig_ZYX= Rz(xy) * Ry(xz) * Rx(yz);
%     Rxyz= Rx(phi) *Ry(theta) *Rz(psit)
%     R_needed_new_axis = Ry(-psit) * Rz(theta) * Rx(phi)
    R_new_XZY = Rx(phi) * Rz(theta) * Ry(psit);
    
    %equations2
    
    theta_all(i)=rad2deg(abs(-asin(cos(xy)*sin(xz)*sin(yz) - cos(yz)*sin(xy))));
    psi_all(i)=rad2deg(pi/2-sign(xy)*pi/2+atan2(sin(xy)*sin(yz) + cos(xy)*cos(yz)*sin(xz), cos(xy)*cos(xz)));
    phi_all(i)=rad2deg(atan2(cos(xz)*sin(yz), cos(xy)*cos(yz) + sin(xy)*sin(xz)*sin(yz)));
    
    
    
%     %equations deduced from comparing rotation matrices above
%     phi_all(i) = rad2deg( yz) ;%have no idea if it is correct but screw it we dont need it
%     psi_all(i) = rad2deg(pi/2-sign(xy)*pi/2+atan2(-sin(xz), cos(xy)*cos(xz))) ;%-pi/2 to pi/2
%     theta_all(i) = rad2deg(abs(asin(cos(xz)*sin(xy)))) ;%0 to pi/2


end

%add new columns to the table
T.psi=psi_all';
T.theta=theta_all';
T.phi=phi_all';
T1=T;

psimean_all=[];
stdeva_psi_all=[];
thetamean_all=[];
stdeva_theta_all=[];
ncount=[];
qPRS_psi=[];
qPRS_psi2=[];
qPRS_theta=[];

qprs_orig_ip=[];


c=unique(T.point);
for i=c'
    m=0
    for j=1:length(T.ID)
        m=m+1
        if m>1 && T.point(j)==T.point(j-1)
            T.point(j)
            T.point(j-1)
            continue
        end
        if T.point(j)==i
            angle=[];
            n=0
            Titlepsi=sprintf('Psi %d ', i);
            f1=figure('Name',Titlepsi,'visible','off');
            f1.Position(3:4) = [150 150];
            Rp=[0 deg2rad(T.inplaneomega(j))];
            polarplot( Rp,[0 1.5], 'Linewidth', 5, 'Color', 'r');
            ax=gca;
            ax.RTickLabel={''};
            ax.ThetaLim= [-180 180];
            ax.ThetaDir='clockwise';
            hold on
            Rp2=[0 deg2rad(T.inplaneomega2(j))];
            str = '#FF7C80';
            colorr = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
            polarplot( Rp2,[0 1.5], 'Linewidth', 5, 'Color', colorr);
            for k=1:length(T.ID)

                if T.point(k)==i
                    n=n+1
                    ncount(i)=n
                    qPRS_psi(i)=T.inplaneomega(k);
                    qPRS_psi2(i)=T.inplaneomega2(k);
                    qprs_orig_ip(i)=T.inplane(k);
                    angle(n)=deg2rad(T.psi(k));
                    hold on;
                    q=[0 deg2rad(T.psi(k))];
                    polarplot(q ,[0 1], 'Linewidth', 4, 'Color',[0 0 0]+0.5 )
                else
                    disp('not eq')
                end

           
            end
        end
    end
    
     
    nz_ncount=nonzeros(ncount)
    psimean=circ_mean(angle')
    [sr sr0] = circ_std(angle');
    psimean_all(i)=rad2deg(psimean);
    stdeva_psi_all(i)=sr;
    Av=[0 psimean];
    polarplot(Av ,[0 1.5], 'Linewidth', 4, 'Color', [0.4940 0.1840 0.5560])

    hold off
end

for i=c'
    m=0;
    for j=1:length(T.ID)
        m=m+1
        if m>1 && T.point(j)==T.point(j-1)
            T.point(j)
            T.point(j-1)
            continue
        end
        if T.point(j)==i    
            angle=0;
            n=0;    
            Titletheta=sprintf('Theta %d ', i);    
            f2=figure('Name',Titletheta,'visible','off');    
            f2.Position(3:4) = [150 150];    
            Rp=[0 deg2rad(T.outofplanepitch(j))];
            polarplot( Rp,[0 1.5], 'Linewidth', 5, 'Color', [0 0.8004 0])
            ax=gca;    
            ax.RTickLabel={''};    
            ax.ThetaLim= [-180 180];
            ax.ThetaDir='clockwise';

            for k=1:length(T.ID)
                if T.point(k)==i
                    n=n+1;
                    qPRS_theta(i)= T.outofplanepitch(k);
                    angle(n)=deg2rad(T.theta(k));
                    hold on
                    q=[0 deg2rad(T.theta(k))];
                    polarplot(q ,[0 1], 'Linewidth', 4, 'Color',[0 0 0]+0.5 )
                end
                
            end
        end
    end
    angle
    thetamean=circ_mean(angle');
    [sb sb0] = circ_std(angle')
    thetamean_all(i)=rad2deg(thetamean);
    stdeva_theta_all(i)=sb;
    Avb=[0 thetamean];
    polarplot(Avb ,[0 1.5], 'Linewidth', 4, 'Color', [0 0.4470 0.7410])
    hold off
end

% % %Save figures
SaveAllFigures (Folder)

%delete zero rows
nump=unique(T.point);
psi_stat=[psimean_all' stdeva_psi_all'];
psi_stat(~any(psi_stat'),:) = []

theta_stat=[thetamean_all' stdeva_theta_all'];
theta_stat(~any(theta_stat'),:) = []

qprs_data=[qPRS_psi' qPRS_psi2' qPRS_theta' qprs_orig_ip'];
qprs_data(~any(qprs_data'),:) = []

psi_mean=psi_stat(:,1);
psi_std=psi_stat(:,2);
theta_mean=theta_stat(:,1);
theta_std=theta_stat(:,2);

ip_psi=qprs_data(:,1);
ip_psi2=qprs_data(:,2);
op_theta=qprs_data(:,3);
orig_ip=qprs_data(:,4)

Tstat= table(nump,orig_ip, ip_psi, ip_psi2, op_theta, psi_mean, psi_std, theta_mean , theta_std, nz_ncount)
close all hidden

end

