function z = cat2ind(y)
y = categorical(y);
[m,n] = size(y);
y = y(:);
z = vec2ind(y'==unique(y))';
z = reshape(z,[m,n]);