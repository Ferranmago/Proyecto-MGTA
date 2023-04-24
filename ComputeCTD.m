function [CTD] = ComputeCTD(ETD,total_delay_vector)

CTD = zeros(length(ETD),1);

for i=1:length(CTD)
    CTD(i,1)=ETD(i,1)+total_delay_vector(i,2);
end