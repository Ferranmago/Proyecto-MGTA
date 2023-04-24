function [total_delay_vector] = TotalDelayVector(ETA,not_affected_flights_GDP,total_exempted_flights,air_delay,controlled_flights_GDP,ground_delay)

total_delay_vector=zeros(length(ETA),2);


for i=1:length(ETA)
    total_delay_vector(i,1)=i;
end

for j=1:length(ETA)
    for k=1:length(not_affected_flights_GDP)
        if(j==not_affected_flights_GDP(k,1))
            total_delay_vector(j,2)=0;
       
        end
    end
    for k=1:length(total_exempted_flights)
        if(j==total_exempted_flights(k,1))
            total_delay_vector(j,2)=air_delay(k,2);
        end
    end
    for k=1:length(controlled_flights_GDP)
        if(j==controlled_flights_GDP(k,1))
            total_delay_vector(j,2)=ground_delay(k,2);
        end
    end
end