clear
format longG;

%write back EV1 
%solve code for empty match case
%fix Anlges in FindSegmentsIL

%read Raman point coordinates in nano-CT notation
g_P=readtable('nCT_coordinates1.xlsx', 'Sheet',3);%lookup green dataset sheetnum
%%
%Arivis axis parameters Dataset 1
g_xstart=0;
g_zstart=994;
g_ysurface=(194+170)/2;

%read segments Interlamellar
fp ='D:\Programs\MATLAB\MATLAB Hbone\Hbone scripts sorted';
fns = {'green_interlam_Y-45_features_LV2_BadAngles_translated.xlsx', 'green_interlam_Y-45_features_LV3_BadAngles_translated.xlsx'};
for ii = 1:size(fns,2)
    cfn=fns{ii}
    S = readtable(cfn);
    
%     f1=figure
%     L=length(S.ID)
%     for i=1:L
%         plot3([S.x1_ARs(i), S.x2_ARs(i)], [S.y1_ARs(i),S.y2_ARs(i)], [S.z1_ARs(i),S.z2_ARs(i)])
%         i=i+1
%         hold on
%     end
%     i=0

%%
    g_Sini=S
    [Sgreen, gcount, Ag]= FindSegmentsIL(g_P, g_Sini, g_xstart, g_zstart, g_ysurface, 47.9, -800,1000,-600, 1400, 400, 800)
%     filename = '1match_green_interlam_EV1.xlsx';
%     writetable(Ag,filename);
    
    
if Ag ~= 0
    outputFilename = fullfile(fp,[cfn(1:end-15),'_matched.xlsx']); 
    writetable(Ag, outputFilename);
end


end