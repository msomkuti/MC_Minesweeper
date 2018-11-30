function [compBoard,key] = cascade1(key,compBoard,zerosAround,matrixS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%cascade1 acts a container where recursion can happen. This function is
%only called when the computer clicks on a zero. 

%Since there are no bombs around the input space, it immediately reveals 
%the 8 squares surrounding it. If any of these 8 squares are also zeros, 
%then the coordinates for these new zeros are appended to the array 
%zerosAround. This recursive process of revealing squares (and appending the 
%coordinates of new zeros) occurs until the computer cannot find any more
%new zeros that are within the 1 square perimiter of zeros that have
%already been checked. 


% checker - get good square values around original zero clicked
% revealSquares - reveal squares around original zero
% zerosInSquare - create array of zeros in 8 square perimeter of original zero
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i=1;
a=size(zerosAround,1); %the number of rows/entries in zeros around

while i <= a %While there are zeros being found
    if i > a %if our index is greater, reset
        i=1;
    end
    x = zerosAround(i); %get first coordinate of selected zero
    y = zerosAround(i,2); %get second coordi nate
    key(x,y) = 88; %record that we have plugged the zero into the following functions, and 
    
    [area8X1, area8Y1] = checker(x,y,matrixS); %get correct x,y coordinates for selected 0
    compBoard = revealSquares(key,compBoard,area8X1,area8Y1); %reveal squares around selected 0 
    [zerosAround, key] = zerosInSquare(key,area8X1,area8Y1,zerosAround); % return coordinates of new 0's found
    i=i+1; %incremend our index
    a=size(zerosAround,1); %update number of new zeros found
end
return
