function [outcome,turns] = lstrat(key,compBoard,bombs,matrixS)
%This function attempts to win minesweeper by using Luca's flagging
%strategy. The win condition is that the array of flags must equal the
%array of bombs.

compBoardA = compBoard;%holds the state of the computer's board before a new space is clicked
lose = 0; %we have not yet won or lost
win = 0;
turns = 0; %record number of clicks it takes to win

while lose == 0 || win ~= 1
    
    flags = []; %array of coordinates of flags
    
    for t = 1:matrixS
        for u = 1:matrixS
            if compBoard(t,u) == 55
                flags = [flags; t,u]; %update array with flag coordinates
            end
        end
    end
    
    if size(flags,1) == size(bombs,1) %if the number of flags matches the number of bombs
        
        flags = sort(flags); %sort array of bomb and flag coordinates so they are in order
        bombs = sort(bombs);
        if flags == bombs %see if coordinates match up, if true then win!
            outcome = 1; % return our win
            %             disp('!!CONGRATS!!')
            %             compBoard %Uncomment these if you would like to see what the
            %                       %computer's board looked like when it won.
            %                       %Recommended only with small number of runs.
            %             key
            %             flags
            %             bombs
            return
        end
    end
    
    x = randi(matrixS); %generate random x,y coordinates for clicking a new space
    y = randi(matrixS);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %MAKE SURE THAT THE SAME SPACE ISNT CLICKED TWICE
    if lose == 0 || win ~= 1
        while compBoard(x,y) ~= 99
            %  disp('need new xy')
            x = randi(matrixS); %want to make sure that computer does not click an already revealed space
            y = randi(matrixS);
            
            if size(flags,1) == size(bombs,1) %if the flag coordinates match the bombs'
                flags = sort(flags); %sort array of bomb and flag coordinates so they are in order
                bombs = sort(bombs);
                %disp('breaking out win?')
                if flags == bombs %see if coordinates match up, if true then win!
                    outcome = 1; % return our win
                    %             disp('!!CONGRATS!!')
                    %             compBoard %Uncomment these if you would like to see what the
                    %                       %computer's board looked like when it won.
                    %                       %Recommended only with small number of runs.
                    %             key
                    %             flags
                    %             bombs
                    return
                end
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    space = key(x,y);
    
    turns = turns + 1; %count our successful click
    
    if space == 66
        outcome = 0; %return our loss
        %             disp('!!BOOM!!')
        %             compBoard %Uncomment these if you would like to see what the
        %                       %computer's board looked like when it lost.
        %                       %Recommended only with small number of runs.
        %             key
        %             flags
        %             bombs
        return
        
    elseif space ~= 0
        compBoard(x,y) = space;
        
    elseif space == 0 %when space == 0
        key(x,y) = 88; %record that this zero was clicked
        zerosAround = [x,y]; %it is the first zero we want to reveal spaces around
        [compBoard,key] = cascade1(key,compBoard,zerosAround,matrixS);
    end
    
    %The following while loop presents a classic recursion example
    %We want our board to flag all the possible bombs and open all safe
    %spaces, repeating this proccess until no more flags can be put down,
    %and no more spaces can be revealed. Then, we must return to clicking
    %randomly
    
    compBoardA = compBoard; %Each iteration of the while loop, this
    %variable is updated to make sure that new
    %spaces are being flagged and opened
    
    compBoardB =zeros(matrixS); %This independent variable is used to quit
    %the while loop.
    
    while compBoardB ~= compBoard %while the board can still update
        compBoardA = compBoard; %update compBoardA to the latest compBoard
        %disp('recursion')
        
        %Depending on the number of mines around a square, a space can have
        %a number between 1 and 8. We want to look at every square in the
        %board, and flag in its perimeter and reveal safe spaces
        %accordingly. See flagger, revealFlagSquares functions for more.
        
        for n= 1:8 %iterate through every number a revealed space can have
            for r = 1:matrixS %iterate through every square on compBoard
                for s = 1:matrixS
                    if compBoard(r,s) == n
                        number = n;
                        x=r;
                        y=s;
                        [area8X1, area8Y1] = checker(x,y,matrixS);
                        %get the good squares around the space
                        addFlaggerTurns = 0; %make sure clicks not going out of control
                        [addFlaggerTurns,compBoard,key] = flagger(number,area8X1, area8Y1,compBoard,key,matrixS);
                        turns = turns + addFlaggerTurns;
                    end
                end
            end
        end
        
        if compBoard == compBoardA %if compBoard does not change, this
            %means there are no more possible flags
            %or spaces to reveal without making a
            %new random click, so we exit the loop
            compBoardB = compBoard;
            %disp('exit!')
        end
    end
end
end
