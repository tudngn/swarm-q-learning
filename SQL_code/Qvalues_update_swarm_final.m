function [Q_matrix_new] = Qvalues_update_swarm_final(finalState, final_action, agent_num,  Q_matrix, reward_team, lr)
%% Function update Q-values of a transition given the reward. 
% Input: currentState(id), current Q matrix, reward received after
% transition, current step taken, discount factor, learning rate
% collected; numFlags: total number of flags in the grid-world
% output: the reward of the transition
%%
Q_matrix_new = Q_matrix;
% Extract the current Q-values of state-action pair from Q matrix

for i = 1:agent_num
    if final_action(i) ~= 0
        Q_value = Q_matrix(finalState(i,1),finalState(i,2),final_action(i),i);
        Q_target = reward_team(i);
        % Update Q matrix
        Q_matrix_new(finalState(i,1),finalState(i,2),final_action(i),i) = (1-lr)*Q_value + lr*Q_target;
    end
end