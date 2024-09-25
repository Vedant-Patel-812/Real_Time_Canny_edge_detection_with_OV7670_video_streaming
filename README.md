# Real_Time_Canny_edge_detection_with_OV7670_video_streaming
 This project was developed as part of my summer internship alongside teammates Gaurav and Naitik, under the guidance of Dr. Ankur Changla. The objective was to gain a deeper understanding of how computer vision tasks like edge detection can be implemented on hardware, specifically an FPGA. We explored the potential for future applications, including designing an ASIC.

The Canny edge detection algorithm is a widely used and highly effective method for detecting edges in images. The steps involved are as follows:

1. Noise Reduction: To reduce noise and false edges, a Gaussian filter is used to smooth the image. This step ensures that small-scale variations due to noise are minimized, while the major edges remain intact.

2. Gradient Calculation: After smoothing, the image's intensity gradient is computed using the Sobel operator. This identifies areas with sharp intensity changes, which are potential edges. The gradient magnitude and direction are calculated for each pixel.

3. Non-Maximum Suppression: The gradient values that are not local maxima are suppressed to refine the edge detection. This step ensures that the edges are thin and well-defined.

4. Double Thresholding: Two thresholds (high and low) are applied to classify pixels as strong or weak edges. Strong edges are retained, while weak edges are further analyzed.

5. Edge Tracking by Hysteresis: Weak edges are kept only if they are connected to strong edges, ensuring continuity in the detected edges.

Implementation on FPGA
The Nexys-A7 FPGA was chosen for its flexibility and resource availability. Here’s how the algorithm was implemented:

Image Input: The OV7670 camera module was used to capture the video stream. The camera provides real-time data that is fed directly to the FPGA for processing.

Gaussian Filter: A 5x5 Gaussian kernel was implemented on the FPGA using parallel processing to reduce latency and maintain real-time performance.

Sobel Operator: The Sobel operation was realized by designing a 3x3 convolution kernel that computes the gradients in the x and y directions. Parallelization allowed the FPGA to handle these computations quickly.

Non-Maximum Suppression and Thresholding: These steps were implemented in hardware using decision logic to reduce unnecessary memory usage, optimizing resource utilization.

VGA Output: The processed edge data is sent to a display via the VGA port, showing the real-time results of the edge detection.

You can see the working architecture in the video below:

[![Video](https://img.youtube.com/vi/_Ix6b2beu2g/maxresdefault.jpg)](https://www.youtube.com/watch?v=_Ix6b2beu2g)

