warning off
t = readtable("data/COVID19MEXICO.csv");
disp(datasample(t,10))
muerto = string(t.FECHA_DEF) ~= "9999-99-99";
readtable("data/240708 Catalogos.xlsx", "Sheet", ...
    "Cat CLASIFICACION_FINAL_COVID")
confirmado = t.CLASIFICACION_FINAL_COVID == 3;
readtable("data/240708 Catalogos.xlsx", "Sheet", "Catálogo SEXO")
mujer = t.SEXO == 1;
hombre = t.SEXO == 2;
%--------------------------------------------------------------------------
pctMortalidad = 100*sum(muerto & confirmado)/sum(confirmado)
%--------------------------------------------------------------------------
max(t.EDAD(confirmado))
edges = 0:5:110;
tiledlayout("flow")
nexttile
histogram(t.EDAD(confirmado), edges)
xlabel('Edad'); ylabel("Número de confirmados")
nexttile
histogram(t.EDAD(confirmado & muerto), edges)
xlabel('Edad'); ylabel("Número de muertos")
%--------------------------------------------------------------------------
mujeresMuertas = sum(mujer & muerto & confirmado)
hombresMuertos = sum(hombre & muerto & confirmado)
fraccion = mujeresMuertas / (mujeresMuertas + hombresMuertos)
nexttile
pie([mujeresMuertas, hombresMuertos], [true, false], ...
    ["Mujeres: " + mujeresMuertas, "Hombres: " + hombresMuertos])
title("Distribución de fallecidos por género")
%--------------------------------------------------------------------------
readtable("data/240708 Catalogos.xlsx", "Sheet", "Catálogo SI_NO")
intubado = t.INTUBADO == 1;
propIntubadosNacional = sum(intubado & confirmado) / sum(confirmado)
readtable("data/240708 Catalogos.xlsx", "Sheet", "Catálogo de ENTIDADES")
chiapas = t.ENTIDAD_RES == 7;
propIntubadosChiapas = sum(intubado & chiapas & confirmado) / ...
    sum(chiapas & confirmado)
%--------------------------------------------------------------------------
cat = readtable("data/240708 Catalogos.xlsx", "Sheet", ...
    "Catálogo MUNICIPIOS")
coord = readtable("data/coordenadas.csv")
numTuxtla = str2num(cat.CLAVE_MUNICIPIO{cat.MUNICIPIO == ...
    "TUXTLA GUTIÉRREZ" & cat.CLAVE_ENTIDAD == "07"});
numTonala = str2num(cat.CLAVE_MUNICIPIO{cat.MUNICIPIO == ...
    "TONALÁ" & cat.CLAVE_ENTIDAD == "07"});
numComitan = str2num(cat.CLAVE_MUNICIPIO{cat.MUNICIPIO == ...
    "COMITÁN DE DOMÍNGUEZ" & cat.CLAVE_ENTIDAD == "07"});
conejo = t.MUNICIPIO_RES == numTuxtla;
turulo = t.MUNICIPIO_RES == numTonala;
cositia = t.MUNICIPIO_RES == numComitan;
lat(1) = coord.Latitud(coord.Municipio == "TUXTLA GUTIÉRREZ");
lon(1) = coord.Longitud(coord.Municipio == "TUXTLA GUTIÉRREZ");
lat(2) = coord.Latitud(coord.Municipio == "TONALÁ");
lon(2) = coord.Longitud(coord.Municipio == "TONALÁ");
lat(3) = coord.Latitud(coord.Municipio == "COMITÁN DE DOMÍNGUEZ");
lon(3) = coord.Longitud(coord.Municipio == "COMITÁN DE DOMÍNGUEZ");
nexttile
conf(1) = sum(confirmado & conejo)
conf(2) = sum(confirmado & turulo)
conf(3) = sum(confirmado & cositia)
geobubble(lat, lon, conf)
geolimits([lat(1)-1, lat(1)+1], [lon(1)-1, lon(1)+1])
title("Casos confirmados")
%--------------------------------------------------------------------------
diabetico = t.DIABETES == 1;
pctMortalidadDiabeticos = 100*sum(muerto & diabetico & confirmado) / ...
    sum(confirmado & diabetico)
incremento = pctMortalidadDiabeticos - pctMortalidad
