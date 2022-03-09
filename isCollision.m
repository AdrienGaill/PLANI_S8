function collision = isCollision( obj1 , obj2 ) 
    
% obj1 and obj2 are matrixes composed of segments

N1 = size(obj1)(1);
N2 = size(obj2)(1);
collision = false ;
intersectMat = lineSegmentIntersect(obj1, obj2).intAdjacencyMatrix

    for i = 1 : N1
        for j = i+1 : N2
            collision = (intersectMat(i, j) == 1);
            if collision
                return ;
            end
        end
    end
end