function y=norm_mtx1(x,len,n)
m=floor(len/n);
x1 = reshape([x(:);zeros(mod(-numel(x),m),1)],m,[])';
B=0;
for i=1:n
    for k=1:n
        B(i,k)=calc1(i,k,x1,m);
    end
end

y=B;