function [reduced_slots,slots_totales, slots] = Slots(Hstart,Hend,HNoReg,AAR, PAAR)
%Definimos el numero de slots que se pueden crear durante la regulación 
%(entre Hstart y Hend). El resultado se almacena en la variable 
%reduced_slots

reduced_slots = (Hend-Hstart)/(60/PAAR); 

%Nos dirá el número de filas de la matriz de slots (habrá un número entero
%de filas

slots_totales = round((Hend - Hstart)/(60/PAAR)+(HNoReg - Hend)/(60/AAR)); 

%Crea una matriz de todo ceros de nombre slots con la longitud especificada
%antes y 2 columnas
slots = zeros(slots_totales, 2); 

%Asigna valores a la primera columna de slots seleccionando las primeras
%filas. Usando transpose() creamos un vector que va desde Hstart hasta
%Hend-1 con un intervalo de 60/PAAR entre cada elemento del vector.
slots(1:reduced_slots,1) = fix(transpose(Hstart:(60/PAAR):Hend-1));

%Asigna valores a la primera columna de slots seleccionando las ultimas
%filas. Usando transpose() creamos un vector que va desde Hend hasta
%HNoReg-1 con un intervalo de 60/AAR entre cada elemento del vector.
slots(reduced_slots+1:end,1) = fix(transpose(Hend:(60/AAR):HNoReg-1));

%Eliminamos los valores cero de las matrices ETA y ETD, primero
%seleccionamos los valores iguales a cero y luego los vaciamos
end

