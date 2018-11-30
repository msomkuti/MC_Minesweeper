function [area8X1, area8Y1] = checker(x,y,matrixS)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The checker function takes the x and y coordinates for the space clicked
%and returns two arrays: area8X1 and area8Y1. These hold the possible x & y
%coordinates of the squares in a one square radius of the
%clicked space, respectively.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

area8X = [x x+1 x-1]; %possible x,y values for squares around clicked space
area8Y = [y y+1 y-1];
area8X1 = []; %list for squares around space that are in bounds
area8Y1 = [];

for i = 1: length(area8X) %for every possible x values
    if area8X(i) <= matrixS && area8X(i) >= 1 %check that square's x 
                                              %values fall in the matrix 
                                              
       area8X1 = [area8X1;area8X(i)]; %append in-bound x values                                 
    end
end

for i =1: length(area8Y) %repeat for possible y values
    if area8Y(i) <= matrixS && area8Y(i) >= 1  
       area8Y1 = [area8Y1;area8Y(i)];
    end
end
end