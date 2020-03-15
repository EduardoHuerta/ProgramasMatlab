x=0:500;
T=sin(x/30)+sin(x/40)+sin(x/21);
T=T.*100;
plot(x,T)
xlabel('eje X') 
ylabel('Temperatura')
for k=2:5000
%     temp=zeros(1,501);
    T(k,:)=conv(T(k-1,:),[1/3 1/3 1/3],'same');
%     T(k,:)=T(k-1,:)-temp;
end
% T(1:50,450:end)=[];
figure
mesh(T)
xlabel('eje X') 
ylabel('tiempo')
zlabel('Temperatura')