# dice-image-procesing-system

## Project Overview
This project is an automated computer vision system developed in MATLAB that processes live webcam footage to calculate real-time metrics. The core objective of the script is to take raw, live-streamed video and apply digital signal processing techniques to filter out environmental noise and cleanly extract specific visual data. Specifically, this program processes an image of a dice to dynamically extract and count the number of dots.

## Key Features
* **Live Feed Integration:** Captures and processes video data directly from a webcam stream.
* **Automated Noise Filtration:** Utilizes algorithmic filtering to dynamically clean up visual artifacts and background interference.
* **Real-Time Analytics:** Continuously calculates and outputs specific metrics based on the isolated subjects in the video feed.

## Technical Stack
* **Language:** MATLAB
* **Concepts:** Computer Vision, Digital Signal Processing, Real-Time Data Extraction, Automated Scripting

## Limitations & Configuration
* **Spatial Calibration:** The image processing successfully crops to the dice region, but the metrics to determine this region are pre-set. These coordinates are calibrated for a specific dice landing area, camera height, and field of view (FOV). *(Please refer to line 26 to adjust).*
* **Color Thresholding:** The program currently expects the background of the dice to be blue. *(Please refer to lines 40-46 to change the target background color).*
