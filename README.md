# Real_Time_Canny_edge_detection_with_OV7670_video_streaming
 This work was part of my summer internship with 2 other team-mates (Gaurav and Naitik). under the mentorship of Dr. Ankur Changla. The motivation behind this project was to develop a better understanding on how compuer vision tasks such as edge detection can be implemented on FPGA board, Or design an ASIC in future.

The canny edge detection is a effective traditional method used for edge detection, steps of which as follows :

1. Noise Reduction: To minimize noise and false edges, the image is first smoothed using a Gaussian filter. This step blurs the image slightly, preserving important edges while reducing random noise.

2. Gradient Calculation: After smoothing, the intensity gradient (rate of change of brightness) in the image is calculated using operators like Sobel. This identifies areas with sharp intensity changes, which likely correspond to edges. The gradient magnitude and direction at each pixel are computed.

3. Non-Maximum Suppression: This step sharpens the edges by suppressing any gradient values that are not local maxima. Only pixels that are local maxima in the direction of the gradient are retained as potential edges, thinning the edges to one-pixel-wide lines.

4. Double Thresholding: Two thresholds (high and low) are applied to classify pixels. Strong edges (above the high threshold) are considered definite edges, while weak edges (between the two thresholds) are considered edge candidates.

5. Edge Tracking by Hysteresis: Finally, weak edges are retained only if they are connected to strong edges. This step helps filter out noise and connects broken edge segments.

The working architecture can be shown in the video : 

[![Video](https://img.youtube.com/vi/https://youtube.com/shorts/_Ix6b2beu2g/maxresdefault.jpg)](https://www.youtube.com/watch?v=https://youtube.com/shorts/_Ix6b2beu2g)

