function [HNoReg,delay] = AggregateDemand(ETA, Hstart, Hend, PAAR, AAR)

%Definition of the matrices 
timeminutes=transpose(1:1:24*60);
delay = 0;

%This loop analyzes the ETA of each flight and compares it with each minute 
ADK=1;    %The variable ADK defines the minutes. AD corresponds to Aggregated Demand
ADCounting = 0; 
while ADK<=1440       %1440 corresponds to the total number of minutes during the day
    ADFlights=1;            %ADFlights will run along the ETA vector which has a total of 325 flights
    while ADFlights<=length(ETA) 
        if ADK==round(ETA(ADFlights))     %If the current minute analyzed is equal to the ETA of the current flight, it satisfies the condition and demand is increased by one
            ADCounting = ADCounting + 1;
        end
        ADFlights = ADFlights + 1;
        aggregatedemand(ADK, 1) = ADCounting;   %Modifies the aggregatedemand vector by substituting the value of the current minute along the day for the counting variable.
    end
    ADK = ADK + 1;
end
aggregate_demand_vs_minutes_table=horzcat(timeminutes,aggregatedemand);

figure(2);

plot(timeminutes, aggregatedemand,'LineWidth',1.5,'Color','black');     %The plot is defined and some esthetic characteristics are applied

hold on;

%LOOP FOR PAAR
reducedm = Hstart; %defines the minutes with start value of Hstart.
reducedy = aggregatedemand(Hstart); %defines the y in graph of the minute.
reducedn = 1; %defines n in order complete the list.
while (reducedm<=Hend)
    if (reducedm>Hstart && mod(reducedm, 60/PAAR) == 0) %if divisor of 3, sum 1. Multiplier of 1/3 PA
        reducedy = reducedy + 1;
    end
    %Calculo Delay
    DelayCount = aggregatedemand(reducedm) - reducedy;
    if DelayCount >= 0
        delay = delay + DelayCount;
        DelayVector(reducedn, 1) = DelayCount;
    end
    DelayVector(reducedn, 2) = reducedm;
    Regreduced(reducedn, 1) = reducedy; %modify list and add value "y" in "n" position

    %Que carbure el bucle
    reducedm = reducedm+1;
    reducedn = reducedn+1;
end
reducedm = reducedm - 1;

%PLOT OF PAAR
intervalReduced = Hstart:1:Hend; %Defined in order to plot the interval values of interest.
plot (intervalReduced, Regreduced, ':','LineWidth',1.5,'Color','red');
hold on;

%LOOP FOR AAR
nominaln = 1;
while (reducedy <= aggregatedemand(reducedm) + 1) 
% while (reducedy <= aggregatedemand(reducedm + 60/PAAR))
    if (mod(reducedm, 60/AAR) == 0) %if divisor of 3/2, sum 2. Multiplier of 2/3.
        reducedy = reducedy + 2;
    end
    %Calculo Delay
    DelayCount = aggregatedemand(reducedm) - (reducedy - 2);
    if DelayCount >= 0
        delay = delay + DelayCount;
        DelayVector(reducedn, 1) = DelayCount;
    end
    Regnominal(nominaln, 1) = reducedy - 2;
    DelayVector(reducedn, 2) = reducedm;
    reducedm = reducedm + 1;
    nominaln = nominaln + 1;
    reducedn = reducedn + 1;

end

%PLOT FOR AAR
HNoReg = reducedm - 1;
intervalNominal = Hend:1:HNoReg;
plot (intervalNominal, Regnominal, ':','LineWidth',1.5,'Color','green');

title('TRAFFIC DEMAND DATA');
xlabel('TIME (MINUTES)');
ylabel('NUMBER OF ARRIVALS');
axis([0 1440 0 330]);
xticks(0:180:1440);

hold off;

end

