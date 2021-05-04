function Q_Learning_ROI(str1,str2)
% Training for swarm within ROI

%% Initialize the world
[NumberStateRows,NumberStateCols,flag_num,agent_num,obstacle_num,flag_position,obstacle_position,agent_position,ROI_area] = world_init_swarm(str1,str2);
% 
% % Filename
t = datetime('now');
str = datestr(t,'yyyymmdd_HHMMSS');
Folder = strcat('../../results/');
filename_Q_matrix_ROI = strcat(Folder,'Q_matrix_ROI',str,'_',str1,'_',str2,'.mat');
filename = strcat(Folder,'data_train_in_ROI_',str,'_',str1,'_',str2,'_flag');

%% Parameters
max_episode = 10000;
max_step = 1000;
gamma = 0.9;
lr = 0.1;

% Epsilon for ROI
epsilon_min = 0.05;
epsilon_decay_ROI = 0.995;

%Q values matrix
% In ROI training, 1 agent starts at lower left corner of the ROI (not at the left corner of the map) learning to reach each flag position.
% training will run N times with N is the number of flags to obtain the
% policy for each flag location. 
% When an agent in the future is assigned to a flag, it selects the 4th dimension of the matrix
Q_matrix_ROI = zeros(NumberStateRows,NumberStateCols,4,flag_num); % Q-matrix for ROI including 4 dimensions: row,column,4 actions, and flag ID.

for i = 1:flag_num
     
    %% Run
    episode = 1;
    epsilon_ROI = 1;
    time_complete = 0;
    filename_save = strcat(filename,'_',num2str(i),'.csv');
      
    while episode <= max_episode 
    %World Reset
%     [agent_position] = world_reset(agent_position);
    %Transfer to RBF
        tic;
        reward = 0;
        step = 0;    
        currentState = [ROI_area, ROI_area];
        while step < max_step
                           
            % Select action
            next_action = action_selection_ROI(currentState,Q_matrix_ROI,i,epsilon_ROI);                                          
            % Update the state
            [nextState,collect] = state_update_swarm_ROI(currentState,next_action, NumberStateRows, NumberStateCols, ROI_area, flag_position, i);
            % Check if the goal is reached and calculate reward               
            [reward] = reward_calc_swarm_ROI(collect);
            % Update Q-matrix of corresponding flag
            [Q_matrix_ROI] = Qvalues_update_ROI(currentState, nextState, next_action, i,  Q_matrix_ROI, reward, gamma, lr); 
                                   
            % Update params
            reward = reward + reward*gamma^step;
            % Update state  
            currentState = nextState;
            % Update step and data
            step = step + 1;
            
            if collect == 1
                break;                 
            end    
                         
        end
       
        % Update episode and epsilon
        
        if epsilon_ROI > epsilon_min
            epsilon_ROI = epsilon_ROI * epsilon_decay_ROI;
        end
        episode_time = toc;
        time_complete = time_complete + episode_time;
    
        %% Save data
    
        array = zeros(1,5);
        array(1) = episode;
        array(2) = reward;
        array(3) = step;  
        array(4) = epsilon_ROI;
        array(end) = time_complete;
        dlmwrite(filename_save,array,'delimiter',',','-append');
        
        fprintf('Episode %d : reward = %.4f, step = %d. \n', episode, reward, step)
        episode = episode + 1;       
    end  
    
end    

save(filename_Q_matrix_ROI,'Q_matrix_ROI');
fprintf('Training Q_matrix_ROI completed! \n')
