function [reward] = reward_calc_swarm(collide,collect)
%% Function computes reward based on the next state after the state transition. 
%given the information of event in pMatrix
% Input: event (none,collect flag, reach goal); flag: number of flags
% collected; numFlags: total number of flags in the grid-world
% output: the reward of the transition
%%
reward_1 = 0;
reward_2 = 0;
reward_3 = 0;


% Reward based on collision
if collide == 1
    reward_2 = -1;
end

if collect == 1
    reward_3 = 10;
end

reward = reward_1 + reward_2 + reward_3;    




