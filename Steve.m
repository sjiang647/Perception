close all
clear all
try
%% Load Screens

Screen('Preference', 'SkipSyncTests', 1);
[window, rect] = Screen('OpenWindow', 0,[]);
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); % allowing transparency in the photos

HideCursor();
window_w = rect(3); % defining size of screen
window_h = rect(4);

cd('./Stimuli'); %Changed to './stimuli' ./ means current folder. -Norick

%% Reading the Transparency Mask

Mask_Plain = imread('./black_new.png'); %Load black circle on white background.  -Norick
Mask_Plain = 255-Mask_Plain(:,:,1); %Invert black/white? Why not fix the circle in the first place? -Norick

%% Loading Stimuli

% tid = zeros(1,49); %Initializing this is unecessary. Remove it. -Norick 
for i = 1:49
    tmp_bmp = imread(sprintf('%d.png',i)); %Changed to use sprintf. Read in images 1:49.png in order -Norick
    tmp_bmp(:,:,4) = Mask_Plain; %Apply mask (eliminate background) -Norick
    tid(i) = Screen('MakeTexture', window, tmp_bmp); %Handles to each image in order? Images drawn onto a buffer? -Norick
end

%Take size of last image (they're all equal, any one will do) -Norick
w_img = size(tmp_bmp,2); % image width 
h_img = size(tmp_bmp,1); % image height

%% Creating Grid Positions

xStart = window_w*0.25;
xEnd = window_w*0.75;
yStart = window_h*(1/3);
yEnd = window_h*(2/3);
nRows = 3;
nCols = 6;
% enter in your starting and ending coordinates and how many rows and
% columns you want in your grid pattern

[x,y] = meshgrid(linspace(xStart ,xEnd ,nCols), ...
    linspace(yStart ,yEnd ,nRows));
% this will output the x & y coordinates in a symmetrical grid pattern

% combining all the positions into one matrix
xy_rect = [x(:) '-w_img/2; y(:)'-h_img/2; x(:)'+w_img/2; y(:)'+h_img/2];

%% Displayinls``````~`m;amrfsajsdf;ljasd;fljasfdas]-0da]-kg the chosen in a square

num_oranges = size(x,1)*size(x,2); % total number of display points for the grid
%randedible_oranges = randsample(1:24, num_oranges); % selecting random non-moldy oranges
%randmoldy_oranges = randsample(25:49, num_oranges); %selecting random moldy oranges
rand_oranges = randsample(1:49, num_oranges); % selecting random oranges

Screen('DrawTextures', window, tid(rand_oranges), [], xy_rect);

Screen('Flip', window); %Make what we've drawn on the buffer visible. -Norick
KbWait %Wait until a keypress to continue.
-Norick

Screen('CloseAll');
cd ..  %Added. Go back to original folder. -Norick
catch
    Screen('CloseAll');
    cd ..
end