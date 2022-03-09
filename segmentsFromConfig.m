function segments = segmentsFromConfig(Q,n)
%SEGMENTSFROMCONFIG Summary of this function goes here
%   Detailed explanation goes here

global angle_stop box obstacles a l1 l2 v_max theta_max;

segments = [];

if n == 1
    currentQ = Q(1:4);
else 
    if n == 2
        currentQ = Q(5:8);
    else 
        return;
    end
end
  
X = currentQ(1);
Y = currentQ(2);
theta1 = currentQ(3);
theta2 = currentQ(4);

segments = [ X-a/2, Y+a/2, X+a/2, Y+a/2;
             X+a/2, Y+a/2, X+a/2, Y-a/2;
             X+a/2, Y-a/2, X-a/2, Y-a/2;
             X-a/2, Y-a/2, X-a/2, Y+a/2;
             X, Y, X+l1*cos(theta1), Y+l1*sin(theta1);
             X+l1*cos(theta1), Y+l1*sin(theta1),  X+l1*cos(theta1)+ l2* cos(theta1+theta2), Y+l1*sin(theta1)+l2* sin(theta1+theta2)];
    

end

