%just some test stuff

xt = [200 200 0];
load parsedData.mat;

%get a test laser reading

laser = ROBOT{1}.Laser;

zt.r = laser.r(1,:);