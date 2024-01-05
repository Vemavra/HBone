syms xy xz yz
syms phi psi theta
R_orig = Rz(xy) * Ry(xz) * Rx(yz)
R_new = Ry(-psi) * Rz(theta)*Rx(phi)
% theta = abs(asin(cos(xz)*sin(xy)))
% 
% psi = atan2(-sin(xz), cos(xy)*cos(xz))

