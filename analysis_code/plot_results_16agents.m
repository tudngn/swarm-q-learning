%%  Get the directories of the data
% Must create folders for different data types in local computer before running this code
Folder_ROI = 'Directory containing all "data_train_in_ROI...csv" files goes here';
Folder_share = 'Directory containing all "episode_swarm..._SQL-SIE.csv" files goes here';
Folder_noshare_decompose = 'Directory containing all "episode_swarm..._SQL-D.csv" files goes here';
Folder_noshare = 'Directory containing all "episode_swarm..._SQL.csv" files goes here';
files_share = dir(Folder_share);
files_share = {files_share(not([files_share.isdir])).name};
files_noshare_decompose = dir(Folder_noshare_decompose);
files_noshare_decompose = {files_noshare_decompose(not([files_noshare_decompose.isdir])).name};
files_noshare = dir(Folder_noshare);
files_noshare = {files_noshare(not([files_noshare.isdir])).name};
files_ROI = dir(Folder_ROI);
files_ROI = {files_ROI(not([files_ROI.isdir])).name};

%% Set up the index
M = length(files_share);
N1 = length(files_noshare);
N2 = length(files_noshare_decompose);
L = length(files_ROI);
episode_max = 10000;
episode_max_ROI = 500;

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
    % time_s(i,:) = F1(:,end)';
end

% Read and extract data from no-share-decompose Q-learning folder
array_n_d = zeros(N2,episode_max);
% time_n_a = zeros(N,episode_max);
for i = 1:N2
    F2 = csvread(strcat(Folder_noshare_decompose,files_noshare_decompose{i}));
    for j = 1:episode_max
        array_n_d(i,j)= max([F2(j,3),F2(j,5),F2(j,7),F2(j,9),F2(j,11),F2(j,13),F2(j,15),F2(j,17),F2(j,19),F2(j,21),F2(j,23),F2(j,25),F2(j,27),F2(j,29),F2(j,31),F2(j,33)]);
        array_n_d(i,j) = min([array_n_d(i,j), 1000]);
    end
%     time_n_a(i,:) = F2(:,end)';
end

% Read and extract data from no-share Q-learning folder
array_n = zeros(N1,episode_max);
% time_n = zeros(N,episode_max);
for i = 1:N1
    F3 = csvread(strcat(Folder_noshare,files_noshare{i}));
    for j = 1:episode_max
        array_n(i,j)= max([F3(j,3),F3(j,5),F3(j,7),F3(j,9),F3(j,11),F3(j,13),F3(j,15),F3(j,17),F3(j,19),F3(j,21),F3(j,23),F3(j,25),F3(j,27),F3(j,29),F3(j,31),F3(j,33)]);;
        array_n(i,j) = min([array_n(i,j), 1000]);
    end
%     time_n(i,:) = F3(:,end)';
end

%% Uncomment following code to run ROI training analysis
% Read and extract data from ROI learning folder
% array_ROI = zeros(L/4,episode_max_ROI,4);
% for i = 1:L
%     F4 = csvread(strcat(Folder_ROI,files_ROI{i}));
%     div = fix(i/4);
%     remainder = rem(i,4);   
%     if remainder == 0
%         trial = div;
%         flag = 4;
%     else
%         trial = div + 1;
%         flag = remainder;
%     end
%     for j = 1:episode_max_ROI
%         array_ROI(trial,j,flag)= F4(j,3);
%     end
% end


%% Process data
mean_array_s = mean(array_s,1);
mean_array_n = mean(array_n,1);
mean_array_n_d = mean(array_n_d,1);

std_array_s = std(array_s,1);
std_array_n = std(array_n,1);
std_array_n_d = std(array_n_d,1);

err_array_s = zeros(size(mean_array_s));
err_array_s(1:1000:episode_max) = std_array_s(1:1000:episode_max);
% err_array_s(err_array_s==-Inf) = 0;

err_array_n = zeros(size(mean_array_n));
err_array_n(1:1000:episode_max) = std_array_n(1:1000:episode_max);
% err_array_n(err_array_n==-Inf) = 0;

err_array_n_d = zeros(size(mean_array_n_d));
err_array_n_d(1:1000:episode_max) = std_array_n_d(1:1000:episode_max);
% err_array_n_d(err_array_n_d==-Inf) = 0;
% mean_array_ROI = reshape(mean(array_ROI,1),episode_max_ROI,4);
%% Plot

% Figure comparing share and no share Q-learning
figure
hold on
sz = 9;
% plot(1:episode_max,log10(mean_array_n),'b')
errorbar(1:episode_max,mean_array_n,err_array_n,'b')
% plot(1:episode_max,mean_array_n_d,'Color',[0 0.5 0],'Marker','o','MarkerIndices',1:500:episode_max)
errorbar(1:episode_max,mean_array_n_d,err_array_n_d,'Color',[0 0.5 0])
% plot(1:episode_max,mean_array_s,'r--d','MarkerIndices',1:500:episode_max)
errorbar(1:episode_max,mean_array_s,err_array_s,'r--d')
% scatter(1:episode_max,mean_array_n,sz,'b','Marker','.')
% scatter(1:episode_max,mean_array_n_d,sz,'g','Marker','x')
% scatter(1:episode_max,mean_array_s,sz,'r','Marker','d')
legend('SQL','SQL-D','SQL-SIE')
xlabel('Episodes')
ylabel('Maximum number of steps (log10)')
% title('Comparison between average swarm steps in shared knowdledge and no shared knowledge schemes')
% ylim([0 log10(1000)])
hold off

%% Uncomment following code to run ROI training analysis
% Figure learning in ROI
% figure
% hold on
% plot(1:episode_max_ROI, mean_array_ROI(:,1))
% plot(1:episode_max_ROI, mean_array_ROI(:,2))%,'Marker','o','MarkerIndices',1:50:episode_max_ROI)
% plot(1:episode_max_ROI, mean_array_ROI(:,3))%,'Marker','s','MarkerIndices',1:50:episode_max_ROI)
% plot(1:episode_max_ROI, mean_array_ROI(:,4))%,'Marker','d','MarkerIndices',1:50:episode_max_ROI)
% legend('Flag 1', 'Flag 2', 'Flag 3', 'Flag 4')
% xlabel('Episode')
% ylabel('Number of steps')
% hold off
% title('Learning collecting flags in ROI')
