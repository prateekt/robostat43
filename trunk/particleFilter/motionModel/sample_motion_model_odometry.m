function x_t = sample_motion_model_odometry(u_t, x_tm1, alpha)
%u_t is the current control (x_bar_tm,x_bar_t)
%x_tml is the last state estimate
%alpha is the 4-vector of alpha parameters.

%extract structs
x = x_tm1(1);
y = x_tm1(2);
theta = x_tm1(3);
weight = x_tm1(4);

x_bar_tm1 = u_t(1:3);
x_bar_t = u_t(4:6);

x_bar = x_bar_tm1(1);
y_bar = x_bar_tm1(2);
theta_bar = x_bar_tm1(3);

x_bar_prime = x_bar_t(1);
y_bar_prime = x_bar_t(2);
theta_bar_prime = x_bar_t(3);

%% Algorithm

%standard stats
delta_rot1 = atan2(y_bar_prime - y_bar, x_bar_prime - x_bar) - theta_bar;
delta_trans = sqrt( (x_bar - x_bar_prime)^2 + (y_bar - y_bar_prime)^2 );
delta_rot2 = theta_bar_prime - theta_bar - delta_rot1;


delta_prime_rot1 = delta_rot1 - sample_normal_distribution(alpha(1)*delta_rot1 + alpha(2)*delta_trans);
delta_prime_trans = delta_trans - sample_normal_distribution(alpha(3)*delta_trans + alpha(4)*(delta_rot1 + delta_rot2));
delta_prime_rot2 = delta_rot2 - sample_normal_distribution(alpha(1)*delta_rot2 + alpha(2)*delta_trans);


% %no noise test case
% delta_prime_rot1 = delta_rot1;
% delta_prime_trans = delta_trans;
% delta_prime_rot2 = delta_rot2;

%updates
x_prime = x + (delta_prime_trans/10)*cos(theta + delta_prime_rot1);
y_prime = y + (delta_prime_trans/10)*sin(theta + delta_prime_rot1);
theta_prime = theta + delta_prime_rot1 + delta_prime_rot2;

%return
x_t = [x_prime, y_prime, theta_prime, weight]';
