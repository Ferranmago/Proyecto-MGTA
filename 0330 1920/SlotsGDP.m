function [slots] = SlotsGDP(ETA, total_exempted_flights,controlled_flights_GDP,slots)

for j=1:length(total_exempted_flights)
    for k=2:length(slots)
        if(ETA(total_exempted_flights(j))<slots(k) && slots(k-1,2)==0)
            slots(k-1,2)=total_exempted_flights(j);
            
            break
        end
    end
end

for j=1:length(controlled_flights_GDP)
    for k=2:length(slots)
        if(ETA(controlled_flights_GDP(j))<slots(k) && slots(k-1,2)==0)
            slots(k-1,2)=controlled_flights_GDP(j);
            break
        end
    end
end


