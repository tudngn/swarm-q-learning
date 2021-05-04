function [reward] = reward_calc_swarm_ROI(collect)
%% Function computes reward based on the next state after the state transition. 
%given the information of event in pMatrix
% Input: event (none,collect flag, reach goal); flag: number of flags
% collected; numFlags: total number of flags in the grid-world
% output: the reward of the transition
%%
reward = 0;
if collect == 1
    reward = 1;
end

 




