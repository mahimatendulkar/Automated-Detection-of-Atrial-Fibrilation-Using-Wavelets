function y=calc1(i,k,x1,m)
Bd=zeros(((2*m)-1),1);

for tau0=-(m-1):1:(m-1)
 for j=1:m
   if ((j+tau0)>0) && ((j+tau0)<(m+1))
       
    Bd(tau0+m,1)=Bd(tau0+m,1)+(x1(i,j).*x1(k,(j+tau0)));
   else
     Bd(tau0+m,1)=Bd(tau0+m,1);
     
   end
 end
Bd(tau0+m,1)=Bd(tau0+m,1)*(1/m);
end

Bbar=0;
for tau0=1:(2*m-1)
 Bbar=Bbar+Bd(tau0,1);
end
Bbar=(1/((2*m)-1))*Bbar;
y=Bbar;