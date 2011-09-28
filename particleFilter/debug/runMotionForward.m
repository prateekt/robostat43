function states = runMotionForward(odometry,alpha)

%load odometry data
%load parsedData.mat;
%odometry = ROBOT{1}.Odometry;
%alpha = [0.01,0.01,0.01,0.01];

%sample states
states = zeros(length(odometry.x),3);
x_t = [odometry.x(1),odometry.y(1),odometry.theta(1)];
states(1,:) = x_t;
for i=2:length(odometry.x)
    u_t = [odometry.x(i-1),odometry.y(i-1),odometry.theta(i-1),odometry.x(i),odometry.y(i),odometry.theta(i)];
    x_t = sample_motion_model_odometry(u_t, x_t, alpha);
    states(i,:) = x_t;
end