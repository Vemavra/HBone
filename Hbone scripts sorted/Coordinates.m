format longG

%calculate scaling parameters
InputT = readtable('Picture_parameters.xlsx')
row=8 %choose dataset

[ OutputT ] = ScalePics( InputT, row ); %call ScalePics.m

filename = 'Scaling_parameters.xlsx';
writetable(OutputT,filename,'Sheet',row);

kcorrw = OutputT.('kcorrw')
kcorrh = OutputT.('kcorrh')

% %Read Raman point data
% P1=readtable('nCT3_combined_output_data.xlsx','Sheet',4,'Range', 'A1:H26');
% P2=readtable('nCT3_combined_output_data.xlsx','Sheet',2,'Range', 'A1:H26');
% P3=readtable('nCT3_combined_output_data.xlsx','Sheet',3,'Range', 'A1:H26');
% P4=readtable('nCT3_combined_output_data.xlsx','Sheet',1,'Range', 'A1:H26');
% P5=readtable('nCT1p2_combined_output_data.xlsx','Sheet',1,'Range','A1:H82');
% 
%Read Raman point data
P1=readtable('nCT3_combined_output_data_no_empty_cells.xlsx','Sheet',4);
P2=readtable('nCT3_combined_output_data_no_empty_cells.xlsx','Sheet',2);
P3=readtable('nCT3_combined_output_data_no_empty_cells.xlsx','Sheet',3);
P4=readtable('nCT3_combined_output_data_no_empty_cells.xlsx','Sheet',1);
P5=readtable('nCT1p2_combined_output_data_no_empty_cells.xlsx','Sheet',1)

% %Translate coordinates
% [ T1 ] = nCTPoints( P1, kcorrw, kcorrh, 1 ) %cyan
% [ T2 ] = nCTPoints( P2, kcorrw, kcorrh, 2 ) %indigo1
% [ T3 ] = nCTPoints( P3, kcorrw, kcorrh, 3 ) %green1
% [ T4 ] = nCTPoints( P4, kcorrw, kcorrh, 4 ) %red
% [ T5 ] = nCTPoints( P2, kcorrw, kcorrh, 5 ) %indigo2
% [ T6 ] = nCTPoints( P3, kcorrw, kcorrh, 6 ) %green2
[ T7 ] = nCTPoints( P5, kcorrw, kcorrh, 7 ) %magenta
% [ T8 ] = nCTPoints( P3, kcorrw, kcorrh, 8 ) %green3