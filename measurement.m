clear; close all; clc;
W=0.02*pi;
X0=[5;0];
C=[1,0];
Q=0.01*eye(2,2);
R=1;
Y=zeros(1,501);
XR=zeros(2,501);
A=[cos(W),-sin(W);sin(W),cos(W)];
X=X0;
tau=0;
for T=0:500
    w=normrnd(0,0.1,2,1);
    XR(:,T+1)=A*X;
    X=XR(:,T+1)+w;
    v=normrnd(0,1);
    y=C*X+v;
    Y(T+1)=y*(y>0);
end
T=0:500;

[x,r]=SKF(X0,Y,A,C,Q,R);
% plot(r);
% hold on;
[xe,re]=EKF(X0,Y,A,C,Q,R,tau);
% plot(re);
% hold on;
[xt,rt]=TKF(X0,Y,A,C,Q,R,tau);
% plot(rt);
% hold on;
[xte,rte]=TEKF(X0,Y,A,C,Q,R,tau);
% plot(rte);
% legend('measurement','SKF','EKF','TKF','TEKF');
figure()
subplot(3,1,3);
scatter(T,Y,'.','k')
hold on
% plot(T,r,'m','Linewidth',2);
% hold on;
% plot(T,re,'g','Linewidth',2);
% hold on;
% plot(T,rt,'b','Linewidth',2);
% hold on;
% plot(T,rte,'r','Linewidth',2);
% hold on;
% legend('y','SKF','EKF','TKF','TEKF');
% title('Measurement and Filted Results');
legend('y');
% title('Measurement');

subplot(3,1,1)
plot(T,XR(1,:),'k','Linewidth',2);
hold on;
plot(T,x(1,:),'m','Linewidth',2);
hold on;
plot(T,xe(1,:),'g','Linewidth',2);
hold on;
plot(T,xt(1,:),'b','Linewidth',2);
hold on;
plot(T,xte(1,:),'r','Linewidth',2);
hold on;
legend('True State','SKF','EKF','TKF','TEKF');
% axis([0 500 -10 10])
title('x(1)')
subplot(3,1,2)
plot(T,XR(2,:),'k','Linewidth',2);
hold on;
plot(T,x(2,:),'m','Linewidth',2);
hold on;
plot(T,xe(2,:),'g','Linewidth',2);
hold on;
plot(T,xt(2,:),'b','Linewidth',2);
hold on;
plot(T,xte(2,:),'r','Linewidth',2);
hold on;
legend('True State','SKF','EKF','TKF','TEKF');
%axis([0 500 -10 10])
title('x(2)')

ex1=(x(1,:)-XR(1,:)).^2;
exe1=(xe(1,:)-XR(1,:)).^2;
ext1=(xt(1,:)-XR(1,:)).^2;
exte1=(xte(1,:)-XR(1,:)).^2;

figure()
subplot(2,1,1)
plot(T,ex1,'m','Linewidth',2);
hold on;
plot(T,exe1,'g','Linewidth',2);
hold on;
plot(T,ext1,'b','Linewidth',2);
hold on;
plot(T,exte1,'r','Linewidth',2);
hold on;
legend('SKF','EKF','TKF','TEKF');
title('x(1) Error')

ex2=(x(2,:)-XR(2,:)).^2;
exe2=(xe(2,:)-XR(2,:)).^2;
ext2=(xt(2,:)-XR(2,:)).^2;
exte2=(xte(2,:)-XR(2,:)).^2;
title('x(1) Error')
subplot(2,1,2)
plot(T,ex2,'m','Linewidth',2);
hold on;
plot(T,exe2,'g','Linewidth',2);
hold on;
plot(T,ext2,'b','Linewidth',2);
hold on;
plot(T,exte2,'r','Linewidth',2);
hold on;
legend('SKF','EKF','TKF','TEKF');
title('x(2) Error')

figure()
MSE1=[mean(ex1),mean(exe1),mean(ext1),mean(exte1)];
MSE2=[mean(ex2),mean(exe2),mean(ext2),mean(exte2)];
MSE=[MSE1;MSE2];
bar(MSE)
set(gca,'XTickLabel',{'x(1)','x(2)'})
legend('SKF','EKF','TKF','TEKF');
title('MSE')

figure()
scatter(T,Y,'.','k')
hold on
plot(T,r,'m','Linewidth',2);
hold on;
plot(T,re,'g','Linewidth',2);
hold on;
plot(T,rt,'b','Linewidth',2);
hold on;
plot(T,rte,'r','Linewidth',2);
hold on;
legend('y','SKF','EKF','TKF','TEKF');
title('Measurement and Filted Results');