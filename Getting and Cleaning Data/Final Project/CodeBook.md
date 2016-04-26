# Code Book

This code book summarizes the process of run_analysis.R and resulting data fields in `output.txt`.

## Steps
run_analysis.R does the following 

1. Download the data from url if it doesn't exist in directory
2. Get activity labels and features 
3. Get only features reflecting mean or standard deviation
4. Load training and testing data
5. Merge the data set
*Only columns with information as statistical mean or standard deviation was extracted from features.txt

## Data Columns
	"subject",
    "activity",
    "tBodyAccMeanX",
    "tBodyAccMeanY",
    "tBodyAccMeanZ",
    "tBodyAccStdX",
    "tBodyAccStdY",
    "tBodyAccStdZ",
    "tGravityAccMeanX",
    "tGravityAccMeanY",
    "tGravityAccMeanZ",
    "tGravityAccStdX",
    "tGravityAccStdY",
    "tGravityAccStdZ",
    "tBodyAccJerkMeanX",
    "tBodyAccJerkMeanY",
    "tBodyAccJerkMeanZ",
    "tBodyAccJerkStdX",
    "tBodyAccJerkStdY",
    "tBodyAccJerkStdZ",
    "tBodyGyroMeanX",
    "tBodyGyroMeanY",
    "tBodyGyroMeanZ",
    "tBodyGyroStdX",
    "tBodyGyroStdY",
    "tBodyGyroStdZ",
    "tBodyGyroJerkMeanX",
    "tBodyGyroJerkMeanY",
    "tBodyGyroJerkMeanZ",
    "tBodyGyroJerkStdX",
    "tBodyGyroJerkStdY",
    "tBodyGyroJerkStdZ",
    "tBodyAccMagMean",
    "tBodyAccMagStd",
    "tGravityAccMagMean",
    "tGravityAccMagStd",
    "tBodyAccJerkMagMean",
    "tBodyAccJerkMagStd",
    "tBodyGyroMagMean",
    "tBodyGyroMagStd",
    "tBodyGyroJerkMagMean",
    "tBodyGyroJerkMagStd",
    "fBodyAccMeanX",
    "fBodyAccMeanY",
    "fBodyAccMeanZ",
    "fBodyAccStdX",
    "fBodyAccStdY",
    "fBodyAccStdZ",
    "fBodyAccMeanFreqX",
    "fBodyAccMeanFreqY",
    "fBodyAccMeanFreqZ",
    "fBodyAccJerkMeanX",
    "fBodyAccJerkMeanY",
    "fBodyAccJerkMeanZ",
    "fBodyAccJerkStdX",
    "fBodyAccJerkStdY",
    "fBodyAccJerkStdZ",
    "fBodyAccJerkMeanFreqX",
    "fBodyAccJerkMeanFreqY",
    "fBodyAccJerkMeanFreqZ",
    "fBodyGyroMeanX",
    "fBodyGyroMeanY",
    "fBodyGyroMeanZ",
    "fBodyGyroStdX",
    "fBodyGyroStdY",
    "fBodyGyroStdZ",
    "fBodyGyroMeanFreqX",
    "fBodyGyroMeanFreqY",
    "fBodyGyroMeanFreqZ",
    "fBodyAccMagMean",
    "fBodyAccMagStd",
    "fBodyAccMagMeanFreq",
    "fBodyBodyAccJerkMagMean",
    "fBodyBodyAccJerkMagStd",
    "fBodyBodyAccJerkMagMeanFreq",
    "fBodyBodyGyroMagMean",
    "fBodyBodyGyroMagStd",
    "fBodyBodyGyroMagMeanFreq",
    "fBodyBodyGyroJerkMagMean",
    "fBodyBodyGyroJerkMagStd",
    "fBodyBodyGyroJerkMagMeanFreq"


## Important Columns
* `subject`: ID of the test subject
* `activity`: type of activity performed when the corresponding measurements were taken
	1. `WALKING` (value `1`)
	2. `WALKING_UPSTAIRS` (value `2`)
	3. `WALKING_DOWNSTAIRS` (value `3`)
	4. `SITTING` (value `4`)
	5. `STANDING` (value `5`)
	6. `LAYING` (value `6`)
* Rest of columns are various standard deviation, frequency, or mean data on movement of the smartphone