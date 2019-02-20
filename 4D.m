%Code which visualises 4D plot

%this code is almost identical to ”top_view.m”. Different parts are 
%explained below. For further explanation of codes, please go to
%”top_view .m” file.

R = 54.3e-3;
ang1 = 39.4;
ang2 = 60.8;

z1 = R*(1-cosd(ang1));
z2 = R*(1-cosd(ang2));

r1= R*sind(ang1);
r2= R*sind(ang2);

don= 70;

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
    
    ps(i).x = x_0*cosd(don) - y_0*sind(don);
    ps(i).y = x_0*sind(don) + y_0*cosd(don);
end

ii = i+1;
iii = i;
for i = i+1:i+16
    if ~any(i-iii == [4 6 8 12 14 16])
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

P0 = 0.17;
c_s = 29;
omega = (2*pi)*(40e3);
k = omega / 343;
ph = pi;

x = linspace(-0.025 ,0.025, 100);% 3 vectors with same sizes are formed
y = x;
z = linspace(0 ,0.056, 100);

[X, Y, Z] = meshgrid(x,y,z);

P = zeros(length(X(:,1)), length(Y(:,1)), length(Z(:,1)));

for xx_i = 1:length(X(:,1)) % calculate the pressure for each point in 3D
    for yy_i = 1:length(Y(:,1))
        for zz_i = 1:length(Z(:,1))
            P(xx_i, yy_i, zz_i) = abs(real(calcFieldAt(X(xx_i, yy_i, zz_i), Y(xx_i, yy_i, zz_i), Z(xx_i, yy_i, zz_i) , ps)));
            if P(xx_i, yy_i, zz_i) < 4 %this part clears the noise in the 3D plot
                X(xx_i, yy_i, zz_i) = 0;
                Y(xx_i, yy_i, zz_i) = 0;
                Z(xx_i, yy_i, zz_i) = 0;
            end
        end
     end
end

%fill the points in space with dots and add fourth dimension, i.e., the pressure
scatter3(X(:), Y(:), Z(:), 1, P(:), 'filled' )
colormap hot
shading interp
axis equal ;
title(Z)
h = colorbar;
whitebg ('black')
set(h, 'YTick', []);
title(h, 'Pressure (au)', 'fontweight', 'bold')
xlabel('x-axis (m)', 'fontweight', 'bold')
ylabel('y-axis (m)', 'fontweight', 'bold')
zlabel('z-axis (m)', 'fontweight', 'bold')
title('3D Pressure Field')
grid off