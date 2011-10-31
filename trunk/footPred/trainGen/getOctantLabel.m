function label = getOctantLabel(x,y,z)

%get octant label by cases
if(x < 0 && y < 0 && z < 0)
    label = 0;
elseif(x < 0 && y < 0 && z >= 0)
    label = 1;
elseif(x < 0 && y >= 0 && z < 0)
    label = 2;
elseif(x < 0 && y >= 0 && z >= 0)
    label = 3;
elseif(x >= 0 && y < 0 && z < 0)
    label = 4;
elseif(x >= 0 && y < 0 && z >= 0)
    label = 5;
elseif(x >= 0 && y >= 0 && z < 0)
    label = 6;
elseif(x >= 0 && y >= 0 && z >= 0)
    label = 7;
end 
