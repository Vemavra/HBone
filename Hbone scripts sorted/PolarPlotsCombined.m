function []=PolarPlotsCombined(DS1, omega1, color1, DS2, omega2, color2, DS3, omega3, color3)

DS1.ip_psi=+180-DS1.ip_psi-omega1;
DS1.ip_psi2=180-DS1.ip_psi2 - omega1;
DS1.psi_mean=180-DS1.psi_mean - omega1

DS2.ip_psi=180-DS2.ip_psi - omega2;
DS2.ip_psi2=180-DS2.ip_psi2 - omega2;
DS2.psi_mean=180-DS2.psi_mean - omega2

if exist('DS3') 
    DS3.ip_psi=180-DS3.ip_psi - omega3;
    DS3.ip_psi2=180-DS3.ip_psi2 - omega3;
    DS3.psi_mean=180-DS3.psi_mean - omega3
end

DSpoints=unique([DS1.nump'  DS2.nump'])

%Psi loop
for i=DSpoints
    Titlepsi=sprintf('Psi %d ', i)
    f1=figure('Name',Titlepsi,'visible','off')
    f1.Position(3:4) = [150 150];
    for j=1:length(DS1.nump)
        if DS1.nump(j)==i
            Rp=[0 deg2rad(DS1.ip_psi(j))];
            str = '#FF0066';
            colorr = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
            polarplot( Rp,[0 1.5], 'Linewidth', 4, 'Color', colorr);
            ax=gca;
            ax.RTickLabel={''};
            ax.ThetaLim= [-180 180];
            ax.ThetaDir='clockwise';
            hold on
            Rp2=[0 deg2rad(DS1.ip_psi2(j))];
            str = '#FF6699';
            colorr = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
            polarplot( Rp2,[0 1.5], 'Linewidth', 4, 'Color', colorr);
            hold on
            Av=[0 deg2rad(DS1.psi_mean(j))];
            colorr = color1
            polarplot( Av,[0 1.5], 'Linewidth', 5, 'Color', colorr)
            hold on
        end
        
    end
    
    for j=1:length(DS2.nump)
        if DS2.nump(j)==i
            Rp=[0 deg2rad(DS2.ip_psi(j))];
            str = '#FF0066';
            colorr = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
            polarplot( Rp,[0 1.5], 'Linewidth', 4, 'Color', colorr);
            ax=gca;
            ax.RTickLabel={''};
            ax.ThetaLim= [-180 180];
            ax.ThetaDir='clockwise';
            hold on
            Rp2=[0 deg2rad(DS2.ip_psi2(j))];
            str = '#FF6699';
            colorr = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
            polarplot( Rp2,[0 1.5], 'Linewidth', 4, 'Color', colorr);
            hold on
            Av=[0 deg2rad(DS2.psi_mean(j))];
            colorr = color2
            polarplot( Av,[0 1.5], 'Linewidth', 4, 'Color', colorr);   
        end
    end
   
    if exist('DS3')
        for j=1:length(DS3.nump)
            if DS3.nump(j)==i
                Rp=[0 deg2rad(DS3.ip_psi(j))];
                str = '#FF0066';
                colorr = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
                polarplot( Rp,[0 1.5], 'Linewidth', 4, 'Color', colorr);
                ax=gca;
                ax.RTickLabel={''};
                ax.ThetaLim= [-180 180];
                ax.ThetaDir='clockwise';
                hold on
                Rp2=[0 deg2rad(DS3.ip_psi2(j))];
                str = '#FF6699';
                colorr = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
                polarplot( Rp2,[0 1.5], 'Linewidth', 4, 'Color', colorr);
                hold on
                Av=[0 deg2rad(DS3.psi_mean(j))];
                colorr = color3
                polarplot( Av,[0 1.5], 'Linewidth', 4, 'Color', colorr);
            end
        end
    end
end

%Theta loop
for i=DSpoints
    Titletheta=sprintf('Theta %d ', i)
    f2=figure('Name',Titletheta,'visible','off')
    f2.Position(3:4) = [150 150];
    for j=1:length(DS1.nump)
        if DS1.nump(j)==i
            Rp=[0 deg2rad(DS1.op_theta(j))];
            str = '#FF6600';
            colorr = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
            polarplot( Rp,[0 1.5], 'Linewidth', 4, 'Color', colorr);
            ax=gca;
            ax.RTickLabel={''};
            ax.ThetaLim= [-180 180];
            ax.ThetaDir='clockwise';
            hold on
            Av=[0 deg2rad(DS1.theta_mean(j))];
            colorr = color1
            polarplot( Av,[0 1.5], 'Linewidth', 5, 'Color', colorr)
            hold on
        end
        
    end
    
    for j=1:length(DS2.nump)
        if DS2.nump(j)==i
            Rp=[0 deg2rad(DS2.op_theta(j))];
            str = '#FF6600';
            colorr = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
            polarplot( Rp,[0 1.5], 'Linewidth', 4, 'Color', colorr);
            ax=gca;
            ax.RTickLabel={''};
            ax.ThetaLim= [-180 180];
            ax.ThetaDir='clockwise';
            hold on
            Av=[0 deg2rad(DS2.theta_mean(j))];
            colorr = color2
            polarplot( Av,[0 1.5], 'Linewidth', 4, 'Color', colorr);
        end
    end
    
    if exist('DS3')
        for j=1:length(DS3.nump)
            if DS3.nump(j)==i
                Rp=[0 deg2rad(DS3.op_theta(j))];
                str = '#FF6600';
                colorr = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
                polarplot( Rp,[0 1.5], 'Linewidth', 4, 'Color', colorr);
                ax=gca;
                ax.RTickLabel={''};
                ax.ThetaLim= [-180 180];
                ax.ThetaDir='clockwise';
                hold on
                Av=[0 deg2rad(DS3.theta_mean(j))];
                colorr = color3
                polarplot( Av,[0 1.5], 'Linewidth', 4, 'Color', colorr);
            end
        end
    end

end
end
            

