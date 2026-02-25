# dice-image-procesing-system

# Dice Vision System: Image Processing & Noise Filtration

## Project Overview
This project is an automated computer vision system developed in MATLAB that processes static images to calculate visual metrics. The core objective is to apply digital signal processing techniques to filter out environmental noise and cleanly extract specific data points. Specifically, this program processes images of dice to dynamically isolate, evaluate, and count the number of dots (pips).

## Key Features
* **Static Image Ingestion:** Loads and processes local image files, providing a reliable and repeatable testing environment for data pipelines.
* **Automated Noise Filtration:** Utilizes algorithmic filtering (including HSV masking and morphological cleanup) to dynamically clean up visual artifacts and background interference.
* **Shape & Metric Analytics:** Calculates specific region properties (Area, Eccentricity, Solidity) to accurately isolate and count the target subjects.
* **Visualization Dashboard:** Automatically generates a step-by-step visual subplot to track the image processing pipeline from raw input to final detection.

## Technical Stack
* **Language:** MATLAB
* **Concepts:** Computer Vision, Digital Signal Processing, Automated Data Extraction, Image Segmentation

## Setup & Usage
1. Clone this repository to your local machine.
2. Ensure your target images (e.g., `.jpg`, `.png`) are placed in the root directory or the provided `test_images/` folder.
3. Open `visionSysCode.m` and update the `fileName` variable (Line 15) to match your target image.
4. Run the script to generate the processing dashboard.

## Limitations & Configuration
* **Spatial Calibration:** The image processing includes an optional cropping function (`imcrop`) that is pre-set for a specific testing environment. To process a full-scale image without cropping, adjust the script to `croppedImage = raw;` (See Line 36).
* **Color Thresholding:** The program includes an optional HSV mask originally designed to filter out blue background shadows. Depending on the test image's background color, this mask can be toggled or adjusted (See Lines 58-59).
