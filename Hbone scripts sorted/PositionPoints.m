clear
format longG;

% %Cyan
% %read Raman point coordinates in nano-CT notation
% c_P=readtable('nCT_coordinates1.xlsx', 'Sheet',1)
% %Arivis axis parameters
% c_xstart=505;
% c_zstart=960;
% c_ysurface=(377+399)/2 %pillar surface position
% %read segments
% c_Sini=readtable('features-cyan.xlsx')
% 
% %function to find matching segments
% [Scyan, ccount, Ac]= FindSegments(c_P, c_Sini, c_xstart, c_zstart, c_ysurface,47.9, 0, 1800, -600, 1400, 400, 800)
% filename = '1match_cyan.xlsx';
% writetable(Ac,filename)

% % function to export qPRS point positions in segmented dataset
% [Gcyan]= Boxpoints(c_P, c_xstart, c_zstart, c_ysurface)
% filename = 'qPRS_box_cyan.xlsx';
% writetable(Gcyan,filename)
% 
%Indigo1
% % i_P=readtable('nCT_coordinates1.xlsx', 'Sheet',2)
% i_P=readtable('nCT_coordinates1_indigo1.xlsx')
% i_xstart=967;
% i_zstart=982;
% i_ysurface=(462+445)/2;
% % i_Sini=readtable('features-indigo1.xlsx')
% % 
% % [Sindigo, icount, Ai]= FindSegments(i_P, i_Sini, i_xstart, i_zstart, i_ysurface, 47.9, 200, 2000, -800, 1200, 400, 800)
% % filename = '1match_indigo.xlsx';
% % writetable(Ai,filename)
% 
% %function to export qPRS point positions in segmented dataset
% [Gindigo1]= Boxpoints(i_P, i_xstart, i_zstart, i_ysurface)
% filename = 'qPRS_box_indigo1.xlsx';
% writetable(Gindigo1,filename)
% % 
% %Indigo2
% i2_P=readtable('nCT_coordinates1_indigo2.xlsx')
% i2_xstart=0
% i2_zstart=994
% i2_ysurface=(280+260)/2
% i2_Sini=readtable('features-indigo2 sparse.xlsx')

% [Sindigo2, icount2, Ai2]= FindSegments(i2_P, i2_Sini, i2_xstart, i2_zstart, i2_ysurface, 45.7, -800, 1000, -600, 1400, 400, 800)
% filename = '1match_indigo2.xlsx';
% writetable(Ai2,filename)

%function to export qPRS point positions in segmented dataset
% [Gindigo2]= Boxpoints(i2_P, i2_xstart, i2_zstart, i2_ysurface)
% filename = 'qPRS_box_indigo2.xlsx';
% writetable(Gindigo2,filename)
 
%Green1
g_P=readtable('nCT_coordinates1.xlsx', 'Sheet',3);
g_xstart=0;
g_zstart=994;
g_ysurface=(194+170)/2;
g_Sini=readtable('features-green1.xlsx')

% [Ggreen1]= RecordPoints(g_P, g_xstart, g_zstart, g_ysurface)
% filename = 'final_qPRS_positions_green.xlsx';
% writetable(Ggreen1,filename);

%function to export qPRS point positions in segmented dataset
[Ggreen1]= Boxpoints(g_P, g_xstart, g_zstart, g_ysurface)
filename = 'qPRS_pointcoord_green1.xlsx';
writetable(Ggreen1,filename)
% % 
% %Green2
% g2_P=readtable('nCT_coordinates1.xlsx', 'Sheet',6);
% g2_xstart=0;
% g2_zstart=942;
% g2_ysurface=(446+478)/2;
% g2_Sini=readtable('features-green2.xlsx');
% 
% [Sgreen2, gcount2, Ag2]= FindSegments(g2_P, g2_Sini, g2_xstart, g2_zstart, g2_ysurface, 45.7, -800,1000,-600, 1400, 400, 800)
% filename = '1match_green2.xlsx';
% writetable(Ag2,filename);
% % 
% % %Green1_-70
% g3_P=readtable('nCT_coordinates1.xlsx', 'Sheet',8);
% g3_xstart=-140
% g3_zstart=1274
% g3_ysurface=(173+195)/2
% g3_Sini=readtable('features-green3.xlsx')
% 
% [Sgreen3, gcount3, Ag3]= FindSegments(g3_P, g3_Sini, g3_xstart, g3_zstart, g3_ysurface, 117.9, -500,1300,-800, 1200, 400, 800)
% filename = '1match_green3.xlsx';
% writetable(Ag3,filename);
% % 
% %Red
% r_P=readtable('nCT_coordinates1.xlsx', 'Sheet',4)
% r_xstart=-186
% r_zstart=1395
% r_ysurface=(314+307)/2
% r_Sini=readtable('features-red.xlsx')
% 
% [Sred, rcount, Ar]= FindSegments(r_P, r_Sini, r_xstart, r_zstart, r_ysurface, 50, -500,1300,-200, 1800, 300, 900)
% filename = '1match_red.xlsx';
% writetable(Ar,filename);

% %function to export qPRS point positions in segmented dataset
% [Gred]= Boxpoints(r_P, r_xstart, r_zstart, r_ysurface)
% filename = 'qPRS_box_red.xlsx';
% writetable(Gred,filename)

% %Magenta
% m_P=readtable('nCT_coordinates.xlsx', 'Sheet',7)
% %Arivis axis parameters
% m_xstart=-174;
% m_zstart=1191;
% m_ysurface=(137+113)/2 %pillar surface position
% %read segments
% m_Sini=readtable('features-magenta.xlsx')
% 
% %function to find matching segments
% [Smagenta, mcount, Am]= FindSegments(m_P, m_Sini, m_xstart, m_zstart, m_ysurface, 145.2, -300, 900, -100, 1100, 400, 800)
% filename = '1match_magenta.xlsx';
% writetable(Am,filename)


% %Apply rotation matrix
% Tc=readtable('match_cyan.xlsx');
% [ Fc ] = RotMatangle( Tc )
% filename = 'angles_cyan.xlsx';
% writetable(Fc,filename);
% 
% Ti=readtable('match_indigo.xlsx');
% [ Fi ] = RotMatangle( Ti )
% filename = 'angles_indigo.xlsx';
% writetable(Fi,filename);
% 
% Tg=readtable('match_green.xlsx');
% [ Fg ] = RotMatangle( Tg )
% filename = 'angles_green.xlsx';
% writetable(Fg,filename);
% 
% Tr=readtable('match_red.xlsx');
% [ Fr ] = RotMatangle( Tr )
% filename = 'angles_red.xlsx';
% writetable(Fr,filename);
  