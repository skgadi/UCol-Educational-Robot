%Sample Time
Ts=0.06;

%Supply voltage to the engine of the body, shoulder, elbow and wrist
Va=24;

%Body motor parameters
a_1=10.2;
b_1=0.243;
%Shoulder motor parameters
a_2=13.1;
b_2=0.175;
%Elbow motor parameters
a_3=5.5;
b_3=0.14;
%Wrist one motor parameters
a_4=17;
b_4=0.14;
%Wrist two motor parameters
a_5=16.5;
b_5=0.15;

%Observer 

alpha=12;
%Gain K1 and K2 body motor
k1_1=2*alpha-a_1;
k2_1=alpha^2-b_1*k1_1;
%Gain K1 and K2 shoulder motor
k1_2=2*alpha-a_2;
k2_2=alpha^2-b_2*k1_2;
%Gain K1 and K2 elbow motor
k1_3=2*alpha-a_3;
k2_3=alpha^2-b_3*k1_3;
%Gain K1 and K2 wrist one motor
k1_4=2*alpha-a_4;
k2_4=alpha^2-b_4*k1_4;
%Gain K1 and K2 wrist two motor
k1_5=2*alpha-a_5;
k2_5=alpha^2-b_5*k1_5;