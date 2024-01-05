clear
format longG;

% %Apply rotation matrix
% Tc=readtable('1match_cyan.xlsx');
% Folderc = fullfile(pwd, '\Angles_cyan');
% [ Fc, Fc_stat ] = RotMatangle( Tc, 47.9, Folderc )
% filename = 'angles_cyan.xlsx';
% writetable(Fc,filename);
% writetable(Fc_stat,filename, 'Sheet', 2);
% % % 
% Ti=readtable('1match_indigo.xlsx');
% Folderi = fullfile(pwd, '\Angles_indigo');
% [ Fi, Fi_stat ] = RotMatangle( Ti,47.9, Folderi )
% filename = 'angles_indigo.xlsx';
% writetable(Fi,filename);
% writetable(Fi_stat,filename, 'Sheet', 2);
% % 
% Ti2=readtable('1match_indigo2.xlsx');
% Folderi2 = fullfile(pwd, '\Angles_indigo2');
% [ Fi2, Fi2_stat ] = RotMatangle( Ti2,45.7, Folderi2)
% filename = 'angles_indigo2.xlsx';
% writetable(Fi2,filename);
% writetable(Fi2_stat,filename, 'Sheet', 2);
% % 
% Tg=readtable('1match_green.xlsx');
% Folderg = fullfile(pwd, '\Angles_green');
% [ Fg, Fg_stat ] = RotMatangle( Tg, 47.9, Folderg)
% filename = 'angles_green.xlsx';
% writetable(Fg,filename);
% writetable(Fg_stat,filename, 'Sheet', 2);
% % 
% Tg2=readtable('1match_green2.xlsx');
% Folderg2 = fullfile(pwd, '\Angles_green2');
% [ Fg2, Fg2_stat ] = RotMatangle( Tg2, 45.7 , Folderg2)
% filename = 'angles_green2.xlsx';
% writetable(Fg2,filename);
% writetable(Fg2_stat,filename, 'Sheet', 2);
% % 
% Tg3=readtable('1match_green3.xlsx');
% Folderg3 = fullfile(pwd, '\Angles_green3');
% [ Fg3, Fg3_stat ] = RotMatangle( Tg3, 117.9, Folderg3 )
% filename = 'angles_green3.xlsx';
% writetable(Fg3,filename);
% writetable(Fg3_stat,filename, 'Sheet', 2);
% % 
Tr=readtable('1match_red.xlsx');
Folderr = fullfile(pwd, '\Angles_red');
[ Fr, Fr_stat ] = RotMatangle( Tr, 50, Folderr )
filename = 'angles_red.xlsx';
writetable(Fr,filename);
writetable(Fr_stat,filename, 'Sheet', 2);
% % 
% Tm=readtable('2match_magenta.xlsx');
% Folderm = fullfile(pwd, '\Angles_magenta');
% [ Fm, Fm_stat ] = RotMatangle( Tm, 145.2, Folderm )
% filename = 'angles_magenta.xlsx';
% writetable(Fm,filename);
% writetable(Fm_stat,filename, 'Sheet', 2);

