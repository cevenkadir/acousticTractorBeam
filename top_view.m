%Code which gives the top view of the pressure field at z = 5.3cm plane

R = 54.3e-3;

% angles of lower and upper transducers with respect to z?axis
ang1 = 39.4;
ang2 = 60.8;

% positions of the transducers ( heigth and distance from the center line )
z1 = R*(1-cosd(ang1));
z2 = R*(1-cosd(ang2));

r1= R*sind(ang1);
r2= R*sind(ang2);

don= 70;

%the following part determines the positions and phases of transducers
%lower part
for i = 1:10
    ps(i).x = r1*cosd(i*36);
    ps(i).y = r1*sind(i*36);
    ps(i).z = z1;
    ps(i).amp = 1;
    
    if i <= 5
        ps(i).phase = 0;
    else
        ps(i).phase = pi;
    end
    
    x_0 = ps(i).x;
    y_0 = ps(i).y;
    
    %an additional rotational effect to fix the angle of the plot
    ps(i).x = x_0*cosd(don) - y_0*sind(don);
    ps(i).y = x_0*sind(don) + y_0*cosd(don);
end

%upper part
ii = i+1;
iii = i;
for i = i+1:i+16
    if ~any(i-iii == [4 6 8 12 14 16]) %excluded transducers
        ps(ii).x = r2*cosd(i*22.5);
        ps(ii).y = r2*sind(i*22.5);
        ps(ii).z = z2;
        ps(ii).amp = 1;
        
        if ii >= 16
            ps(ii).phase = 0;
        else
            ps(ii).phase = pi;
        end
        
        
    x_0 = ps(ii).x;
    y_0 = ps(ii).y;
    
    ps(ii).x = x_0*cosd(don) - y_0*sind(don);
    ps(ii).y = x_0*sind(don) + y_0*cosd(don);
        
        ii=ii+1;
    end
end

%calculation part
P0 = 0.17;
c_s = 29;
omega = (2*pi)*(40e3);
k = omega / 343;
ph = pi;

[X,Y] = meshgrid(-0.025:0.0005:0.025);

Z=53e-3;
sz = size(X);
P = zeros(sz(1));
P2 = zeros(sz(1));
for ss = 1:sz(2)
    for dd = 1:sz(1)
        P(ss, dd) = abs(real(calcFieldAt(X(ss, dd), Y(ss, dd), Z , ps)));
    end
end

%plotting part
surf(X,Y,P);
view(2);
colormap hot
shading interp
axis equal;
title('plane of z = 0.053 m')
h = colorbar;
title(h, 'Pressure (au)','fontweight','bold')
set(h,'YTick',[])
xlabel('x-axis (m)','fontweight','bold');
ylabel('y-axis (m)','fontweight','bold');
axis([-0.025 0.025 -0.025 0.025])