%Code which gives the side view of the field

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

[X,Y] = meshgrid(-0.025:0.0005:0.025);
Y = Y + 3.85e-2;%3.85e?2 is the height of the bowl
Z = 0;%boundaries are changed
sz = size(X);
P = zeros(sz(1));
P2 = zeros(sz(1));
for ss = 1:sz(2)
    for dd = 1:sz(1)
        % Here , Y and Z are interchanged to flip the plot in to xz plane
        P(ss, dd) = abs(real(calcFieldAt(X(ss, dd), Z, Y(ss, dd) , ps)));
    end
end

surf(X,Y,P);
view(2);
colormap hot
shading interp
axis equal;
title('xz plane')
h = colorbar;
title(h, 'Pressure (au)','fontweight','bold')
set(h,'YTick',[])
xlabel('x-axis (m)','fontweight','bold');
ylabel('z-axis (m)','fontweight','bold');
axis([-0.025 0.025 3.85e-2-0.025 3.85e-2+0.025])