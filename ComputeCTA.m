function [CTA] = ComputeCTA (ETA,total_delay_vector)

CTA = zeros(length(ETA),1);

for i=1:length(CTA)
    CTA(i,1)=ETA(i,1)+total_delay_vector(i,2);
end


