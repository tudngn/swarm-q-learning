function [flagID, flag_status] = flag_assignment(currentState,Q_matrix_ROI,flag_status,flag_num)
% Create flag ids
flag_array = zeros(1,flag_num);
for i=1:flag_num
    flag_array(i) = i;
end 

% Remove flag ids that have been assigned
flag_array = flag_array(flag_status~=0); % remove the flags that have been assigned to an agent

% Get all Q-values of all flag dimensions available at the current state
Q_values = Q_matrix_ROI(currentState(1),currentState(2),:,flag_status~=0);
% reshape the matrix into 1-d array
Q_values = reshape(Q_values,numel(Q_values),[]);
% Find the index of max Q values
[~,idx] = max(Q_values);
idx = ceil(idx/flag_num);
flagID = flag_array(idx);
flag_status(flagID) = 0;

