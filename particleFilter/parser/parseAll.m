function parseAll()

%load robot data
for i=1:5
    robotLogFile  = ['robotdata',num2str(i),'.log'];
    ROBOT{i} = parseRobotDataLog(robotLogFile);
end

%load map data
MAP = parseMap();

%save to file
save ('data/parsedData.mat','ROBOT','MAP');