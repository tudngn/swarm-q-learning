function [nextState,collect] = state_update_swarm_noshare(currentState,next_action, NumberStateRows, NumberStateCols, flagID, flag_position, ROI_area)
%% Function computes next state index based on the current state and the action taken, 
%given the information of column and row positions in pMatrix
% Input: current state (id), action(1,2,3,4) = [up,down,left,right], and
% pMatrix (Column position, Row position, object in the cell)
% output: the id of next state

temp =  move(currentState,next_action);

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





