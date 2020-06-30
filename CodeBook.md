### Link to UCI HAR dataset

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Variables in the dataset

The variables selected for this database come from the accelerometer and gyroscope 3-axial raw signals **tAcc-XYZ** and **tGyro-XYZ**. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (**tBodyAcc-XYZ** and **tGravityAcc-XYZ**) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (**tBodyAccJerk-XYZ** and **tBodyGyroJerk-XYZ**). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (**tBodyAccMag**, **tGravityAccMag**, **tBodyAccJerkMag**, **tBodyGyroMag**, **tBodyGyroJerkMag**). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing **fBodyAcc-XYZ**, **fBodyAccJerk-XYZ**, **fBodyGyro-XYZ**, **fBodyAccJerkMag**, **fBodyGyroMag**, **fBodyGyroJerkMag**. (Note the 'f' to indicate frequency domain signals). 

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

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation   
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.   
iqr(): Interquartile range     
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal    
kurtosis(): kurtosis of the frequency domain signal   
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.    
angle(): Angle between to vectors.  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  

The complete list of variables of each feature vector is available in features file (UCI HAR Dataset/features.txt)

### Transformations performed in order to clean the data

On running **run_analysis.R**, following variables are created:  
train_data <- data frame containing train data (UCI HAR Dataset/train/X_train.txt)  
test_data <- data frame containing test data (UCI HAR Dataset/test/X_test.txt)  
variable_names <- data frame containing variable names (UCI HAR Dataset/features.txt)  
train_activities <- data frame containing training activity labels (UCI HAR Dataset/train/y_train.txt)  
test_activities <- data frame containing testing activity labels (UCI HAR Dataset/train/y_test.txt)  
activity_labels <- data frame containing linking the class labels with their activity name(UCI HAR Dataset/activity_labels.txt)  
train_subjects <- data frame containing data about the subject in train_data (UCI HAR Dataset/train/subject_train.txt)  
test_subjects <- data frame containing data about the subject in test_data (UCI HAR Dataset/test/subject_test.txt)  

#### 1. Merging the training and the test sets to create one data set   

The **train_data** and **test_data** were merged into a single data frame. On running the script **run_analysis.R**, a data frame **merged_data** gets created which contains both the training and testing data.  

#### 2. Extracting only the measurements on the mean and standard deviation for each measurement   

From this **merged_data**, variables containing information on the mean and standard deviation were extracted using the select() command in dplyr package. On running the script **run_analysis.R**, a data frame **only_mean_and_sd_data** gets created which contains this data


#### 3. Using descriptive activity names to name the activities in the data set  

**activities** data frame combines **train_activities** and **test_activities** using rbind(). **desc_activity_colmn** stores activity's name instead of labels with the help of **activity_labels**. This column gets added to **only_mean_and_sd_data** from step 2 using cbind().

#### 4. Appropriately labeling the data set with descriptive variable names 
Variable names were provided to the **merged_data** using **variable_names**. Later, these variable names were altered to remove unallowed characters in variable names to be used by dplyr functions using make.names().

#### 5. From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject 

**subjects** data frame combines **train_subjects** and **test_subjects** using rbind().This column gets added to **only_mean_and_sd_data** from step 3 using cbind(). The data in **only_mean_and_sd_data** is grouped by "activty" and "subject" and mean of all variables is calculated for each variable for all the activities and subjects. **mean_for_each_activity_and_subject** dataframe contains this data. Grouping was done by group_by() and mean for each group was calculated by summarise(). These two functions are from the dplyr package.
