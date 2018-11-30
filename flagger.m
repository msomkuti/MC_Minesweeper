function [addFlaggerTurns,compBoard,key] = flagger(number,area8X1, area8Y1,compBoard,key,matrixS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function goes through the entire board and counts the amount of bombs
%and the amount of empty squares around every revealed square. Then it 
%decides if there are any squares to be flagged or revealed. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


count99 = 0; %count unopened spaces
count55 = 0; %count flagged squares
nns = []; %array of coordinates of unrevealed spaces
addFlaggerTurns = 0; %number of clicks in flagger. We need this for the histogram

for q = 1:8 %for every possible number that a space can have, we want to flag the bombs around it
    if q == number
        
        for i = 1:length(area8X1) %reveal the squares around our space for every
                                  %combination of coordinates in the matrix
            
            for j =1:length(area8Y1)
                if compBoard(area8X1(i),area8Y1(j)) == 55 %checking to see if it's flagged
                    count55 = count55 + 1; %increase our count of flags
                    
                end
            end
        end
          
%         We were using this to make sure that we weren't flagging sguares
%         that are not bombs. 
%         if count55 > q
%             disp('MORE FLAGS THAN BOMBS')
%         end
        
        if count55 == q %need to see how many bombs are flagged around space
            %prevent flagging safe squares
            [addRevealTurns,compBoard,key] = revealFlagSquares(key,compBoard,area8X1,area8Y1,matrixS);
            addFlaggerTurns = addFlaggerTurns + addRevealTurns; %add clicks from revealFlagSquares
            continue
            
        else
            
            for i = 1:length(area8X1) %count unrevealed spaces, and append coordinates
                for j =1:length(area8Y1)
                    if compBoard(area8X1(i),area8Y1(j)) == 99 %checking to see if there's a bomb
                        x = area8X1(i);
                        y = area8Y1(j);
                        count99 = count99 + 1; %increase our count of 99s
                        nns = [nns; x,y]; %append coordinates
                    end
                end
            end
            
            if count99 + count55 == number %if the number of unrevealed spaces that may be bombs
                                            %and the number of flags, add
                                            %up to the number on our space
                for r = 1:size(nns,1) %flag spaces that might be bombs
                    compBoard(nns(r,1),nns(r,2)) = 55; %flag the square
                    addFlaggerTurns = addFlaggerTurns + 1; %count clicks
                end
            end
        end
    end
    
end
end
