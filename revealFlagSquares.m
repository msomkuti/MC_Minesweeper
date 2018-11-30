function [addRevealTurns,compBoard,key] = revealFlagSquares(key,compBoard,area8X1,area8Y1,matrixS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function takes input of coordinates of the spaces in the 1-space
%radius of the zero and reveals their values to the computer, returning the
%updated computerBoard
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addRevealTurns = 0;

for i = 1:length(area8X1) %reveal the squares around our space for every
    %combination of coordinates in the matrix, 
    
    for j =1:length(area8Y1)
        if compBoard(area8X1(i),area8Y1(j)) ~= 55
            if compBoard(area8X1(i),area8Y1(j)) == 99
                addRevealTurns = addRevealTurns + 1; %count click, if square not already revealed
            end
            %reveal space
            compBoard(area8X1(i),area8Y1(j)) = key(area8X1(i),area8Y1(j));
            
        elseif key(area8X1(i),area8Y1(j)) == 0 %when space == 0
            if compBoard(area8X1(i),area8Y1(j)) == 99
                addRevealTurns = addRevealTurns + 1; %count click
            end
          
            x = area8X1(i);
            y = area8Y1(j);
            key(x,y) = 88; 
            zerosAround = [x,y];
             %call function for revealing the squares around a zero, as we clicked a zero
            [compBoard,key] = cascade1(key,compBoard,zerosAround,matrixS);
        end
    end
end
end