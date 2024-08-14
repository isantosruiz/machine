clear; clc
t = readtable('fisheriris.csv');
x_test = [4,1];
%%
x1 = t.PetalLength;
x2 = t.PetalWidth;
limits = [min(x1), max(x1), min(x2), max(x2)];
[X1,X2] = meshgrid(1:0.05:7,0:0.01:2.5);
X = [x1,x2];
mu = mean(X); Sigma = cov(X);
pdf123 = @(X) mvnpdf(X, mu, Sigma);
tiledlayout("flow")
nexttile
P = reshape(pdf123([X1(:),X2(:)]),size(X1));
pcolor(X1,X2,P); shading interp; axis(limits) 
xlabel("Petal length (cm)") 
ylabel("Petal width (cm)")
title("all species")
%%
x1 = t.PetalLength(t.Species == "setosa");
x2 = t.PetalWidth(t.Species == "setosa");
X = [x1,x2];
mu = mean(X); Sigma = cov(X);
pdf1 = @(X) mvnpdf(X, mu, Sigma);
nexttile
P = reshape(pdf1([X1(:),X2(:)]),size(X1));
pcolor(X1,X2,P); shading interp; axis(limits) 
xlabel("Petal length (cm)") 
ylabel("Petal width (cm)")
title("setosa")
line(4,1,'Color','w','Marker','+','MarkerSize',10)
%%
x1 = t.PetalLength(t.Species == "versicolor");
x2 = t.PetalWidth(t.Species == "versicolor");
X = [x1,x2];
mu = mean(X); Sigma = cov(X);
pdf2 = @(X) mvnpdf(X, mu, Sigma);
nexttile
P = reshape(pdf2([X1(:),X2(:)]),size(X1));
pcolor(X1,X2,P); shading interp; axis(limits) 
xlabel("Petal length (cm)") 
ylabel("Petal width (cm)")
title("versicolor")
line(4,1,'Color','w','Marker','+','MarkerSize',10)
%%
x1 = t.PetalLength(t.Species == "virginica");
x2 = t.PetalWidth(t.Species == "virginica");
X = [x1,x2];
mu = mean(X); Sigma = cov(X);
pdf3 = @(X) mvnpdf(X, mu, Sigma);
nexttile
P = reshape(pdf3([X1(:),X2(:)]),size(X1));
pcolor(X1,X2,P); shading interp; axis(limits) 
xlabel("Petal length (cm)") 
ylabel("Petal width (cm)")
title("virginica")
line(4,1,'Color','w','Marker','+','MarkerSize',10)
%%
disp([pdf1(x_test), pdf2(x_test), pdf3(x_test)])
exportgraphics(gcf,"pdf_iris.pdf","Resolution",600)