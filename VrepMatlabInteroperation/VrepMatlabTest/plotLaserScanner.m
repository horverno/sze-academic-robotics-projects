%% Get laser scanner data

[img1,img2]=getVisionScanner(); % 1x256 1x256 double
scn = [img2,img1]; % 1x512 double

%% Plot laser scanner

x = zeros(1,512);
y = zeros(1,512);
xtmp = zeros(1,513);
ytmp = zeros(1,513);
%i = 0;
for n = 1:512
    if ((scn(n) < 0.9) && (scn(n) > 0.04))
        % 1.5 pi = 270 deg a lézer szkenner látószöge
        % 512 a lézer scanner mintavételezése
        x(n) = cos((n*1.42222222378*pi/512)) / (1-scn(n));
        y(n) = sin((n*1.42222222378*pi/512)) / (1-scn(n));
        %i=i+1;
    else
        x(n) = 0;%cos((n*1.5*pi/512)-0.25*pi) / (0.2);
        y(n) = 0;%sin((n*1.5*pi/512)-0.25*pi) / (0.2); 
        xtmp(n) = cos((n*1.5*pi/512)) * 1;
        ytmp(n) = sin((n*1.5*pi/512)) * 1;
    end

end

all = [x;y];


figure(1)
plot(scn)

%{
figure(2)
plot(x,y, 'k.', 'MarkerSize',10)
hold on 
plot(0,0, 'gx')
%}

figure(3)
fill(xtmp, ytmp, 'b')
hold on
fill(x, y, 'r')
%%