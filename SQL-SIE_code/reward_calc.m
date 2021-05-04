function [reward,stop] = reward_calc(inROI,collide)
%% Function computes reward based on the next state after the state transition. 
%given the information of event in pMatrix
% Input: event (none,collect flag, reach goal); flag: number of flags
% collected; numFlags: total number of flags in the grid-world
% output: the reward of the transition
%%
stop = 0;
reward_1 = 0;

% Reward based on collision
if collide == 1
    reward_1 = -1;
end

if inROI
    reward = 10;
    stop = 1;
else
    reward = reward_1;    
end



