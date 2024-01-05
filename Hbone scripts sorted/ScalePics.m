function [ OutputT ] = ScalePics( InputT,row)
%Reads the given row of the table with dimensions  
%and returns the table of scaling parameters

format longG

row
InputT=InputT(row,:)

Vol= InputT.('Vol');
R_w= InputT.('R_w');
R_h= InputT.('R_h');
scale_nm = InputT.('scale_nm');
scale_px = InputT.('scale_px');
nCT_w = InputT.('nCT_w');
nCT_h = InputT.('nCT_h');
R_px= InputT.('R_px');
nCT_px=16.09;

k=R_px/nCT_px; %scaling coefficient
R_w_k=round(R_w*k); %scaled image dimensions
R_h_k=round(R_h*k);
kcorrw=R_w_k/R_w; %k corrected for discrete px size
kcorrh=R_h_k/R_h;

OutputT=table(Vol,k,R_w_k,R_h_k,kcorrw,kcorrh);

end

