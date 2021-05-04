%%  Get the directories of the data
% Must create folders for different data types in local computer before running this code
Folder_ROI = 'Directory containing all "data_train_in_ROI...csv" files goes here';
Folder_share_16 = 'Directory containing all "episode_swarm..._SQL-SIE.csv" files with 16 agents goes here';
Folder_share_4 = 'Directory containing all "episode_swarm..._SQL-SIE.csv" files with 4 agents goes here';
Folder_share_9 = 'Directory containing all "episode_swarm..._SQL-SIE.csv" files with 9 agents goes here';
files_share_16 = dir(Folder_share_16);
files_share_16 = {files_share_16(not([files_share_16.isdir])).name};
files_share_4 = dir(Folder_share_4);
files_share_4 = {files_share_4(not([files_share_4.isdir])).name};
files_share_9 = dir(Folder_share_9);
files_share_9 = {files_share_9(not([files_share_9.isdir])).name};

%% Set up the index
M = length(files_share_16);
episode_max = 10000;

%% Read and extract data 

% Read and extract data from share Q-learning folder
array_s_16 = zeros(M,episode_max);
% time_s = zeros(M,episode_max);
for i = 1:M
    F1 = csvread(strcat(Folder_share_16,files_share_16{i}));
    for j = 1:episode_max
        array_s_16(i,j)= max([F1(j,3),F1(j,5),F1(j,7),F1(j,9),F1(j,11),F1(j,13),F1(j,15),F1(j,17),F1(j,19),F1(j,21),F1(j,23),F1(j,25),F1(j,27),F1(j,29),F1(j,31),F1(j,33)]);
        array_s_16(i,j) = min([array_s_16(i,j), 1000]);
    end
    % time_s(i,:) = F1(:,end)';
end

% Read and extract data from no-share-decompose Q-learning folder
array_s_4 = zeros(M,episode_max);
% time_n_a = zeros(N,episode_max);
for i = 1:M
    F2 = csvread(strcat(Folder_share_4,files_share_4 {i}));
    for j = 1:episode_max
        array_s_4(i,j)= max([F2(j,3),F2(j,5),F2(j,7),F2(j,9)]);
        array_s_4(i,j) = min([array_s_4(i,j), 1000]);
    end
%     time_n_a(i,:) = F2(:,end)';
end

array_s_9 = zeros(M,episode_max);
for i = 1:M
    F3 = csvread(strcat(Folder_share_9,files_share_9{i}));
    for j = 1:episode_max
        array_s_9(i,j)= max([F3(j,3),F3(j,5),F3(j,7),F3(j,9),F3(j,11),F3(j,13),F3(j,15),F3(j,17),F3(j,19)]);
        array_s_9(i,j) = min([array_s_9(i,j), 1000]);
    end
    % time_s(i,:) = F1(:,end)';
end

%% Process data
mean_array_s_16 = mean(array_s_16,1);
mean_array_s_4 = mean(array_s_4,1);
mean_array_s_9 = mean(array_s_9,1);
% mean_array_ROI = reshape(mean(array_ROI,1),episode_max_ROI,4);
%% Plot

% Figure comparing share and no share Q-learning
figure
hold on
% sz = 9;
plot(1:episode_max,log10(mean_array_s_16),'r')
plot(1:episode_max,log10(mean_array_s_9),'b','Marker','d','MarkerIndices',1:200:episode_max,'MarkerSize',10)
plot(1:episode_max,log10(mean_array_s_4),'Color',[0 0.5 0],'Marker','o','MarkerIndices',1:200:episode_max,'MarkerSize',10)
% legend('16 Agents','9 Agents','4 Agents')
xlabel('Episodes')
ylabel('Maximum number of steps (log10)')
% title('Comparison between average swarm steps in shared knowdledge and no shared knowledge schemes')
% ylim([0 log10(1000)])
hold off
