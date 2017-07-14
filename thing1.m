clear all;
close all;
clc

try
    
    %% lead screen
    
    Screen('Preference', 'SkipSyncTests', 1); %turns off vsync(syncing the window frames w/ those of your monitor)
    
    rng('Shuffle'); %rng shuffle reseeds the random number algorithm so you get a new chain of random numbers. Do this every time for rng tests
    
    [windo, rect] = Screen('OpenWindow', 0); %"windo" is the monitor ID for the user to call, "rect" just means the window is going to be a rectangle shape. Default rect is fullscreen
    
    Screen('BlendFunction', windo, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); %creates alpha layers for any stimuli made in the screen
    
    HideCursor;
    
    windo_w = rect(3);%get width of the screen(rect from when you constructed the window)
    windo_h = rect(4);%get height of the screen(rect from when you constructed the window)
    center_x = windo_w/2;%center of x screen
    center_y = windo_h/2;%center of y screen

    mask = imread('./stimuli1/Mask_Plain.png'); %creating mask
    mask = 255-mask(:,:,1); 
    [xsize, ysize, zsize] = size(mask);
%     mask = imresize(mask, .25)
%     radius = windo_h/2 * .5 ;
     n = 6;
    thetaInc = 360/n;
    radius = ((xsize/2))/sind(thetaInc/2)
   
    
   
    
    thetas = [thetaInc:thetaInc:360];
    
    x_values = cosd(thetas)*radius;
    y_values = sind(thetas)*radius;
    
    
    points = [(x_values - xsize/2) + center_x; y_values - ysize/2 + center_y; x_values + xsize/2 + center_x; y_values + ysize/2 + center_y]
    
    %% load textures
    cd('Stimuli1')
    numberOfStimuli=147;
    stimuli = zeros(1, numberOfStimuli);
    
    %load textures
    for i = 1:numberOfStimuli
        image = imread([num2str(i) '.png']);
%         stimuli(i) = texture;
%         image = imresize(image, .25); 
        [width, height, nn] = size(image)
        image(:,:,4) = mask;
        stimuli(i) = Screen('MakeTexture', windo, image);
        disp([num2str(100* (i/numberOfStimuli)) ' percent loaded!']);
    end
    disp('loading textures is done!');
    cd ..
    disp(stimuli(:,:));
    
    %% make grid
    
    chosen_ones = randsample(numberOfStimuli,n);
    
    
    
    Screen('DrawTextures', windo, stimuli(chosen_ones), [],  points);
      
         
    Screen('Flip', windo);
    
    KbWait;
    Screen('CloseAll')
    
    
    
    
    
catch
    Screen('CloseAll');
    rethrow(lasterror);
    
end