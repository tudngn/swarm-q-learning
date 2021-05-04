function [Q_matrix_new] = Qvalues_update(currentState, nextState, next_action, agentID,  Q_matrix, reward, gamma, lr)

%% Function update Q-values of a transition given the reward. 
% Input: currentState(id), current Q matrix, reward received after
% transition, current step taken, discount factor, learning rate
% collected; numFlags: total number of flags in the grid-world
% output: the reward of the transition
%%
Q_matrix_new = Q_matrix;
% Extract the current Q-values of state-action pair from Q matrix
Q_value = Q_matrix(currentState(1),currentState(2),next_action,agentID);
Q_target = reward + gamma*max(Q_matrix(nextState(1),nextState(2),:,agentID));

% Update Q matrix
Q_matrix_new(currentState(1),currentState(2),next_action,agentID) = (1-lr)*Q_value + lr*Q_target;
