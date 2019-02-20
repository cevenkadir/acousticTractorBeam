function field = calcFieldAt (pX, pY, pZ, trans )
%CALCFIELDAT This function calculates the acoustic pressure at a given
%point (x ,y , z)
field = 0;
R = 54.3e-3; %radius of the bowl
omega = (2*pi)*(40e3) ;
k = omega / 343;
for i = 1: length(trans) %trans stands for the locations of the transducers
posVec = [(pX - trans(i).x) (pY-trans (i).y) (pZ-trans(i).z)] ; %determining the position vector of the points (x ,y , z)
dist = norm(posVec) ; %length of the position vector
nor = [ trans(i).x trans(i).y trans(i). z ] - [0 0 R] ; %normal vectors of the transducers
theta = acos(sum(nor.*posVec) /(norm(nor)*norm(posVec))) ; %the angle between the transducer normal and position vector
kdPlusPhase = k * dist + trans(i).phase ; %kd+phase term for each transducer
D_f = sinc(k*(8e-3)*sin(theta)) ; %D f term
field = field + 0.7*0.17 * D_f * exp( j * kdPlusPhase) / dist ; % Complex pressure
end
end