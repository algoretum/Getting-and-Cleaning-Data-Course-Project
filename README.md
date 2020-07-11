# Getting-and-Cleaning-Data-Course Project

The purpose of this project is to create a clean data set from an existing set of data. 

## Data source
The source data is from an experiment conducted by UCI and available on their website.

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

More details and the datasets can be found on the experiment's web page at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Repository contents
* README.md : this file, that describes the project overview
* Codebook.md : describes the datasets, the variables and the transformation steps that were used to produce the tidy dataset.
* run_analysis.R : the R script that performs the data processing steps and creates the tidy dataset.
* tidy.txt : the output dataset, saved by run_analysis.R

## Running the script
run_analisys.R is the script that processes the source data to create the tidy output dataset.  
The source data is not included in this repossitory because of its size.  
But the script assumes that the source data is available in a subdirectory called 'UCI HAR Dataset'. The following steps describe where to get it:

* The data can be obtained from the experiment's website or from the link  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
Simply extracting the zip file will create the subdirectory with the correct name.
* Make sure you set the current working directory to the parent directory of 'UCI HAR Dataset' before running the script.
* Load run_analisys.R in RStudio and source it, than run the run_analysis() function.
* The script will
    * load the train and test datasets. This includes extracting the measurements on the mean and standard deviation for each measurement and appending columns that describe the subject and activity for each row (load_table function).
    * Merges the two tables calling rbind().
    * Groups the row by subject and than by activity.
    * Calculates the average of measurements within each group by summarizing the group values through the mean() function.
    * Writes the output dataset table to tidy.txt.

## Notes
The script requires the dplyr package, so make sure you install it on your system before running run_analysis.R.
Version 0.8.5 should work, it was used to generate the included tidy.txt output.