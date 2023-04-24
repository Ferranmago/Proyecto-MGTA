%function [hoursETA,FlightsHour, FHouri, FHourj, FHourTotal] = Histogram(ETA, Hstart, Hend, AAR, PAAR)
function [] = Histogram(ETA, Hstart, Hend, AAR, PAAR)

%The variable hoursETA is the conversion from minutes to hours of the ETA
%variable. Also, a new array called count is defined as a 0 vector with 24
%rows (each one for an hour during the day)
hoursETA = ETA/60;
FlightsHour=zeros(24,1);

%Finally, the loop is created. The variable FHouri corresponds to the hour of
%the day and the variable FHourj reads the whole table verifying if each number
%is on the interval selected or not. If the condition is accomplished, then
%the counter of the previous hour than the current in filled with the
%number of total flights in that interval. 
FHouri=0; 
while FHouri<=24
    FHourj=1;
    while FHourj<=length(hoursETA)
        if (hoursETA(FHourj)<FHouri) && (hoursETA(FHourj)>=(FHouri-1))     %To check whether the hour studied is in the hour interval in which we are interested in. 
            FlightsHour(FHouri-1)=FlightsHour(FHouri-1)+1;
        end
        FHourj=FHourj+1;
    end
    FHouri=FHouri+1;
end

FHourTotal = sum(FlightsHour);       %To verify the total number of flights

figure(1);

X=fix(hoursETA);                          %To assign a bar for each number (truncament)--> Nos fallan cosas REVISAR
edges=0:1:24;                             
histogram(X, edges, 'FaceColor', 'b', 'EdgeColor', 'w');
histogram(X,edges);
axis([0 24 0 42]);
xticks(0:3:24);
xticklabels({'0','3','6','9','12','15','18','21','24'})
title('TRAFFIC DEMAND DATA');
xlabel('HOURS');
ylabel('NUMBER OF ARRIVALS')
hold on;


%Plot of the AAR and PAAR in the histogram
plot([0,Hstart/60],[AAR AAR],'g','LineWidth',2);
plot([Hstart/60,Hend/60],[PAAR PAAR],'r', 'LineWidth',2);
plot([Hend/60,24],[AAR AAR],'g','LineWidth',2);
hold off;

end

