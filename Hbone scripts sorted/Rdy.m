function R = Rdy( b )
R = [cosd(b), 0, sind(b); 0,1,0; -sind(b), 0, cosd(b)];
end

