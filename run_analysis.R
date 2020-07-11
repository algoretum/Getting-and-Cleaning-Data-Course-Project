#
# 'Getting and Cleaning Data Course' Project 
# https://www.coursera.org/learn/data-cleaning/home/welcome
# See README for detailed description of processing steps
#

#
# Returns full path. Appends filename argument to data set path.
#
full_path <- function( filename) {
  # Dataset location can be changed here
  sprintf("%s/%s", "UCI HAR Dataset", filename )
}

# Loads one of the datasets
# Parameter
#      mainFile  : filename of main dataset table
#  subjectsFile  : filename of subject list file
#  activityFile  : filenae of activity lable list
#    columnNames : vector containing the column labels
#
load_table <- function( mainFile, subjectsFile, activityFile, columnNames ) {
  f <- full_path(mainFile)
  print( "Loading ")
  print( f )
  tbl <- read.table( f)
  # Add column names
  if( ncol(tbl) != length(columnNames ) ) {
    print( "Invalid table width !")
    return(0)
  }

  names(tbl) <- columnNames  # Add column names
  ind <- grep( "-std\\(|-mean\\(", names(tbl))  # Find indices of columns we want to keep
  tbl <- tbl[ind] 

  # Load activity label list
  activityLabels <- read.table( full_path("activity_labels.txt"))
  activityList <- scan( full_path(activityFile))
  
  # Create new column with activity labels
  Activity <- activityLabels$V2[ activityList ]
  tbl <- cbind( Activity, tbl )
  
  # Load subjects column and bind
  subjects <- read.table( full_path(subjectsFile) )
  names(subjects) <- c("Subject")
  tbl <- cbind( subjects, tbl)
}

run_analysis <- function() {
  library(dplyr)
  
  features <- read.table( full_path("features.txt") )

  #
  # Load train table and add other columns
  #
  train <- load_table( "train/X_train.txt", "train/subject_train.txt", "train/y_train.txt",features$V2 )

  #
  # Load test dataset, with updates
  #
  test <- load_table( "test/X_test.txt", "test/subject_test.txt", "test/y_test.txt", features$V2)
  
  # Merge test to train
  all <- rbind( train, test )
  
  names(all) <- paste0( names(all), c("","", rep("-Average", ncol(all)-2)))

  print( "Saving output table to tidy.txt.")
  
  # First we group rows by subject and activity
  #   then calcualte the mean of all rows in a group in summarize_all() call
  all %>% group_by( Subject, Activity ) %>% 
    summarize_all( mean ) %>% 
    write.table( full_path("tidy.txt"),row.names=FALSE,quote=FALSE)
}