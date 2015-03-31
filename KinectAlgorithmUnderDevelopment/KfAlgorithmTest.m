if exist('Puncte','var') == 0
    %% The angles
    delta_z=57*pi/180;
    np_z=640;
    delta_x=43*pi/180;
    np_x=480;
    d_delta_z=-delta_z/2:delta_z/(np_z-1):delta_z/2;
    d_delta_x=-delta_x/2:delta_x/(np_x-1):delta_x/2;

    %% The data base of mesurements
    poza_1(:,:,1)=scene03_000deg;
    poza_1(:,:,2)=scene03_030deg;
    poza_1(:,:,3)=scene03_060deg;
    poza_1(:,:,4)=scene03_090deg;
    poza_1(:,:,5)=scene03_120deg;
    poza_1(:,:,6)=scene03_150deg;
    poza_1(:,:,7)=scene03_180deg;
    poza_1(:,:,8)=scene03_210deg;
    poza_1(:,:,9)=scene03_240deg;
    poza_1(:,:,10)=scene03_270deg;
    poza_1(:,:,11)=scene03_300deg;
    poza_1(:,:,12)=scene03_330deg;
    beta=[0,30,60,90,120,150,180,210,240,270,300,330]*pi/180;

    %% Filtering the measurements
    for k=1:12 %length(poza_1(1,1,:))
        poza=poza_1(:,:,k);
        poza=double(poza);
        poza(poza==0)=NaN;
        poza = medfilt2(poza,[2 2]);  
        [Dx,Dy]=gradient(poza);
        gradV_abs=sqrt(Dx.^2+Dy.^2);
        poza(gradV_abs > 200) = NaN;
        poza_1(:,:,k)=poza;
    end
end
%% The posiions computation
Ry=[cos(-pi),0,sin(-pi);0,1,0;-sin(-pi),0,cos(-pi)];
PPuncte=[];
nk=12; %length(poza_1(1,1,:));
figure
for k=1:12
    Puncte=[];
    poza=poza_1(:,:,k);
    for i=1:5:np_x
        for j=1:5:np_z
            y=poza(i,j);
            if isnan(y)
            else
                x=y*tan(d_delta_x(1,i));
                z=y*tan(d_delta_z(1,j));
                punct=[z;y;x];
                Puncte=[Puncte,punct];
            end
        end
    end  
  Puncte=Ry*Puncte;
  Puncte=[cos(beta(1,k)),-sin(beta(1,k)),0;sin(beta(1,k)),cos(beta(1,k)),0;0,0,1]*Puncte;
  PPuncte=[PPuncte,Puncte];
  if mod(k,3) == 0
      tmpColor = [1.0,0.4,0.4];
  elseif mod(k,3) == 1
      tmpColor = [1.0,1.0,0.5];
  else
      tmpColor = [0.5,0.3,0.5];
  end
  if k ~= 3
      plot3(Puncte(1,1:1:end),Puncte(2,1:1:end),Puncte(3,1:1:end),'.','Color', tmpColor)
  else
      % plot3(Puncte(1,1:1:end),Puncte(2,1:1:end),Puncte(3,1:1:end),'.','Color', [0.1,0.5,0.1])         
      % the first one is x, the second is y
      plot3(Puncte(1,1:1:end)+10,Puncte(2,1:1:end)+10,Puncte(3,1:1:end),'.','Color', [0.5,0.5,0.5])     
  end
  hold on
end


%% The graphical representations of the points clouds
%figure  
%plot3(PPuncte(1,1:1:end),PPuncte(2,1:1:end),PPuncte(3,1:1:end),'.')

xlabel 'X'
ylabel 'Y'
zlabel 'Z'
grid
%view(-13,36)
%colormap('gray')

%% The graphical representation of the initial image
%{
fh1 = figure();
surf(-1*poza_1(:,:,5), 'EdgeColor','none')
colormap('cool')
set(fh1,'Renderer','OpenGL')
camlight
view(0,90)
%}
