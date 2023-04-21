function Unrecoverable_Delay = ComputeUnrecoverableDelay(CTD,ETD,Hstart,ground_delay)

Unrecoverable_Delay=0;

for i=1:length(ground_delay)
    if ETD(i,1)>Hstart
        Unrecoverable_Delay=Unrecoverable_Delay+0;
    end
    if CTD(i,1)<Hstart
        Unrecoverable_Delay=Unrecoverable_Delay+(CTD(i,1)-ETD(i,1));
    end
    if (ETD(i,1)<Hstart)&&(CTD(i,1)>Hstart)
        Unrecoverable_Delay=Unrecoverable_Delay+(Hstart-ETD(i,1));
    end
end