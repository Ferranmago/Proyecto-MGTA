%Load values
clear;
[table,ETA,Origin,Distance,ECAC,ETD] = Load();

%Define values for PAAR and AAR
PAAR=15;
AAR=40;

%Defines values for Hfile, Hstart and Hend.
Hfile = 300;
Hstart=420;   
Hend=780; 

%%
% --------------------------- // WP1: // ----------------------------------

%Histogram
%[hoursETA,FlightsHour, FHouri, FHourj, FHourTotal] = Histogram(ETA, Hstart, Hend, AAR, PAAR);
Histogram(ETA, Hstart, Hend, AAR, PAAR);

%Aggregate Demand
%Computes the aggregate demand and capacities, the minimum delay needed, and the hour when the regulation is no longer needed.
[HNoReg, delay] = AggregateDemand (ETA, Hstart, Hend, PAAR, AAR);

%Slots
[reduced_slots,slots_totales, slots] = Slots(Hstart,Hend,HNoReg,AAR, PAAR);

%%
% -------------------- // WP2: RBS , GDP // -------------------------------

% Definimos el valor del radio del GDP , de momento cogiendo una distancia media (no sea ninguna distancia máxima ni mínima)
radius_GDP = 1500;

% Creamos matrices para separar los vuelos por categorias
[not_affected_flights_GDP,controlled_flights_GDP,total_exempted_flights,radius_exempted_flights,international_exempted_flights,already_flying_exempted_flights] = FlightCategories(ETA,ETD,ECAC,Distance,Hstart,HNoReg,radius_GDP,Hfile);

% Queremos hacer la asignación de slots del GDP
[slots] = SlotsGDP(ETA, total_exempted_flights,controlled_flights_GDP,slots);

%Hacer matrices de ground y air delay
[ground_delay,air_delay,total_delay] = GroundAirDelay(ETA, controlled_flights_GDP,total_exempted_flights,slots);

%Histogram with traffic regulations
HistogramTrafficReg(ETA,PAAR,AAR,Hstart,Hend);

%Hacer matriz de total delay (sin diferenciar el tipo)
[total_delay_vector] = TotalDelayVector(ETA,not_affected_flights_GDP,total_exempted_flights,air_delay,controlled_flights_GDP,ground_delay);

%Computation of CTA
[CTA] = ComputeCTA(ETA, total_delay_vector);

%Computation of CTD
[CTD] = ComputeCTD(ETD,total_delay_vector);

%Computation of Unrecoverable Delay
Unrecoverable_Delay = ComputeUnrecoverableDelay(CTD,ETD,Hstart,ground_delay);
%%
% --------------------------- // WP3: // ----------------------------------

