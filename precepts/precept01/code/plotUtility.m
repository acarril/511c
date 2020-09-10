xlab = 'x (pizzas)';
ylab = 'y (beers)';

tx = linspace (0, 16);
ty = tx;
[xx, yy] = meshgrid (tx, ty);
% r = sqrt (xx .^ 2 + yy .^ 2) + eps;
r = sqrt(xx .* yy);
tz = sin (r) ./ r;
mesh(tx, ty, r);
xlabel(xlab);
ylabel(ylab);
zlabel('u(x, y)');
colorbar;
supersizeme(1.3);
savePDFfig(['../figs/plot_utility_3dmesh'])

contour(xx, yy, r)
xlabel(xlab);
ylabel(ylab);
colorbar;
supersizeme(1.3);
savePDFfig(['../figs/contour_utility_Alvaro'])