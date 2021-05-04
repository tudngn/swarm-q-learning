function next_action = action_selection_swarm(currentState, Q_matrix, agentID, epsilon)
%% The functions output the action according to epsilon-greedy
% If epsilon is 1, the probability of all actions is
% equal. If epsilon approaches to 0, the policy is totally greedy.
%%

% Epsilon Greedy
Q_values = Q_matrix(currentState(1),currentState(2),:,agentID);
temp = rand;
% Choose action based on epsilon-greedy
if temp >= epsilon 
    [~,next_action] = max(Q_values);
else
    next_action = randi(4);
end

