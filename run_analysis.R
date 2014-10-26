#

# Please set your working directory here where the downloaded data set has been extracted.
# setwd ( "CHANGE_THIS!" )

# Build a data frame combining the subject IDs and activity IDs from both training and test data sets.
subject_activity <- rbind (
    cbind (read.table ("train/subject_train.txt"),
           read.table ("train/y_train.txt")),
    cbind (read.table ("test/subject_test.txt"),
           read.table ("test/y_test.txt"))
  )
# Update the column names
names ( subject_activity ) <- c ( "subject", "activity_id" )

activity_lookup <- read.table ( "activity_labels.txt" )
names ( activity_lookup ) <- c ( "activity_id", "activity" )

# We're going to use the join() function in plyr package to join two data sets.
# If you don't have plyr package installed already, uncomment the following line so plyr can be installed.
# install.package ( "plyr" )

library ( plyr )
subject_activity <- join ( subject_activity, activity_lookup, by = "activity_id", type = "inner", match = "all" )
subject_activity <- subject_activity [, c (1, 3)]

# Build a data frame containing all the measurements.
measurements <- rbind (
    read.table ("train/X_train.txt"),
    read.table ("test/X_test.txt")
  )
names ( measurements ) <- read.table ( "features.txt" )$V2

# Keep only the mean and standard deviation columns.
mean_and_sd_regex <- ".*mean\\(\\).*|.*std\\(\\).*"
mean_and_sd_columns <- grep ( mean_and_sd_regex, names (measurements), value = F )
measurements <- measurements [, mean_and_sd_columns]

# Calculate the averages
subject_activity_combined <- do.call ( paste, c (subject_activity, sep = "") )

averages <- data.frame ( lapply ( split (measurements, subject_activity_combined), colMeans) )
averages <- t ( averages )

# Update the column names to reflect the new meaning after the computations.
colnames (averages) <- paste ( "average_", colnames (averages), sep = "" )

# Finally we merge the two data frames.
result <- cbind ( unique (subject_activity), averages )

# And we write the results to a file.
write.table ( result, file = "tidy_data.txt", row.names = FALSE )

