function distance = costFunction(Q1,Q2)
%COSTFUNCTION Summary of this function goes here
%   Detailed explanation goes here

global v_max theta_max;

Q1_tuned = [Q1(1)/v_max; 
            Q1(2)/v_max;
            Q1(3)/theta_max;
            Q1(4)/theta_max];
        
Q2_tuned = [Q2(1)/v_max; 
            Q2(2)/v_max;
            Q2(3)/theta_max;
            Q2(4)/theta_max];
        
distance = norm(Q1_tuned-Q2_tuned);

end

