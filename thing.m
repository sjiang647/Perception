clear all;
close all;
clc

try 
%% Load Screen
Screen('Preference', 'SkipSyncTests', 1); %turns off vsync(syncing the window frames w/ those of your monitor)

rng('Shuffle'); %rng shuffle reseeds the random number algorithm so you get a new chain of random numbers. Do this every time for rng tests

[windo, rect] = Screen('OpenWindow', 0); %"windo" is the monitor ID for the user to call, "rect" just means the window is going to be a rectangle shape. Default rect is fullscreen

Screen('BlendFunction', windo, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); %creates alpha layers for any stimuli made in the screen

HideCursor;

windo_w = rect(3);%get width of the screen(rect from when you constructed the window)
windo_h = rect(4);%get height of the screen(rect from when you constructed the window)
center_x = windo_w/2;%center of x screen
center_y = windo_h/2;%center of y screen



%% transparency mask

% img = imread('filename'); gives image in an array of pixels, showing the
% rgb or black and white values

mask = imread('./stimuli/black_new.png'); %creating mask
mask = 255-mask(:,:,1); 
% image = imread('./stimuli/1.png'); %reading stimuli
% image(:,:,4) = mask; %fourth layer for transparency values

%% Display Image
cd('Stimuli')
stimuli = zeros(1, 49);

%load textures
for i = 1:49 
image = imread([num2str(i) '.png']);
%stimuli(i) = texture;
[width, height, n] = size(image)
image(:,:,4) = mask;
stimuli(i) = Screen('MakeTexture', windo, image);
disp([num2str(100* (i/49)) ' percent loaded!']);
end
disp('loading textures is done!');
cd ..
disp(stimuli(:,:));
% Screen('Drawtexture', windo, text);
% Screen('Flip', windo);





%% random stimuli

%linspace(300, 700, 150); param: xstart, xend, n_points
%meshgrid generates two matrices, one for x one for y, with all the values
%repeating in each row and column respectively
% [x,y] = meshgrid(xRange, yRange)
% amtStimuli = 6;%amount of stimuli to be shown in the grid
% imageRadius = width/2; %half of the image length
% x = [0:imageRadius:imageRadius*((2*amtStimuli)-1)]; %creates an array of x coordinates 
% x = reshape(x,2,amtStimuli);%reshape x coordinates to separate left x coords and right x coords
% x(2,:) = x(2,:)+imageRadius;%corrects the values of the right x coordinates, which before were just the middle of the object
% points = zeros(4, amtStimuli);%initializes array of the points. 1 column = 1 point, top to bottom = top left x, top left y, bottom right x, bottom right y
% points(1,:) = x(1,:);
% points(3,:) = x(2,:);
% points(2,:) = 0;
% points(4,:) = width;
% xRange = 77.5:155:930 
% yRange = 77.5:77.5:77.5
% [x, y] = meshgrid(xRange, yRange)
% 
% points = [x(1,:)-77.5 ; y(1,:)-77.5 ; x(1,:)+77.5; y(1,:)+ 77.5]
% 
% 
% 
% 
%     chosen_stimuli = randsample(49,6);
%     Screen('DrawTextures', windo, stimuli(chosen_stimuli), [], points);
%     Screen('Flip', windo);


%% mean stimuli

% xRange = 77.5:155:1240
% yRange = 77.5:155:232.5
% 
% [x,y] = meshgrid(xRange, yRange)
% points = zeros(4, 16)
% points(1,1:8) = xRange(1,:)-77.5
% points(1,9:16) = points(1,1:8)
% points(2,:) = 0
% points(2,9:16) = 155
% points(3,:) = points(1,:)+155
% points(4,:) = 155
% points(4,9:16) = 155*2
% 
% chosen_stimuli = [12,13,14,15,16,17,18,19,21,22,23,24,25,26,27,28]; 
% Screen('DrawTextures', windo, stimuli(chosen_stimuli), [], points);
% Screen('Flip', windo);

%% Big Border

xx = 77.5:155:77.5+155*3
yy = xx

points = zeros(4,16)

points(1,1:4)=xx(1:4)-77.5
points(1,5:8)=xx(1:4)-77.5
points(1,9:12)=xx(1:4)-77.5
points(1,13:16)=xx(1:4)-77.5
points(2, 1:4) = 0
points(2, 5:8) = points(2,1:4) + 155
points(2, 9:12) = points(2,1:4) + 155*2
points(2, 13:16) = points(2,1:4) + 155*3 
points(3, :) = points(1,:)+155
points(4, :) = points(2,:)+155




chosen_stimuli = randsample(49,16);

chosen_stimuli([6,7,10,11]) = imresize(chosen_stimuli([6,7,10,11]), .5)
    Screen('DrawTextures', windo, stimuli(chosen_stimuli), [], points);
    Screen('Flip', windo);
 
KbWait;%make the program wait for a keyboard response

Screen('CloseAll');%close screen to access matlab again




catch
    Screen('CloseAll');
    rethrow(lasterror);
end;