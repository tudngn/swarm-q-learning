function draw_environment(filename)

file = importdata(filename);
agent_position = file.agent_position;
obstacle_position = file.obstacle_position;
flag_position = file.flag_position;

%% Draw
sz = 50;
figure
hold on
scatter(agent_position(:,1),agent_position(:,2),sz,'MarkerEdgeColor','b',...
              'MarkerFaceColor','b')
          
scatter(obstacle_position(:,1),obstacle_position(:,2),sz,'Marker','s','MarkerEdgeColor','m',...
              'MarkerFaceColor','m')
          
scatter(flag_position(:,1),flag_position(:,2),sz,'Marker','d','MarkerEdgeColor','r',...
              'MarkerFaceColor','r')
          
rectangle('Position',[43 43 7 7],'EdgeColor','r')          
grid on
grid minor
set(gca,'TickLength',[0 0])