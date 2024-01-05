%average

T=readtable('match_indigo.xlsx')
T.point=categorical(T.point)

for i=1:length(T.point)
    rows = T.point== char(i)
    T1=T(rows)
    angleXY=mean(T1.angleXY)