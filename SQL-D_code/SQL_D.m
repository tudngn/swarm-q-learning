function SQL_D(str1,str2)

%% Initialize the world
[NumberStateRows,NumberStateCols,flag_num,agent_num,obstacle_num,flag_position,obstacle_position,agent_position,ROI_area] = world_init_swarm(str1,str2);


% Filename
t = datetime('now');
str = datestr(t,'yyyymmdd_HHMMSS');
Folder = strcat('../../results/');
filename_episode = strcat(Folder,'episode_swarm',str,'_',str1,'_',str2,'_SQL-D.csv');
filename_step = strcat(Folder,'step_swarm',str,'_',str1,'_',str2,'_SQL-D.csv');

%% Parameters
max_episode = 10000;
max_step = 1000;
gamma = 0.9;
lr = 0.1;
% lr = 0.005;
% lr_update_iteration = 100;

% Epsilon greedy function
epsilon = 1;
epsilon_decay = 0.999;
epsilon_min = 0.05;
epsilon_ROI = 0;

%Q values matrix
Q_matrix_ROI = importdata('../../data/Q_matrix_ROI20200711_021531_50_4.mat');
Q_matrix = zeros(NumberStateRows,NumberStateCols,4,agent_num); %location-states, 4-actions, 4-agents

%% Run
episode = 1;
total_reward = zeros(agent_num,max_episode);
total_step = zeros(agent_num,max_episode);
time_complete = 0;


% sz = 50;
% 
% % plot environment & record video
% fHandler = figure(1);
% fHandler.Color = 'white';
% fHandler.MenuBar = 'none';
% fHandler.ToolBar = 'none';
% fHandler.Name = 'Swarm Formation Initialization - SQL-D Method';
% fHandler.NumberTitle = 'on';
% fHandler.WindowState = 'fullscreen';
% %% Draw
% 
% scatter(obstacle_position(:,1),obstacle_position(:,2),sz,'Marker','s','MarkerEdgeColor','m',...
%                   'MarkerFaceColor','m')
% hold on
% scatter(flag_position(:,1),flag_position(:,2),sz,'Marker','d','MarkerEdgeColor','r',...
%                   'MarkerFaceColor','r')
% scatter(agent_position(:,1),agent_position(:,2),sz,'MarkerEdgeColor','b',...
%                   'MarkerFaceColor','b')              
%               
% rectangle('Position',[43 43 7 7],'EdgeColor','r') 
% xlim([0 50])
% ylim([0 50])
% grid on
% grid minor
% set(gca,'TickLength',[0 0])
% 
% hold off
% 
% % Make video
% M(1)=getframe; % makes a movie frame from the plot

while episode <= max_episode
    
    tic
    episode_reward = zeros(agent_num,1);
    episode_step = zeros(agent_num,1);  
    step = 1;
    ROI_step = 0;
    currentState = agent_position;
    agent_stop = zeros(agent_num,1);
    flag_status = ones(1,flag_num);
    
    % array for saving data for every STEP: for later analysis and
    % visualization: each agent (row,column,did_they_stop/reach_target?)
    array_step = zeros(1,agent_num*3+1);
    array_step(1) = episode;
    for i = 1:agent_num
        array_step(3*i-1) = agent_position(i,1);
        array_step(3*i) = agent_position(i,2);
        array_step(3*i+1) = agent_stop(i);
    end
    dlmwrite(filename_step,array_step,'delimiter',',','-append');
    
    while step <= max_step  
     
        break_id = 1;
               
        for i = 1:agent_num
            if agent_stop(i) == 0 % outside ROI
                next_action = action_selection_swarm(currentState(i,:), Q_matrix, i, epsilon);
                % Update the state
                [nextState,collide,inROI] = state_update(currentState,i,next_action, NumberStateRows, NumberStateCols, obstacle_num, obstacle_position, ROI_area);
                % Check if the goal is reached and calculate reward 
                [reward,stop] = reward_calc(inROI,collide);
                % Update Q-matrix of 1 agent
                [Q_matrix] = Qvalues_update(currentState(i,:), nextState, next_action, i,  Q_matrix, reward, gamma, lr); 
                      
                % Update params
                episode_reward(i) = episode_reward(i) + reward*gamma^episode_step(i);                       
                currentState(i,:) = nextState;
                
                % Update step and data
                episode_step(i) = episode_step(i) + 1;
            
                if stop == 1
                    agent_stop(i) = 1;
                end  
                
            elseif agent_stop(i) == 1 % inside ROI
                
                % Flag assignment
                [flagID, flag_status] = flag_assignment(currentState,Q_matrix_ROI,flag_status,flag_num);
                % Follow policy in ROI
                collect = 0;
                ROI_step = 0;
                while (collect == 0 && ROI_step < max_step)
                    next_action = action_selection_ROI(currentState(i,:),Q_matrix_ROI,flagID,epsilon_ROI);
                    [nextState,collect] = state_update_swarm_noshare(currentState(i,:),next_action, NumberStateRows, NumberStateCols, flagID, flag_position, ROI_area);
                    currentState(i,:) = nextState;           
                    ROI_step = ROI_step + 1;
                end
                
                agent_stop(i) = 2;
            end
        
            total_reward(i,episode) = episode_reward(i);
            total_step(i,episode) = episode_step(i) + ROI_step;
                  
        end 

        % array for saving data for every STEP: for later analysis and
        % visualization: each agent (row,column,did_they_stop/reach_target?)
        array_step = zeros(1,agent_num*3+1);
        array_step(1) = episode;
        for i = 1:agent_num
            array_step(3*i-1) = currentState(i,1);
            array_step(3*i) = currentState(i,2);
            array_step(3*i+1) = agent_stop(i);
        end
        dlmwrite(filename_step,array_step,'delimiter',',','-append');   
    
% % plot environment & record video
%        if (episode == 5000)
%         fHandler = figure(1);
%         fHandler.Color = 'white';
%         fHandler.MenuBar = 'none';
%         fHandler.ToolBar = 'none';
%         fHandler.Name = 'Swarm Formation Initialization - SQL-D Method';
%         fHandler.NumberTitle = 'on';
%         fHandler.WindowState = 'fullscreen';
%         %% Draw
%         scatter(obstacle_position(:,1),obstacle_position(:,2),sz,'Marker','s','MarkerEdgeColor','m',...
%                           'MarkerFaceColor','m')
%         hold on
% 
%         
%         scatter(flag_position(:,1),flag_position(:,2),sz,'Marker','d','MarkerEdgeColor','r',...
%                           'MarkerFaceColor','r')
%         scatter(currentState(:,1),currentState(:,2),sz,'MarkerEdgeColor','b',...
%                           'MarkerFaceColor','b')
%         rectangle('Position',[43 43 7 7],'EdgeColor','r') 
%         xlim([0 50])
%         ylim([0 50])
%         grid on
%         grid minor
%         set(gca,'TickLength',[0 0])
% 
%         hold off
% 
%         % Make video
%         M(step)=getframe; % makes a movie frame from the plot
%         
%        end

        % Break the steps
        for i = 1:agent_num
            if agent_stop(i) ~=2
                break_id = 0;
            end
        end
        
        % Break the episode
        if break_id == 1
            break;
        else
            step = step + 1;
        end
        
        
    end
    
    % Update the epsilon
    if epsilon > epsilon_min
        epsilon = epsilon * epsilon_decay;
    end
            
   
    episode_time = toc;
    time_complete = time_complete + episode_time;
    
    % array for saving data for every EPISODE: for later analysis: each agent (total_reward,total_step)
    array = zeros(1,agent_num*2+3);
    array(1,1) = episode;
    for i=1:agent_num
        array(1,2*i) = total_reward(i,episode);
        array(1,2*i+1) = total_step(i,episode); 
        
%         array(1,4*i+1) = episode_temperature(i);
    end 
    array(1,end-1) = epsilon;
    array(1,end) = time_complete;
    dlmwrite(filename_episode,array,'delimiter',',','-append');
    fprintf('Episode %d : step = %d. \n', episode, max(total_step(:,episode)))
    % Increase episode number
    episode = episode + 1;
end

% MyMovie = VideoWriter('SQL-D-16-Ep5000.avi');
% open(MyMovie);
% writeVideo(MyMovie,M);
% close(MyMovie);
fprintf('Training swarm with SQL-D algorithm completed! \n')