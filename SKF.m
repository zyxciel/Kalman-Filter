function [ x, r ] = SKF( x0,y,A,C,Q,R )
%SKF standard kalman filter
%   此处显示详细说明
%x=zeros(size(y));
x(:,1)=x0;
P=eye(2,2);
for k=2:length(y)
    xx=A*x(:,k-1);
    PP=A*P*A'+Q;
    K=PP*C'/(C*PP*C'+R);
    P=(eye(size(A))-K*C)*PP;
    x(:,k)=xx+K*(y(k)-C*xx);

end
r=C*x;
