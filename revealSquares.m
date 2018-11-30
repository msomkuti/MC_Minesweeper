function compBoard = revealSquares(key,compBoard,area8X1,area8Y1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function takes input of coordinates of the spaces in the 1-space
%radius of the zero and reveals their values to the computer, returning the
%updated computerBoard
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(area8X1) %reveal the squares around our space for every
                          %combination of coordinates in the matrix
   
    for j =1:length(area8Y1)
           compBoard(area8X1(i),area8Y1(j)) = key(area8X1(i),area8Y1(j));
    end  
end
end