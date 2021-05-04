# swarm-q-learning
The code for Swarm Q-learning method introduced in research paper: "Swarm Q-learning With Knowledge Sharing Within Environments for Formation Control" in 2018 International Joint Conference on Neural Networks (IJCNN) (pp. 1-8). IEEE.

A formation is a geometric shape that a group of agents spatially organizes themselves into and maintains over time. Swarm Q-Learning (SQL) is a tabular multi-agent reinforcement learning algorithm designed to solve formation control problems. We modify SQL by allowing agents to exchange knowledge they have learnt within the same environment and introduce the Swarm Q-Learning with knowledge Sharing wIthin an Environment (SQL-SIE). The algorithm is tested on a task where a swarm of robots, initially scattered in one side of the environment, needs to navigate through obstacles until they reach their initial positions in the formation within a region of interest.


%% To run SQL-D and SQL-SIE algorithms:
1. Go to folder "Q-learning_ROI_code"
2. Run main.m, there will be a file named "Q_matrix_ROIxxx.mat" is created.
3. Go to folder "SQL-D" or "SQL-SIE"
4. In code file "SQL_D.m" or "SQL_SIE.m", change the directory of the 
"Q_matrix_ROI" (= importdata('..\..\results\Q_matrix_ROI20200710_202944_50_9.mat')) into '..\..\results\Q_matrix_ROIxxx.mat'.
5. In the same folder, run main.mat

% Note that all folders can be customized according to users' preference.
