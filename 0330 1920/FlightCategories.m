function [not_affected_flights_GDP,controlled_flights_GDP,total_exempted_flights,radius_exempted_flights,international_exempted_flights,already_flying_exempted_flights] = FlightCategories(ETA,ETD,ECAC,Distance,Hstart,HNoReg,radius_GDP,Hfile)

not_affected_flights_GDP = zeros(length(ETA),1); 
controlled_flights_GDP = zeros(length(ETA),1); 
total_exempted_flights = zeros(length(ETA),1); 
radius_exempted_flights = zeros(length(ETA),1); 
international_exempted_flights = zeros(length(ETA),1);
already_flying_exempted_flights = zeros(length(ETA),1);

p=1;
while(p<length(ETA)+1)
    ETA_time = ETA(p);
    if(ETA_time<Hstart||ETA_time>HNoReg)
        not_affected_flights_GDP(p)=p;
    elseif(ETA_time>=Hstart && ETA_time<=HNoReg)
        if(Distance(p)>radius_GDP)
            radius_exempted_flights(p)=p;
            total_exempted_flights(p)=p;
        end
        if(ETD(p)<Hfile+30)
            already_flying_exempted_flights(p)=p;
            total_exempted_flights(p)=p;
        end
        if(ECAC(p)==1)
            international_exempted_flights(p)=p;
            total_exempted_flights(p)=p;
        end
        if ((ECAC(p) ~= 1) && (ETD(p)>=Hfile+30) && (Distance(p)<radius_GDP))
            controlled_flights_GDP(p)=p;
        end
    end
    p=p+1;
end

% Una vez recorrido todo el bucle , eliminamos los ceros de ambas matrices.
% Estamos eliminando todas las filas de cada matriz que tienen un valor de
% cero. A nivel de código primero seleccionamos los elementos de la matriz
% que son iguales a cero y luego asignamos al vacío para eliminar estos
% valores de la matriz.

controlled_flights_GDP(controlled_flights_GDP==0) = [];
not_affected_flights_GDP(not_affected_flights_GDP == 0) = [];
total_exempted_flights(total_exempted_flights==0) = [];
radius_exempted_flights(radius_exempted_flights==0) = []; 
international_exempted_flights(international_exempted_flights==0) = []; 
already_flying_exempted_flights(already_flying_exempted_flights==0) = []; 

end

