%{
Authors:    Daniel Kee Tam
Assignment: EGR 103 
Changed:    May 1 2025 (Added blue-background removal & relaxed shape thresholds)
History:    Mar  5 2025 - Initial version.
            May  1 2025 - HSV masking & shape filtering added.
            May  2 2025 - Shape thresholds relaxed to avoid under-counting.
Purpose:    Load a static image of a dice, isolate the dice region, count the black pips,
            filter out blue shadows.
%}

%% Step 1: Load Static Image
% Replace 'test_dice.jpg' with the exact name of your image file.
% Ensure the image is saved in the same folder as this MATLAB script.
fileName = 'test images/gemini dice image 1.png';

if ~isfile(fileName)
    error('Image file not found. Please verify the file name and location.');
end

raw = imread(fileName);

% Ensure the image is RGB (3 channels) in case a grayscale image is loaded
if size(raw,3) == 1
    raw = repmat(raw,[1,1,3]); 
end

%% Step 2: Initialize Dashboard & Crop
figure('Name', 'Dice Vision System Dashboard', 'Position', [100, 100, 1000, 600]);

% --- CALIBRATION NOTE ---
% These coordinates are calibrated for your specific webcam setup. 
% If your test image has the dice in a different location, change these numbers.
% To process the ENTIRE image without cropping, change to: croppedImage = raw;
%roi4dice     = [192, 158, 200, 174];
croppedImage = raw;

subplot(2,3,1);
imshow(croppedImage);
title('1. Cropped Original');

%% Step 3: Grayscale Conversion
grayImage = rgb2gray(croppedImage);

subplot(2,3,2);
imshow(grayImage);
title('2. Grayscale');

%% Step 4: Threshold, Invert & Blue HSV Mask
level       = graythresh(grayImage) * 0.8;
binaryImage = imbinarize(grayImage, level);
binaryImage = imcomplement(binaryImage);

% Remove Blue-Background Shadows
hsvImage = rgb2hsv(croppedImage);
hue  = hsvImage(:,:,1);
sat  = hsvImage(:,:,2);
%blueMask = (hue>=0.55 & hue<=0.75) & (sat>=0.2);
% binaryImage(blueMask) = 0;

subplot(2,3,3);
imshow(binaryImage);
title('3. Threshold & Blue Mask');

%% Step 5: Morphological Cleanup
cleanedImage = bwareaopen(binaryImage, 50);
filledImage  = imfill(cleanedImage, 'holes');

subplot(2,3,4);
imshow(filledImage);
title('4. Morphological Cleanup');

%% Step 6: Detect & Filter (Fixed)
stats = regionprops('table', filledImage, ...
    'Centroid','BoundingBox','Area','Eccentricity','Solidity');

% --- CRITICAL FIX: Define all thresholds ---
minArea     = 10;     % Lowered further to ensure we catch the small pip
maxArea     = 10000;   % Increased to ensure the pip isn't accidentally cut off
maxEcc      = 0.5;    % Pips are round (0), shadows are long (1)
minSolidity = 0.8;    % Pips are solid circles

% Ensure maxArea exists before this line:
keepIdx = stats.Area >= minArea & stats.Area <= maxArea ...
        & stats.Eccentricity <= maxEcc ...
        & stats.Solidity >= minSolidity;

filteredStats = stats(keepIdx,:);
numPips       = height(filteredStats);
disp("Number of dice pips detected: " + numPips);


%% Step 7: Visualize Final Detections
subplot(2,3,[5 6]); 
imshow(croppedImage);
title(sprintf('Final Detection: %d Pips', numPips));
hold on;
for k = 1:numPips
    rectangle('Position', filteredStats.BoundingBox(k,:), ...
              'EdgeColor','r','LineWidth',2);
    plot( filteredStats.Centroid(k,1), filteredStats.Centroid(k,2), ...
          'r+','MarkerSize',10,'LineWidth',2);
end
hold off;

%% Step 8: Keep Dashboard Open Until User Acknowledges
disp('Press any key in the command window to close the visualization...');
pause; 
close all;