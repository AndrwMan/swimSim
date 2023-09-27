function adjSpeed = speed(currSwimmer, lap)
    %[speed1 speed2] = swimmerStruct.Butterfly
    fields = fieldnames(currSwimmer);
    
    %First field is name, must shift index
    currStroke = fields{lap + 1};
    speed1 = currSwimmer.(currStroke);
    adjSpeed = (speed1 * 0.9) + (speed1 * 1.1 - speed1 * 0.9)* rand;
end