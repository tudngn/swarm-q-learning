%%  Get the directories of the data
Folder_share = 'Directory containing all "episode_swarm..._SQL-SIE.csv" files with 16 agents, shared Q-matrix update every 1 episode, goes here';
Folder_share_20 = 'Directory containing all "episode_swarm..._SQL-SIE.csv" files with 16 agents, shared Q-matrix update every 20 episode, goes here';
Folder_share_50 = 'Directory containing all "episode_swarm..._SQL-SIE.csv" files with 16 agents, shared Q-matrix update every 50 episode, goes here';

files_share = dir(Folder_share);
files_share = {files_share(not([files_share.isdir])).name};
files_share_20 = dir(Folder_share_20);
files_share_20 = {files_share_20(not([files_share_20.isdir])).name};
files_share_50 = dir(Folder_share_50);
files_share_50 = {files_share_50(not([files_share_50.isdir])).name};

%% Set up the index
M = length(files_share);
episode_max = 5000;

%% Read and extract data 

% Read and extract data from share Q-learning folder
array_s = zeros(M,episode_max);
% time_s = zeros(M,episode_max);
for i = 1:M
    F1 = csvread(strcat(Folder_share,files_share{i}));
    for j = 1:episode_max
        array_s(i,j)= max([F1(j,3),F1(j,5),F1(j,7),F1(j,9),F1(j,11),F1(j,13),F1(j,15),F1(j,17),F1(j,19),F1(j,21),F1(j,23),F1(j,25),F1(j,27),F1(j,29),F1(j,31),F1(j,33)]);
        array_s(i,j) = min([array_s(i,j), 1000]);
    end
end

% Read and extract data from share_5 Q-learning folder
% array_s_5 = zeros(M,episode_max);
% % time_s = zeros(M,episode_max);
% for i = 1:M
%     F5 = csvread(strcat(Folder_share_5,files_share_5{i}));
%     for j = 1:episode_max
%         array_s_5(i,j)= max([F5(j,3),F5(j,5),F5(j,7),F5(j,9)]);
%     end
% end

% Read and extract data from share_10 Q-learning folder
% array_s_10 = zeros(M,episode_max);
% % time_s = zeros(M,episode_max);
% for i = 1:M
%     F10 = csvread(strcat(Folder_share_10,files_share_10{i}));
%     for j = 1:episode_max
%         array_s_10(i,j)= max([F10(j,3),F10(j,5),F10(j,7),F10(j,9)]);
%     end
% end

% Read and extract data from share_20 Q-learning folder
array_s_20 = zeros(M,episode_max);
% time_s = zeros(M,episode_max);
for i = 1:M
    F20 = csvread(strcat(Folder_share_20,files_share_20{i}));
    for j = 1:episode_max
        array_s_20(i,j)= max([F20(j,3),F20(j,5),F20(j,7),F20(j,9),F20(j,11),F20(j,13),F20(j,15),F20(j,17),F20(j,19),F20(j,21),F20(j,23),F20(j,25),F20(j,27),F20(j,29),F20(j,31),F20(j,33)]);
        array_s_20(i,j) = min([array_s_20(i,j), 1000]);
    end
end

% Read and extract data from share_20 Q-learning folder
% array_s_30 = zeros(M,episode_max);
% % time_s = zeros(M,episode_max);
% for i = 1:M
%     F30 = csvread(strcat(Folder_share_30,files_share_30{i}));
%     for j = 1:episode_max
%         array_s_30(i,j)= max([F30(j,3),F30(j,5),F30(j,7),F30(j,9)]);
%     end
% end


% Read and extract data from share_40 Q-learning folder
% array_s_40 = zeros(M,episode_max);
% % time_s = zeros(M,episode_max);
% for i = 1:M
%     F40 = csvread(strcat(Folder_share_40,files_share_40{i}));
%     for j = 1:episode_max
%         array_s_40(i,j)= max([F40(j,3),F40(j,5),F40(j,7),F40(j,9)]);
%     end
% end


% Read and extract data from share_40 Q-learning folder
array_s_50 = zeros(M,episode_max);
% time_s = zeros(M,episode_max);
for i = 1:M
    F50 = csvread(strcat(Folder_share_50,files_share_50{i}));
    for j = 1:episode_max
        array_s_50(i,j)= max([F50(j,3),F50(j,5),F50(j,7),F50(j,9),F50(j,11),F50(j,13),F50(j,15),F50(j,17),F50(j,19),F50(j,21),F50(j,23),F50(j,25),F50(j,27),F50(j,29),F50(j,31),F50(j,33)]);
        array_s_50(i,j) = min([array_s_50(i,j), 1000]);
    end
end


%% Process data
mean_array_s = mean(array_s,1);
% mean_array_s_5 = mean(array_s_5,1);
% mean_array_s_10 = mean(array_s_10,1);
mean_array_s_20 = mean(array_s_20,1);
% mean_array_s_30 = mean(array_s_30,1);
% mean_array_s_40 = mean(array_s_40,1);
mean_array_s_50 = mean(array_s_50,1);
% mean_array_n_d = mean(array_n_d,1);

%% Plot

% Figure comparing share at different frequency
Color = {'b','m','g','r','k','y'};
figure
hold on
plot(1:episode_max,log10(mean_array_s(2000:4000)),Color{1},'Marker','o','MarkerIndices',1:500:episode_max,'MarkerSize',10)
% plot(1:episode_max,mean_array_s_5,Color{1},'Marker','o','MarkerIndices',1:500:episode_max)
% plot(1:episode_max,mean_array_s_5,Color{1})
% plot(1:episode_max,mean_array_s_10,Color{2},'Marker','d','MarkerIndices',1:500:episode_max)
plot(1:episode_max,log10(mean_array_s_20(2000:4000)),Color{4},'Marker','d','MarkerIndices',1:500:episode_max,'MarkerSize',10)
% plot(1:episode_max,mean_array_s_30,Color{4})
% plot(1:episode_max,mean_array_s_40,Color{5})
plot(1:episode_max,log10(mean_array_s_50(2000:4000)),'Color',[0 0.5 0],'Marker','x','MarkerIndices',1:500:episode_max,'MarkerSize',10)
% plot(1:episode_max,mean_array_n_d,'Color',[0 0.5 0],'Marker','s','MarkerIndices',1:500:episode_max)
% legend('every 1 episode','every 20 episode','every 50 episode')
xlabel('Episodes')
ylabel('Maximum number of steps (log10)')
% ylim([0 log10(1000)])
hold off