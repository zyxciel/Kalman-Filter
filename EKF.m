function [ x, r ] = EKF( x0,y,A,C,Q,R,tau )
%EKF extended kalman filter
%   此处显示详细说明
%x=zeros(size(y));
x(:,1)=x0;
P=eye(2,2);
for k=2:length(y)
    xx=A*x(:,k-1);
    PP=A*P*A'+Q;
    H=stepfun(y(k),tau+eps)*C;
    K=PP*H'/(H*PP*H'+R);
    P=(eye(size(A))-K*H)*PP;
    x(:,k)=xx+K*(y(k)-C*xx);

end
r=C*x;
