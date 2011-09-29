function plotParticlesOnMap(X0, MAP)

%X0 = initParticlesFancy(100, MAP);
figure(43);
imagesc(MAP');
hold on;
%plot(X0(:,1), X0(:, 2), 'k.');
u  = cos(X0(:,3));
v = sin(X0(:,3));
quiver(X0(:,1), X0(:, 2),u ,v, 0.2, 'k');
hold off;