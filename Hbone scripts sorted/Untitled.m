syms xy xz yz phi theta psi

R_xyz_intr = [1,0,0; 0, cos(yz), -sin(yz);0, sin(yz), cos(yz)]....
    * [cos(xz), 0, sin(xz); 0,1,0; -sin(xz), 0, cos(xz)] * [cos(xy),-sin(xy), 0;sin(xy),cos(xy),0; 0,0,1]

R_yxz_intr = [cos(xz), 0, sin(xz); 0,1,0; -sin(xz), 0, cos(xz)]

xy = 25.77*pi/180;
yz = 2.8*pi/180;
xz = -39.6*pi/180;


%Rx Ry Rz -> Rz Ry Rx (extr)
%Ry(xy) Rz(-xz) Rx(yz) (extr, Tanyas axes)

R_orig_new_axis= Rx(yz) * Rz(-xz) * Ry(xy)
R_needed_new_axis = Rx(phi) * Ry(theta) * Rz(psi)
phi = rad2deg( yz)
theta = rad2deg( asin(cos(xz) * sin(xy))) %+pi
psi = rad2deg( atan(-sin(xz)/(cos(xy)*cos(xz))))
