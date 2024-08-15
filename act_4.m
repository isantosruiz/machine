t = readtable('./data/bovine.csv');
disp(head(t))
[min(t.PT),max(t.PT)]
model = fitrgp(t.PT,t.PV);
PT_test = (1.20:0.01:1.80)';
PV_pred = model.predict(PT_test);
cinta_pesadora = table(PT_test,PV_pred);
disp(head(cinta_pesadora))
plot(t.PT,t.PV,'*',PT_test,PV_pred)