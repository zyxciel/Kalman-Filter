function [ x, r ] = TKF( x0,y,A,C,Q,R,tau )
%TKF Tobit Kalman Filter
%   此处显示详细说明
x(:,1)=x0;
P=eye(2,2);
for k=2:length(y)
    xx=A*x(:,k-1);
    PP=A*P*A'+Q;
    E=diag(1-qfunc((C*xx-tau)/sqrt(R)));
    Rxy=PP*C'*E;
    yy=(tau-C*xx)/sqrt(R);
    lambda=normpdf(yy)/qfunc(yy);
    Var=R*(1-(lambda*(lambda-yy)));
    Ryy=E*C*PP*C'*E+diag(Var);
    K=Rxy/Ryy;
    P=(eye(size(A))-E)*K*C*PP;
    Ey=E*(C*xx+sqrt(R)*lambda)+(1-qfunc((tau-C*xx)/sqrt(R)))*tau;
    x(:,k)=xx+K*(y(k)-Ey);

end
r=C*x;

end

