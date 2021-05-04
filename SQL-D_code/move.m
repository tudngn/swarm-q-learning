function temp =  move(currentState,next_action)
% Get the position of the current state
currentCol = currentState(1);
currentRow = currentState(2);

% Compute next position
switch(next_action)
    case 0
        temp = currentState;
    case 1
        temp = [currentCol, currentRow + 1]; % move up
    case 2
        temp = [currentCol, currentRow - 1]; % move down
    case 3
        temp = [currentCol - 1, currentRow]; % move left
    case 4
        temp = [currentCol + 1, currentRow]; % move right
end