CodeBook for Getting and Cleaning Data Course Project
===================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. A vector of features was obtained by calculating variables from the time and frequency domain. For detailed information on how the raw data was collected and calculated, refer to the README.txt and the features_info.txt files included in the downloaded data set.

The steps required to produce the cleaned data set are as follows:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
mean() and std() standard for mean and standard deviation of the variable, respectively.

For steps 1-4, first we build a data frame combining the subject IDs and activity IDs from both training and test data sets (under the train and test subdirectories of the downloaded data). We use join to replace the activity IDs with the descriptive activity names from activity_labels.txt file.

