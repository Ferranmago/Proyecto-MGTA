function [table,ETA,Origin,Distance,ECAC,ETD] = Load()
% A variable named table is created from the reading of an excel file. Then
% some variables are defined according to each column of the variable table
table = readtable("CODE_excel.xlsx");
ETA = round(table2array(table(:,1)));
Origin = table2array(table(:,2));
Distance = table2array(table(:,3));
ECAC = table2array(table(:,4));
ETD = round(table2array(table(:,5)));
end

