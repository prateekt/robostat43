HW 3 Particle Filter Implementation

Samantha Horvath
Prateek Tandon

1.  Add all folders to MATLAB path

2.  Execute command parseAll from inside particleFilter - this will create parsedData.mat

3.  The main function for our filter is testFilter

	argument parameters:  alpha values, resample interval, map smoothing sigma, ID number.
	parameters at top of code in function: Log Number (robotNum) and number of particles;

3.1:  Our parameters:

	Alphas values: all 0.01
	Resample Interval: 5
	Map sigma: 4
	Number of particles: 1000

testFilter([0.01,0.01,0.01,0.01], 5, 3, 1);

4.  Currently the code is set to plot out particle position and statistics at every timestep. To turn this off,
	set PLOT = false; in line 63 of testFilter

5.  After testFilter is run, the data from the particle filter will be saved in Experiment_(ID number).mat;

	To view the results of the particleFilter, Experiment_(ID number).mat file, and run:
	
	plotExperiment(particleSets);