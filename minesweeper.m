%Minesweeper Algorithm

%What do you call a monkey in a minefield? A ba-boom!

%           ,--.!,    w  c(..)o   (
%        __/   -*-     \__(-)    __)
%      ,d08b.  '|`         /\   (
%      0088MM             /(_)___)
%      `9MMP'             w /|
%                           | \ 
%                           m  m


%Number Key: 0,1,...,8 - number of bombs around clicked space
%            55 - flag
%            66 - bomb
%            88 - zero that has been clicked
%            99 - unrevealed space to computer

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%First, generate the key, assign values to squares in key
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
format long;

%Uncomment/comment to change difficulty

matrixS = 9; %Easy difficulty size
%matrixS = 16; %Medium difficulty size
numBombs=10; %Number of bombs on the board for easy
%numBombs=40; %Number of bombs on the board for medium
bombs = []; %Matrix to hold locations of bombs


N = 10^6; %number runs, recommended to lower this number when increasing difficulty
numberWins  = 0; %initial number of wins
numberTurns = [];%for histogram, append how many turns it takes a strategy to win

tic

%while numberWins < N %uncomment this line for MonteCarlo Histogarm
for n = 1:N %uncomment this line to calculate probability
    bombs = []; %refresh bomb coordinates each run
    key = zeros(matrixS); %refresh key each run
    
    for i = 1:numBombs
        bombX = randi(matrixS); %Generate random coordinates for a bomb
        bombY = randi(matrixS);
        if key(bombX,bombY) == 66 %Make sure bombs do not overlap
            while key(bombX,bombY) == 66 
                bombX = randi(matrixS);
                bombY = randi(matrixS);
            end
        end
        
        bombs = [bombs; bombX,bombY]; %Append each bomb's coordinates to our array
        key(bombX,bombY) = 66; %Assign bomb to its space on the board
        
        if size(bombs,1) > numBombs 
            disp('Too many coordinates')
        end
        
    end
    
    for x = 1:matrixS %X is row index
        for y = 1:matrixS %Y is the column index
            key(x,y) = numAssign(key,x,y,matrixS); %Assign numbers to every space in the key 
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Generate Computer's blank board
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    compBoard(1:matrixS, 1:matrixS) = 99; %99 represents unclicked squares
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Strategy 1: Strategy based on  clicking random spaces, uncomment to run
    
     %[outcome] = randomWins(key,compBoard,bombs,matrixS);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Strategy 2: Flagging strategy based off of Luca's play style, uncomment to run
    
    [outcome,turns] = lstrat(key,compBoard,bombs,matrixS);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if outcome == 1 %if the outcome of a simulation is a win
        numberWins = numberWins + 1; %increment our number of wins
        numberTurns = [numberTurns; turns]; %append to our array of turns
    end
end
toc

% Probability = numberWins / N %Uncomment if running to find probability
 histogram(numberTurns,'Normalization','pdf')  %Histogram frequency distribution of number of clicks to win
