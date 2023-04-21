function [] = HistogramTrafficReg(ETA,PAAR,AAR,Hstart,Hend)

hoursETA1 = ETA/60;
FlightsHour1=zeros(24,1);

FHourk=0;
contador = 0;
while FHourk<=24  %HORA POR HORA
    FHourl=1; %TODOS LOS FLIGHTS
    while FHourl<=length(hoursETA1) %RECORRA VECTOR DE FLIGHTS / CADA HORA
        
        if (hoursETA1(FHourl)<FHourk) && (hoursETA1(FHourl)>=(FHourk-1))     %To check whether the hour studied is in the hour interval in which we are interested in. 
                  %ENTRAREMOS CON PRIMER AVION CON VALOR FHOURK = 6  
            if (FHourk>=(Hstart/60)) && (FHourk<=(Hend/60)) %PARA QUE SOLO SE EJECUTE EN INTERVALO DE HSTART --> HEND

                while (FlightsHour1(FHourk-1) < PAAR) && contador > 0
                    
                    FlightsHour1(FHourk-1) = FlightsHour1(FHourk-1) + 1;
                    contador = contador - 1;
                end
                if (FlightsHour1(FHourk-1) >= PAAR) 
                    FlightsHour1(FHourk-1) = PAAR-1;
                    contador = contador + 1; %Tiene que dar un total de 48 vuelos afectados
                end
            
            else
                while (FlightsHour1(FHourk-1) < AAR) && contador >0
                        FlightsHour1(FHourk-1) = FlightsHour1(FHourk-1) +1;
                        contador = contador -1;
                end
                if (FlightsHour1(FHourk-1) >= AAR)
                    FlightsHour1(FHourk-1)= AAR -1;
                    contador = contador +1;

                end
                
            end

            FlightsHour1(FHourk-1)=FlightsHour1(FHourk-1)+1;
        end

        FHourl=FHourl+1;
        
    end
    
    FHourk=FHourk+1;
end

figure(3);
X1=FlightsHour1;    %To assign a bar for each number (truncament) --> Nos fallan cosas REVISAR
bar(X1);
end

