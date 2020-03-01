function [ x, r ] = TEKF( x0,y,A,C,Q,R,tau )
%TEKF tobit extended kalman filter
%   此处显示详细说明
%x=zeros(size(y));
x(:,1)=x0;
P=eye(2,2);
for k=2:length(y)
    xx=A*x(:,k-1);
    PP=A*P*A'+Q;
    yy=C*xx;
    if yy==(eps+tau)
        H=(yy-tau)*C+stepfun(yy,tau+eps)*C;
    else
        H=stepfun(yy,tau+eps)*C;
    end
    K=PP*H'/(H*PP*H'+R);
    P=(eye(size(A))-K*H)*PP;
%     E=diag(1-qfunc((C*xx-tau)/sqrt(R)));
%     yy=(tau-C*xx)/sqrt(R);
%     lambda=normpdf(yy)/qfunc(yy);
%     Ey=E*(C*xx+sqrt(R)*lambda)+(1-qfunc((tau-C*xx)/sqrt(R)))*tau;
    x(:,k)=xx+K*(y(k)-yy);

end
r=C*x;

