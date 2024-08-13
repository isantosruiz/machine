url = "https://pokeapi.co/api/v2/pokemon";
data = webread(url);
num_pokes = data.count; 
data = webread(url + "?offset=0&limit=" + num_pokes);
names = string({data.results.name}');
urls = string({data.results.url}');
Name = ["charmander","ho-oh","eevee","mew","pikachu",...
    "rattata","squirtle","tepig"]';
Height = zeros(8,1);
Weight = zeros(8,1);
for k = 1:8
    u = urls(names == Name(k));
    data = webread(u);
    Height(k) = data.height/10;
    Weight(k) = data.weight/10;    
end
t = table(Name,Height,Weight);
t = sortrows(t,["Height","Weight"],"ascend");
t.Properties.RowNames = compose("Favorite %d",1:numel(Name));
disp(t)