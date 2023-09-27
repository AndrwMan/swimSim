% Name: Andrew Man
%% Initialize variables
clear;
close all;
clc;

% Define parameters for the event
poolLength = 50;                         % length of swimming pool 
entireDist = 200;                        % swimming distance 
totalLaps = entireDist/poolLength;       % number of laps = distance/length of pool
numSwimmers = 8;

% Define structs for records and swimmers
recordStruct = struct('World', 20.1000, 'Olympic', 20.3300);     % struct that contains the World record and Olympic record  

%swimmerStruct = struct([])                                                         % struct array that contains all the swimmersc names and speed
swimmerStruct(2) = struct('Name','Lochte', 'Butterfly', 9, 'BackStroke', 10, ...
                            'BreastStroke', 9, 'FreeStyle', 9);                    % rating

swimmerStruct(1) = struct('Name','Phelps', 'Butterfly', 10, 'BackStroke', 9, ...
                            'BreastStroke', 9, 'FreeStyle', 10);

% GIVEN constants 
dt = 0.01;      % time step size for each iteration
x1 = 0;         % initialize locations for each swimmer
y1 = 1;         % Assuming they swim in a straight line, y's are constant, repre. lanes
x2 = 0;
y2 = 2;

% Initialize parameters used inside the loop 
swimDir1 = 1;
swimDir2 = 1;
lapDist1 = 0;
lapDist2 = 0;
lapNum1 = 1;
lapNum2 = 1;
%currLoc1 = 0;
%currLoc2 = 0;
isFinish1 = false;
isFinish2 = false;
orderVec = [];
timeVec = [];

%% Plot starting graph
plot(x1, y1, 'ro', x2, y2, 'bo');
        hold on;
        title(sprintf('Olympics %d: %dm IM', 2016, entireDist))
        set(gca,'Color','c')
        axis([0 50 0 9]);
%         plot([0 50], [0.5 0.5], 'y--')
%         plot([0 50], [1.5 1.5], 'y--')
%         plot([0 50], [2.5 2.5], 'y--')

        borderPos = 0.5;
        for borderCnt = 1:(numSwimmers + 1)
            plot([0 50], [borderPos borderPos], 'y--')
            borderPos = borderPos + 1;
        end
        

        text(x1, y1, ['  ' swimmerStruct(1).Name] );
        text(x2, y2, ['  ' swimmerStruct(2).Name] );
        %yticks([1 2])
        yticks([1 2 3 4 5 6 7 8])
        ytickformat('Lane %d')
        hold off;

%% Calculate positions and plot moving swimmers

% Add menu to start the race
userChoice = menu('Click to start the race!', 'BANG')
if(userChoice == 1)
    % Using a loop to simulate the race. Loop should iterate until all swimmers
    % finish their laps
    while(~(lapNum1 == 5 && lapNum2 == 5))
        finTime1 = 0;
        finTime2 = 0;
        %Keep running loop if either has not finished
        while(lapNum1 <= 4 || lapNum2 <= 4)            
            % Code to check current progress of each swimmer and determine their
            % corresponding swimming direction. Hint: alternate signs for changing
            % direction
            %if they reach lap 4 they are done, stop/don't do anything
            if(lapNum1 <= 4)
                %track overall completion time
                finTime1 = finTime1 + dt;
                adjSpeed1 = speed(swimmerStruct(1), lapNum1)
                
                if(lapDist1 + (adjSpeed1 * dt) >= 50)        % direction for swimmer 1
                    swimDir1 = swimDir1 * (-1); 
                    %'Resets' swimmer distance in the lap
                    lapDist1 = lapDist1 - 50; 
                    lapNum1 = lapNum1 + 1;
                else
                    lapDist1 = lapDist1 + (adjSpeed1*dt);
                end
            end
            
            if(lapNum2 <= 4)
                finTime2 = finTime2 + dt;
                adjSpeed2 = speed(swimmerStruct(2), lapNum2)
                
                disp(lapDist2 + (adjSpeed2*dt))
                if(lapDist2 + (adjSpeed2*dt) >= 50)         
                    swimDir2 = swimDir2 * (-1);
                    lapDist2 = lapDist2 - 50; 
                    lapNum2 = lapNum2 + 1;
                else
                    lapDist2 = lapDist2 + (adjSpeed2*dt);
                end
            end 
             
        % Determine swimmer locations at each time step
        % Current location = previous location + velocity*time_step
        % velocity = direction * speed (where speed can be obtained by calling 
        % on the function speed that you define earlier)
        %The negative direction results in subtraction, "turning around"
        %velo1 = 0;
        if(lapNum1 <= 4)
            velo1 = swimDir1 * adjSpeed1;
            x1 = x1 + (velo1 * dt)
        end
        if(lapNum2 <= 4)
            velo2 = swimDir2 * adjSpeed2;
            x2 = x2 + (velo2 * dt);
        end
        
        plot(x1, y1, 'ro', x2, y2, 'bo');
        hold on;
        title(sprintf('Olympics %d: %dm IM', 2000, entireDist))
        set(gca,'Color','c')
        axis([0 50 0 9]);
        %plot([0 50], [0.5 0.5], 'y--')
        %plot([0 50], [1.5 1.5], 'y--')
        %plot([0 50], [2.5 2.5], 'y--')
        
        borderPos = 0.5;
        for borderCnt = 1:(numSwimmers + 1)
            plot([0 50], [borderPos borderPos], 'y--')
            borderPos = borderPos + 1;
        end
        
        text(x1, y1, ['  ' swimmerStruct(1).Name] );
        text(x2, y2, ['  ' swimmerStruct(2).Name] );
        yticks([1 2])
        ytickformat('Lane %d')
        hold off;
        
        %Use the pause function stall the speed of animation
        pause(dt/2);
        
        end 
        
        % Check if each swimmer finished their race and update finishing order
        % When swimmer finished the race, they should be waiting at the finish
        % line until everyone finishes. 
        % Once end is reached use flag to prevent assigning 
        % to orderVec for the entire duration of lap
        if(lapNum1 == 5 && ~(isFinish1) )
            isFinish1 = true;
            orderVec(end + 1) = y1 
            timeVec(end + 1) = finTime1
        end
        
        if(lapNum2 == 5 && ~(isFinish2) )
            isFinish2 = true;
            orderVec(end + 1) = y2
            timeVec(end + 1) = finTime2
        end
        
        % Plotting current location of all swimmers. Make sure to set a fix dimension for the plot 
        % Can't pass enter vector each iteration, needs one point/x-value
    end
end

% Print out the results of the race (finishing order based on lane
% assignment) and print out the name of the winner

%% Print results
raceResult(recordStruct, swimmerStruct, orderVec, timeVec)
%msgbox();