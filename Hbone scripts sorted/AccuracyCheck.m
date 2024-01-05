clear
format longG;

% %Indigo data
I1=readtable('angles_indigo.xlsx', 'Sheet', 2)
omegaI1=47.9;
I2=readtable('angles_indigo2.xlsx', 'Sheet', 2)
omegaI2=45.7;
FolderI=fullfile(pwd, '\Accuracy_indigo');
%colors
str = '#0000CC';
colorI1 = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#0066FF';
colorI2 = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
%function
PolarPlotsCombined(I1, omegaI1, colorI1, I2, omegaI2, colorI2)

SaveAllFigures (FolderI)
close all hidden

% %Green data
G1=readtable('angles_green.xlsx', 'Sheet', 2)
omegaG1=47.9;
G2=readtable('angles_green2.xlsx', 'Sheet', 2)
omegaG2=45.7;
G3=readtable('angles_green3.xlsx', 'Sheet', 2)
omegaG3=117.9;
FolderG=fullfile(pwd, '\Accuracy_green');
%colors
str = '#005800';
colorG1 = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#01852D';
colorG2 = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#00B050';
colorG3 = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;

PolarPlotsCombined(G1, omegaG1, colorG1, G2, omegaG2, colorG2, G3, omegaG3, colorG3)

SaveAllFigures (FolderG)

