function create_environment()
% Create obstacles
size_world = 50;
obstacle_num = round(0.02*size_world*size_world);
ROI_area = 45;
% obstacle_position = randi([start_area+1,size_world],obstacle_num,2);
 
%% Create Agents & flags
agent_num = 9;
flag_num = 9;
agent_position = zeros(agent_num,2); % Coordinates: (1,5); (1,2); (2,1); (5,1)

%% 16 agents:
% agent_position(1,:) = [1,16];
% agent_position(2,:) = [1,14];
% agent_position(3,:) = [1,12];
% agent_position(4,:) = [1,10];
% agent_position(5,:) = [1,8];
% agent_position(6,:) = [1,6];
% agent_position(7,:) = [1,4];
% agent_position(8,:) = [1,2];
% 
% agent_position(9,:) = [16,1];
% agent_position(10,:) = [14,1];
% agent_position(11,:) = [12,1];
% agent_position(12,:) = [10,1];
% agent_position(13,:) = [8,1];
% agent_position(14,:) = [6,1];
% agent_position(15,:) = [4,1];
% agent_position(16,:) = [2,1];

%% 9 agents:
agent_position(1,:) = [1,9];
agent_position(2,:) = [1,7];
agent_position(3,:) = [1,5];
agent_position(4,:) = [1,3];
agent_position(5,:) = [1,1];
agent_position(6,:) = [3,1];
agent_position(7,:) = [5,1];
agent_position(8,:) = [7,1];
agent_position(9,:) = [9,1];


flag_position = zeros(flag_num,2);
%% 16 flags:
% flag_position(1,:) = [44,50];
% flag_position(2,:) = [46,50];
% flag_position(3,:) = [48,50];
% flag_position(4,:) = [50,50];
% 
% flag_position(5,:) = [44,48];
% flag_position(6,:) = [46,48];
% flag_position(7,:) = [48,48];
% flag_position(8,:) = [50,48];
% 
% flag_position(9,:) = [44,46];
% flag_position(10,:) = [46,46];
% flag_position(11,:) = [48,46];
% flag_position(12,:) = [50,46];
% 
% flag_position(13,:) = [44,44];
% flag_position(14,:) = [46,44];
% flag_position(15,:) = [48,44];
% flag_position(16,:) = [50,44];


%% 9 flags
flag_position(1,:) = [46,50];
flag_position(2,:) = [48,50];
flag_position(3,:) = [50,50];
flag_position(4,:) = [46,48];
flag_position(5,:) = [48,48];
flag_position(6,:) = [50,48];
flag_position(7,:) = [46,46];
flag_position(8,:) = [48,46];
flag_position(9,:) = [50,46];


%% Creat obstacles
obstacle_position = zeros(obstacle_num,2);
i=1;

while i <= obstacle_num
    position_temp = randi([1,size_world],1,2);
    repeat = 0;             
    if position_temp(1) >= ROI_area && position_temp(2) >= ROI_area
        repeat = 1;
    end
    for j = 1:agent_num         
        if position_temp(1) == agent_position(j,1) && position_temp(2) == agent_position(j,2)
            repeat = 1;
        end
    end
    if repeat == 0
        obstacle_position(i,1) = position_temp(1);
        obstacle_position(i,2) = position_temp(2);
        i=i+1;
    end
end

filename = strcat('../data/environment_swarm_',num2str(size_world),'_',num2str(agent_num),'.mat');
save(filename,'size_world','agent_num','obstacle_position','obstacle_num','agent_position','flag_position','flag_num','ROI_area')      