function [nextState,collide,collect,flag_status] = state_update_swarm(currentState, agent_id, next_action, NumberStateRows, NumberStateCols, obstacle_num, obstacle_position,flag_num, flag_position, flag_status)
%% Function computes next state index based on the current state and the action taken, 
%given the information of column and row positions in pMatrix
% Input: current state (id), action(1,2,3,4) = [up,down,left,right], and
% pMatrix (Column position, Row position, object in the cell)
% output: the id of next state

agent_num = size(currentState,1);
temp =  move(currentState(agent_id,:),next_action);

% Check if the position is out of bound. If true, keep the position
% unchanged
if temp(1) < 1 || temp(1) > NumberStateCols || temp(2) < 1 || temp(2) > NumberStateRows
    nextState = currentState(agent_id,:);
else
    nextState = temp;
end

% Check if the agent collide with obstacles
collide = 0;
for i = 1:obstacle_num
    if temp(1) == obstacle_position(i,1) && temp(2) == obstacle_position(i,2)
        nextState = currentState(agent_id,:);
        collide = 1;
        break;
    end
end

% Check if the next state is already occupied by another
for i = 1:agent_num
    if i ~= agent_id
        if temp(1) == currentState(i,1) && temp(2) == currentState(i,2)
            nextState = currentState(agent_id,:);
        end
    end
end

collect = 0;
for i = 1:flag_num
    if temp(1) == flag_position(i,1) && temp(2) == flag_position(i,2)
        if flag_status(i) == 0
            collect = -1;
        else
            collect = 1;
            flag_status(i) = 0;
        end       
    end
end



