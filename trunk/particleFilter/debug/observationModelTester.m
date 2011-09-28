%just some test stuff

xt = [407 453 0];
load parsedData.mat;

%get a test laser reading

laser = ROBOT{1}.Laser;

zt.r = laser.r(200,:);

wt = observation_model_weight(zt, xt, MAP);