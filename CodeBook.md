# Codebook for Getting and Cleaning Data Course project

This codebook describes the data set stored in tidy.txt .

## Source data set
The source - input - data set was from an experiment conducted at UCI. They measured the movements of 30 volunteers, doing 6 different activities.  
They captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz using the embedded accelerometer and gyroscope of the smartphone.

The features selected for the dataset from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 
* mean(): Mean value  
* std(): Standard deviation  
* mad(): Median absolute deviation   
* max(): Largest value in array  
* min(): Smallest value in array  
* sma(): Signal magnitude area  
* energy(): Energy measure. Sum of the squares divided by the number of values.   
* iqr(): Interquartile range   
* entropy(): Signal entropy  
* arCoeff(): Autorregresion coefficients with Burg order equal to 4  
* correlation(): correlation coefficient between two signals  
* maxInds(): index of the frequency component with largest magnitude  
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
* skewness(): skewness of the frequency domain signal  
* kurtosis(): kurtosis of the frequency domain signal  
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
* angle(): Angle between to vectors.  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
* gravityMean  
* tBodyAccMean  
* tBodyAccJerkMean  
* tBodyGyroMean  
* tBodyGyroJerkMean  

The X-Y-Z components of the above measured and derived variables make up the original train and test datasets, that include 561 variables for each subject/activity.

More detailed information can be found on the experiment's website at:  
http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions

## Data selection and transformations
The run_analysis.R script does the following processing on the source datasets:
* loads both the train and test datasets. After loading updates both tables with
  * Setting variable names using corresponding name loaded from features.txt table
  * Using regular expression based search (in the column names) extracts only the variables on the mean and standard deviation for each measurement. (66 variables).
  * Adds a variable that stores the activity label for each measurement.
  * Adds a variable that stores the subject identifier for each measurement.

* it merges the two tables
* Modifies the variable names of every column (with the exception of Subject and Activity) to end with the word 'Average'. This is to make it clear that the - final - values in this tidy set are different from those in the original tables.
* To modify the actual values in those columns, the script uses the dplyr package to:
   * group the measurements by subject and than by activity.
   * apply the mean() function to the measurements of a group by calling summarize_all().  
   This function also repeats the same task in every column.
* Write the resulting tidy data to tidy.txt .

### Description of values
* **Subject** : Identifier of the subject this measurement belongs to.
* **Activity** : The activity label that describes this measurement. Can be one of these values:  
LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS.
* **tBodyAcc-mean()-X-Average  
tBodyAcc-mean()-Y-Average  
tBodyAcc-mean()-Z-Average**: Time-domain body acceleration , along three axes, each averaged.
 * **tBodyAcc-std()-X-Average  
  tBodyAcc-std()-Y-Average  
  tBodyAcc-std()-Z-Average**: Standard deviation of the time-domain body acceleration, along three axes, each averaged.
 * **tGravityAcc-mean()-X-Average  
 tGravityAcc-mean()-Y-Average  
 tGravityAcc-mean()-Z-Average**:  Time-domain gravity acceleration, along three axes, each averaged.
 * **tGravityAcc-std()-X-Average   
 tGravityAcc-std()-Y-Average  
 tGravityAcc-std()-Z-Average**: Standard deviation of the time-domain gravity acceleration, along each axes, averaged.
 * **tBodyAccJerk-mean()-X-Average  
 tBodyAccJerk-mean()-Y-Average  
 tBodyAccJerk-mean()-Z-Average**:  Time-domain body acceleration jerk (derivative of the acceleration in time), along each axes, averaged.

 * **tBodyAccJerk-std()-X-Average  
 tBodyAccJerk-std()-Y-Average  
 tBodyAccJerk-std()-Z-Average**: Standard deviation of the time-domain body acceleration jerk, along each axes, averaged.

 * **tBodyGyro-mean()-X-Average  
 tBodyGyro-mean()-Y-Average  
 tBodyGyro-mean()-Z-Average**: Time-domain body angular velocity, along each axes, averaged.

 * **tBodyGyro-std()-X-Average  
 tBodyGyro-std()-Y-Average  
 tBodyGyro-std()-Z-Average**:  Standard deviation of the time-domain body angular velocity, along each axes, averaged.

* **tBodyGyroJerk-mean()-X-Average  
tBodyGyroJerk-mean()-Y-Average  
tBodyGyroJerk-mean()-Z-Average**: Time-domain body angular velocity jerk (derivative of the angular velocity in time), along each axes, averaged.

* **tBodyGyroJerk-std()-X-Average  
tBodyGyroJerk-std()-Y-Average  
tBodyGyroJerk-std()-Z-Average**: Standard deviation of the time-domain body angular velocity jerk, along each axes, averaged.

* **tBodyAccMag-mean()-Average  
tBodyAccMag-std()-Average**: Mean and standard deviation of the time-domain magnitude of body acceleration, averages.

* **tGravityAccMag-mean()-Average  
tGravityAccMag-std()-Average**: Mean and standard deviation of the time-domain magnitude of gravity acceleration, averages.

* **tBodyAccJerkMag-mean()-Average  
tBodyAccJerkMag-std()-Average**: Mean and standard deviation of the time-domain magnitude of body acceleration jerk, averages.

* **tBodyGyroMag-mean()-Average  
tBodyGyroMag-std()-Average**: Mean and standard deviation of the time-domain magnitude of body angular velocity, averages.

* **tBodyGyroJerkMag-mean()-Average  
tBodyGyroJerkMag-std()-Average**: Mean and standard deviation of the time-domain magnitude of body angular velocity jerk, averages.

* **fBodyAcc-mean()-X-Average  
fBodyAcc-mean()-Y-Average  
fBodyAcc-mean()-Z-Average:** Frequency-domain body acceleration along three axes, averaged.
* **fBodyAcc-std()-X-Average  
fBodyAcc-std()-Y-Average  
fBodyAcc-std()-Z-Average**: Standard deviation of the frequency-domain body acceleration along the three axes, averaged.
* **fBodyAccJerk-mean()-X-Average  
fBodyAccJerk-mean()-Y-Average  
fBodyAccJerk-mean()-Z-Average**: Mean frequency-domain body acceleration jerk along the three axes, averaged.
* **fBodyAccJerk-std()-X-Average  
fBodyAccJerk-std()-Y-Average  
fBodyAccJerk-std()-Z-Average**: Standard deviation of the frequency-domain body acceleration jerk along the three axes, averaged.
* **fBodyGyro-mean()-X-Average  
fBodyGyro-mean()-Y-Average  
fBodyGyro-mean()-Z-Average**: Mean frequency-domain body angular velocity along the three axes, averaged.
* **fBodyGyro-std()-X-Average  
fBodyGyro-std()-Y-Average  
fBodyGyro-std()-Z-Average**: Standard deviation of the frequency-domain body angular velocity along the three axes, averaged.
* **fBodyAccMag-mean()-Average  
fBodyAccMag-std()-Average**: Mean, standard deviation of the frequency-domain magnitude of body acceleration, averaged.
* **fBodyBodyAccJerkMag-mean()-Average  
fBodyBodyAccJerkMag-std()-Average**: Mean, standard deviation of the frequency-domain magnitude of body acceleration jerk, averaged.
* **fBodyBodyGyroMag-mean()-Average  
fBodyBodyGyroMag-std()-Average**: Mean, standard deviation of the frequency-domain magnitude of body angular velocity, averages.
* **fBodyBodyGyroJerkMag-mean()-Average  
fBodyBodyGyroJerkMag-std()-Average**: Mean, standard deviation of the frequency-domain magnitude of body angular velocity jerk, averaged.

