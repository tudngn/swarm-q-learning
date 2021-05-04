function [nextState,collect] = state_update_swarm_ROI_assign(currentState,next_action, NumberStateRows, NumberStateCols, ROI_area, flag_position, flagID)
%% Function computes next state index based on the current state and the action taken, 
%given the information of column and row positions in pMatrix
% Input: current state (id), action(1,2,3,4) = [up,down,left,right], and
% pMatrix (Column position, Row position, object in the cell)
% output: the id of next state


% Get the position of the current state
currentCol = currentState(1);
currentRow = currentState(2);

% Compute next position
switch(next_action)
    case 1
        temp = [currentCol, currentRow + 1]; % move up
    case 2
        temp = [currentCol, currentRow - 1]; % move down
    case 3
        temp = [currentCol - 1, currentRow]; % move left
    case 4
        temp = [currentCol + 1, currentRow]; % move right
end

% Check if the position is out of bound. If true, keep the position
% unchanged
if temp(1) < ROI_area || temp(1) > NumberStateCols || temp(2) < ROI_area || temp(2) > NumberStateRows
    nextState = currentState;
else
    nextState = temp;
end

collect = 0;
if temp(1) == flag_position(flagID,1) && temp(2) == flag_position(flagID,2)
    collect = 1;                 
end



