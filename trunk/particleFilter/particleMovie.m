clear;

load Experiment_3.mat;
load parsedData.mat;
T = length(particleSets);
%T = 100;

aviobj = avifile('log1param3ss.avi');
for i  = 1:3:T
    X0 = particleSets{i};
figure(43);
imagesc(MAP');
hold on;
%plot(X0(:,1), X0(:, 2), 'k.');
u  = cos(X0(:,3));
v = sin(X0(:,3));
quiver(X0(:,1), X0(:, 2),u ,v, 0.2, 'k');
%plot(X0(:,1), X0(:, 2), 'xk');

h = gcf;
aviobj = addframe(aviobj,h);
hold off;
end

aviobj = close(aviobj);