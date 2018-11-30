function [zerosAround, key] = zerosInSquare(key,area8X1,area8Y1,zerosAround)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The zerosInSquare function takes the key, area8X1, area8Y1 (see checker),
%and zerosAround. The function checks the key values of spaces in the perimeter
%of the space clicked, and if they are zeros, the coordinates are appended
%to zerosAround. The value of the appended space is then changed to 88 in
%the key so the computer does not run through the values twice. This 
%function returns an array zerosAround, and the updated key.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

for i = 1:length(area8X1) %then check if there is a zero in the surrounding squares
   
    for j =1:length(area8Y1)
        
        if key(area8X1(i),area8Y1(j)) == 0 
            x = area8X1(i);
            y = area8Y1(j); %assign x,y values to key(area8X1(i),area8Y1(j)) 
            zerosAround = [zerosAround; x,y]; 
            key(area8X1(i),area8Y1(j)) = 88; %record that a zero has been accounted for
        end
    end
end
return