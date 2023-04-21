function [ground_delay,air_delay,total_delay] = GroundAirDelay(ETA, controlled_flights_GDP,total_exempted_flights,slots)

ground_delay = zeros(length(controlled_flights_GDP),2);
air_delay = zeros(length(total_exempted_flights),2);

a=1;
b=1;

%Recorremos el vector de controlled_flights y asignamos a cada fila del
%vector ground delay el id del vuelo del vector controlled. Se recorre el
%vector slots y se comprueba si coinciden el id del vuelo en ambos vectores
%para la misma fila. Si coincide, calculamos el delay restando el slot
%asignado menos la eta para ese vuelo. Si es negativo te asigna que es cero
%pq estás dentro del slot y el delay es 0
for m=1:length(controlled_flights_GDP)
    ground_delay(a,1)=controlled_flights_GDP(m);
    for n=1:length(slots)
        if(ground_delay(a,1)==slots(n,2))
            ground_delay(a,2)=slots(n)-ETA(controlled_flights_GDP(m));
            if ground_delay(a,2) < 0
                ground_delay(a,2) = 0;
            end
        end
    end   
        a=a+1;        
end


%Recorremos el vector de exempted_flights y asignamos a cada fila del
%vector air delay el id del vuelo del vector exempted. Se recorre el
%vector slots y se comprueba si coinciden el id del vuelo en ambos vectores
%para la misma fila. Si coincide, calculamos el delay restando el slot
%asignado menos la eta para ese vuelo. Si es negativo te asigna que es cero
%pq estás dentro del slot y el delay es 0


for o=1:length(total_exempted_flights)
        air_delay(b,1)=total_exempted_flights(o);
        for q=1:length(slots)
            if(air_delay(b,1)==slots(q,2))
                air_delay(b,2)=slots(q)-ETA(total_exempted_flights(o));
                if air_delay(b,2) < 0
                    air_delay(b,2) = 0;
                end
            end
        end
        
        b=b+1;        
end


total_delay = sum(ground_delay(:,2)) + sum(air_delay(:,2)); 
end

