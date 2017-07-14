clear all;close all

% images must be square and the same size
% you can change which pictures to read in here!
images{1} = imresize(imread('~/Desktop/dank/Thurgo_chathead.png'), [3264 3264]); % low spatial frequency
images{2} = imresize(imread('~/Desktop/dank/imgres.jpg'), [3264 3264]); % high spatial frequency

params.stimPixels = size(images{1},1);
params.patternSize = 20;
params.cutoffs = [.07 .35];
params.weights = [.5 .5];% 50-50 mix
% params.weights = [.6 .4];% 60-40 mix
params.gaussSD = .05;

xyRange = linspace(-params.patternSize/2, params.patternSize/2, params.stimPixels);
[x,y] = meshgrid(xyRange);
r = sqrt(x.^2+y.^2);

for im = 1:length(images)
  
    for rgb = 1:3
        fftTex = fft2(double(images{im}(:,:,rgb))); %take fft of image
        fftTex = fftshift(fftTex);
        texMag = abs(fftTex); %get magnitute
        texPhase = angle(fftTex); %get phase
        
        bpFilt = exp(-((r-params.cutoffs(im)).^2)./(2*params.gaussSD^2)); %make filter
        if im == 1
            bpFilt(r<params.cutoffs(im)) = 1;
        else
            bpFilt(r>params.cutoffs(im)) = 1;
        end
        newfft = bpFilt.*fftTex; %filter by multiplication
        newImages{im}(:,:,rgb) = real(ifft2(fftshift(newfft)));
    end
    figure;imshow(uint8(newImages{im}))
end

newImages = cellfun(@double,newImages,'UniformOutput',0);
hybrid = params.weights(1).*newImages{1}+params.weights(2).*newImages{2};
figure; imshow(uint8(hybrid));