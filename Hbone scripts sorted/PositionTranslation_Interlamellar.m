clear
format longG;

%read segments Interlamellar
fp ='D:\Programs\MATLAB\MATLAB Hbone\Hbone scripts sorted';
fns = {'green_interlam_Y-45_features_EV1.xlsx','green_interlam_Y-45_features_EV2.xlsx','green_interlam_Y-45_features_LV1.xlsx', 'green_interlam_Y-45_features_LV2.xlsx', 'green_interlam_Y-45_features_LV3.xlsx'};
for ii = 1:size(fns,2)
    cfn=fns{ii}
    interlam = readtable(cfn);

    ID = interlam.('Id');
    x1_ARs = interlam.('X1_BoundingBox_Pixel_');
    x2_ARs = interlam.('X2_BoundingBox_Pixel_');
    z1_ARs = interlam.('Z1_BoundingBox_Pixel_');
    z2_ARs = interlam.('Z2_BoundingBox_Pixel_');
    y1_ARs = interlam.('Y1_BoundingBox_Pixel_');
    y2_ARs = interlam.('Y2_BoundingBox_Pixel_');


    S=table(ID, y1_ARs, y2_ARs, x1_ARs, x2_ARs, z1_ARs, z2_ARs);
    %function to translate segments coordinates interlamellar

    % f1=figure
    % L=length(S.ID)
    % for i=1:L
    %     plot3([S.x1_ARs(i), S.x2_ARs(i)], [S.y1_ARs(i),S.y2_ARs(i)], [S.z1_ARs(i),S.z2_ARs(i)])
    %     i=i+1
    %     hold on
    % end
    % i=0
    %%
    L=length(S.ID)
    for i=1:L
        x3=S.x1_ARs(i);
        y3=S.y1_ARs(i);
        z3=S.z1_ARs(i);
        A3=[x3;y3;z3];
        [A31,A31check]=PointRot31(A3);
        S.x1_ARs(i)=A31(1);
        S.y1_ARs(i)=A31(2);
        S.z1_ARs(i)=A31(3);

        x3=S.x2_ARs(i);
        y3=S.y2_ARs(i);
        z3=S.z2_ARs(i);
        A3=[x3;y3;z3];
        [A31,A31check]=PointRot31(A3);
        S.x2_ARs(i)=A31(1);
        S.y2_ARs(i)=A31(2);
        S.z2_ARs(i)=A31(3);
        i=i+1
    end
    i=0;   
    Snew=S;    

    f2=figure
    L=length(S.ID)
    for i=1:L
        plot3([S.x1_ARs(i), S.x2_ARs(i)], [S.y1_ARs(i),S.y2_ARs(i)], [S.z1_ARs(i),S.z2_ARs(i)])
        i=i+1
        hold on
    end
    i=0



    %%

    Snew.x_ARs= abs(Snew.x2_ARs-Snew.x1_ARs);
    Snew.y_ARs= abs(Snew.y2_ARs-Snew.y1_ARs);
    Snew.z_ARs= abs(Snew.z2_ARs-Snew.z1_ARs);
    Snew.angleXY= interlam.('AngleXY_3DOrientedBounds');
    Snew.angleXZ= interlam.('AngleXZ_3DOrientedBounds');
    Snew.angleYZ= interlam.('AngleYZ_3DOrientedBounds');
    
    g_Sini=Snew;

    outputFilename = fullfile(fp,[cfn(1:end-5),'_BadAngles_translated.xlsx']); 
    writetable(Snew, outputFilename);
%     [Sgreen, gcount, Ag]= FindSegmentsIL(g_P, g_Sini, g_xstart, g_zstart, g_ysurface, 47.9, -800,1000,-600, 1400, 400, 800)
%     filename = '1match_green_interlam_EV1.xlsx';
%     writetable(Ag,filename);
    

    
end
