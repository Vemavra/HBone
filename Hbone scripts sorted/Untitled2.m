clear
format longG
P=readtable('nCT_coordinates.xlsx')
Pn=P.('Point');
xnCT=P.('xnCT');
ynCT=P.('ynCT');
P1=table(Pn,xnCT,ynCT)


L=length(P1.Pn)
P1(8,:)
xnCT(10)
k=1
klog=[0]
Dist=[0]
  for i=1:L
      if (xnCT(i)>0 && xnCT(i)<972)
          if (ynCT(i)>0 && ynCT(i)<960)
          S(k,1:3)=P1(i,1:3)
        
          klog(k)=k
          S.k=klog'
          Dist(k)=972-xnCT(i)
          S.Dist=Dist'
          k=k+1
          else
          end
          
      else
      end
  end
        