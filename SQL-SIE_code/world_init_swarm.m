function [NumberStateRows,NumberStateCols,flag_num,agent_num,obstacle_num,flag_position,obstacle_position,agent_position,ROI_area] = world_init_swarm(str1,str2)
%% The function initializes a new grid world everytime called.
% Input: The number of flags, the distance of flags from goal
% Output: A matrix (number of states, 3): column position, row position, status of the cell
%%
% Read environment file:
filename = strcat('../../data/environment_swarm_',str1,'_',str2,'.mat');
% Learning parameters
file = importdata(filename);
size_world = file.size_world;
agent_num = file.agent_num;
flag_num = file.flag_num;
flag_position = file.flag_position;
obstacle_num = file.obstacle_num;
obstacle_position = file.obstacle_position;
agent_position = file.agent_position;
NumberStateRows = size_world;
NumberStateCols = size_world;
ROI_area = file.ROI_area;
