%% angleInterferometry.m
% Arguments: 
% r1: Nx2 matrix of coordinates from receiver 1
% r2: Nx2 matrix of coordinates from receiver 2
% B: scalar distance between receivers
function angles = angleInterferometry(r1, r2, r3, B)
    sizeR1 = size(r1);
    numPoints = sizeR1(1);
    
    % NEED TO SORT r lists outside of the coregister function
    r1 = sort(r1)
    r2 = sort(r2)
    r3 = sort(r3)
    
    labels_r1_r2 = coregister3(r1, r2, B, 0.5*B); 
    labels_r1_r3 = coregister3(r1, r3, B, 0.5*B);
    
    minAngle = 60;
    angleRange = 60;
    
    angles = zeros(numPoints, 1);
    for i = 1:numPoints
        if (labels_r1_r2(i) > 0 && labels_r1_r2(i) <= numPoints) && (labels_r1_r3(i) > 0 && labels_r1_r3(i) <= numPoints) 
            angles(i) = calculateAngle(r1(i), r2(labels_r1_r2(i)), r3(labels_r1_r3(i)), B);
        else
            angles(i) = minAngle + angleRange/2;
        end
    end
end

