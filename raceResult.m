function raceResult(recordStruct, swimmerStruct, orderVec, timeVec)
    %Double quotes matter to make sprintf return string scalar instead 
    % of char vector
    resultsMsg = sprintf("200m Individual Medley Results Final\n");
    
    for rank = 1:length(orderVec)
        if(timeVec(rank) < recordStruct.World)
            recordStat = "WR"
        elseif(timeVec(rank) < recordStruct.World)
            recordStat = "OR"
        else
            recordStat = "";
        end
        
        resultsMsg = resultsMsg + sprintf("%d. %s     %f      %s\n", rank, swimmerStruct(orderVec(rank)).Name, timeVec(rank), recordStat)
    end
    
    resultsMsg = resultsMsg + sprintf("%s wins the Gold Medal\n", swimmerStruct(orderVec(1)).Name);  
    msgbox(resultsMsg);
end