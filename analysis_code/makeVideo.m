%% This code only works in local machine
function makeVideo(NumAgent,RL_method,episode)
%% Input
% Number of Agents
% NumAgent = 16;
% NumAgent = 9;
% NumAgent = 4;

% Method
% RL_method = 'SQL-SIE';
% RL_method = 'SQL-D';
% RL_method = 'SQL';

% The episode to run
% episode = a single integer between 1 and 10000
%%

% load environment configuration file
Environment = load(strcat('../../data/environment_swarm_50_',num2str(NumAgent),'.mat')) % 4, 9 or 16 agents

% Load data files
% Choose the data with name "step_swarm...csv"
[filename, path] = uigetfile('*.csv');

file = strcat(path,filename);
F = csvread(file);

% Size of objects in video
sz = 50;
% plot environment & record video
fHandler = figure(1);
fHandler.Color = 'white';
fHandler.MenuBar = 'none';
fHandler.ToolBar = 'none';
fHandler.Name = 'Swarm Formation Initialization';
fHandler.NumberTitle = 'on';
fHandler.WindowState = 'fullscreen';
%% Draw

scatter(Environment.obstacle_position(:,1),Environment.obstacle_position(:,2),sz,'Marker','s','MarkerEdgeColor','m',...
                  'MarkerFaceColor','m')
hold on
scatter(Environment.flag_position(:,1),Environment.flag_position(:,2),sz,'Marker','d','MarkerEdgeColor','r',...
                  'MarkerFaceColor','r')
scatter(Environment.agent_position(:,1),Environment.agent_position(:,2),sz,'MarkerEdgeColor','b',...
                  'MarkerFaceColor','b')              
              
rectangle('Position',[Environment.ROI_area, Environment.ROI_area, Environment.size_world + 1 - Environment.ROI_area, Environment.size_world + 1 - Environment.ROI_area],'EdgeColor','r')              
% rectangle('Position',[43 43 8 8],'EdgeColor','r') % ROI rectangle area for 16 agents
% rectangle('Position',[45 45 6 6],'EdgeColor','r') % ROI rectangle area for 9 agents 
xlim([0,Environment.size_world + 1])
ylim([0,Environment.size_world + 1])
grid on
grid minor
set(gca,'TickLength',[0 0])

hold off

% Make video
M(1)=getframe; % makes a movie frame from the plot

% video step
step = 1;
i = 1;

% Run until the end of the episode want to capture
while F(i,1) <= episode
    
    if F(i,1) == episode % if the swarm step belongs to the episode needs to be captured
        
        % initialize the state array to include all agents' states
        state = [];
        
        % Add one frame in video
        step = step + 1;
        
        % Extract the states of all agents into a matrix 
        for j = 1:NumAgent
            temp = F(i,(3*j-1):(3*j));
            state = [state;temp];
        end
        
        % plot environment & record a frame of video
       
        fHandler = figure(1);
        fHandler.Color = 'white';
        fHandler.MenuBar = 'none';
        fHandler.ToolBar = 'none';
        fHandler.Name = 'Swarm Formation Initialization - SQL Method';
        fHandler.NumberTitle = 'on';
        fHandler.WindowState = 'fullscreen';
        %% Draw
        scatter(Environment.obstacle_position(:,1),Environment.obstacle_position(:,2),sz,'Marker','s','MarkerEdgeColor','m',...
                          'MarkerFaceColor','m')
        hold on

        
        scatter(Environment.flag_position(:,1),Environment.flag_position(:,2),sz,'Marker','d','MarkerEdgeColor','r',...
                          'MarkerFaceColor','r')
        scatter(state(:,1),state(:,2),sz,'MarkerEdgeColor','b',...
                          'MarkerFaceColor','b')
        rectangle('Position',[Environment.ROI_area, Environment.ROI_area, Environment.size_world + 1 - Environment.ROI_area, Environment.size_world + 1 - Environment.ROI_area],'EdgeColor','r')              
        % rectangle('Position',[43 43 8 8],'EdgeColor','r') % ROI rectangle area for 16 agents
        % rectangle('Position',[45 45 6 6],'EdgeColor','r') % ROI rectangle area for 9 agents 
        xlim([0,Environment.size_world + 1])
        ylim([0,Environment.size_world + 1])
        grid on
        grid minor
        set(gca,'TickLength',[0 0])

        hold off

        % Make video
        M(step)=getframe; % makes a movie frame from the plot
            
    end
    
    % Scan the next data row
    i = i+1;

end
   
% Write and save the video
MyMovie = VideoWriter(strcat(RL_method,'-',num2str(NumAgent),'-Ep',num2str(episode),'.mp4'),'MPEG-4');
MyMovie.Quality = 100;
MyMovie.FrameRate = 24;
open(MyMovie);
writeVideo(MyMovie,M);
close(MyMovie);

% clear the workspace 
clear
