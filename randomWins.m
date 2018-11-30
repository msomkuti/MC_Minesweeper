function [outcome] = randomWins(key,compBoard,bombs,matrixS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This is the function that randomly plays without paying any attention
%where it's clicking. In other words, it is playing without any strategy.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    lose = 0;%counter for number of losses
    win = 0;%counter for number of wins
    
    while lose == 0 || win ~= 1%while you haven't lost or won
        x = randi(matrixS); %chose a random space
        y = randi(matrixS);
        
        squaresLeft = []; %array of coordinates of unrevealed squares
        for r = 1:matrixS %remake matrix with coordinates left of unrevealed squares; where computer can still click 
            for s = 1:matrixS %going through entire matrix
                if compBoard(r,s) == 99 
                    squaresLeft = [squaresLeft; r,s]; % saves the coordinates of unrevealed squares
                end
            end
        end
        
        if size(squaresLeft,1) == size(bombs,1) %if the only squares left are bombs, win
            squaresLeft = sort(squaresLeft); %making sure that the coordinates can be compared
            bombs = sort(bombs);
            if squaresLeft == bombs %comparing coordinates
               outcome = 1; %if they are the same then it's a win
               return
           end
        end
        
        while compBoard(x,y) ~= 99 %want to make sure that computer does not chose already revealed space
             x = randi(matrixS); 
             y = randi(matrixS);
        end
                    
        space = key(x,y); %clicking a space 
        
        if space == 66 %if a bomb is clicked we loose
            lose = 1; 
            outcome = 0;
            return 
            
        elseif space ~= 0 %if we click on a number reveal the number
            compBoard(x,y) = space;
            
        elseif space == 0 %if we click on a zero we have to use cascade1 to make sure all the other zeros in the parameter are revealed
            key(x,y) = 88; %number 88 designates a clicked 0
            zerosAround = [x,y];
            [compBoard,key] = cascade1(key,compBoard,zerosAround,matrixS);
        end
    end
end
