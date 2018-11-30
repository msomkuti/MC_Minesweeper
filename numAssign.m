function number = numAssign(key,x,y,matrixS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function returns a number, represeting the number of bombs in a 
%1 square radius. This number is assigned to the input square's
%coordinates, and will be used to update the computer's board on click.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if key(x,y) == 66 %if the input square is a bomb, return this information
    number = 66; 
    return
end

area8X = [x x+1 x-1]; %possible x,y values for spaces around input square
area8Y = [y y+1 y-1];
area8X1 = []; %list for spaces around input that are in bounds
area8Y1 = [];

for i =1: length(area8X) %for every possible x value in 1-square radius
                         %check that square's x values are in the matrix
                         %then append in-bound x values 
    if area8X(i) <= matrixS && area8X(i) >= 1 
       area8X1 = [area8X1;area8X(i)];                                 
    end
end

for i =1: length(area8Y) %repeat for possible y values
    if area8Y(i) <= matrixS && area8Y(i) >= 1  
       area8Y1 = [area8Y1;area8Y(i)]; 
    end
end

number = 0; %number of bombs within 1-square radius

for i = 1:length(area8X1) %for every space in radius, check if the space
                          %holds a bomb, if it does, add to the value of
                          %the square's number
   
    for j =1:length(area8Y1)
        
        if key(area8X1(i),area8Y1(j)) == 66
           
            number = number + 1; 
            
        end
    end  
end