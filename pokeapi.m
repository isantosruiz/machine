url = "https://pokeapi.co/api/v2/pokemon";
options = weboptions('Timeout', 10);
try
    data = webread(url, options);
catch ME
    disp('No se pudo conectar a Internet.');
    disp(['Error: ', ME.message]);
end
num_pokes = data.count; 
data = webread(url + "?offset=0&limit=" + num_pokes);
names = {data.results.name}';
urls = {data.results.url}';
t = table(names, urls);
t = sortrows(t, 'names', 'ascend');
sel = listdlg('ListString', t.names, ...
    'PromptString', 'Selecciona un pokémon', ...
    'SelectionMode', 'single');
url_sel = t.urls{sel};
data = webread(url_sel);
url_img = data.sprites.other.home.front_default;
[img, ~, alpha] = imread(url_img);
himg = imshow(img);
himg.AlphaData = im2double(alpha);
txt = "Altura: " + data.height/10 + " m, Peso: " + data.weight/10 + " kg";
title(himg.Parent, txt, FontWeight="normal")
set(gcf, Name=t.names{sel}, MenuBar='none', NumberTitle='off')