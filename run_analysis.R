# run_analysis.R usage:

## Change these paths to suit your configuration. No other config changes are needed for this script
projectPath = file.path("C:","edu","_DataScienceJohnsHopkins","_GettingCleaningData","Project")
dataPath = file.path( projectPath ,"data")

# source this script and run it by entering: run()

# structure of this script
# These functions are defined:
# run() -- performs all initialization and executes the objective functions for this task:
# cleanColumnNames() -- changes long feature names into valid column names. uses R's make.names and filters result further.

setwd( projectPath)

#run <- function() {

# initialization
if ( ! ("data.table" %in% rownames(installed.packages()))) {
  install.packages("data.table")
}
library("data.table")
library(stringi)


#1. Merges the training and the test sets to create one data set.

# data.frame xData -- accumulates and organizes data for analysis:
# read and combine training and test measurements, append activity and subject columns, revise column names

# data.frame activityCodes -- combines training and test activity codes (in same order as xData):
# activity codes are tidied by replacing codes with activity names

# data.frame subjectIds -- combines training and test subject codes (in same order as xData)

# data.frame featuresTable -- accumulates and tidies feature names for use as measurement column names

  metadataPath <- file.path( dataPath, "getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
  features<- read.table( file.path( metadataPath, "features.txt"),  stringsAsFactors=FALSE)

#
# 4. Appropriately labels the data set with descriptive variable names.
#
  # feature names are modified and used as column (variable) names.
  # place a  "mean" and "std" at the right, eliminate any multiple occurrences of "mean" in same feature name.
  # abbreviate all words, unit names and symbols to single letter codes.
  # generate a code table for use in the "code book".

  features <- cleanColumnNames( features)
  featuresIndexArray <- grep("-Mean|-Std", features[, 2]) 

  measurementDataPath <- file.path( dataPath, "getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
  trainPath <- file.path( measurementDataPath, "train")
  testPath <- file.path( measurementDataPath, "test")

  trainingData <- read.table( file.path( trainPath , "X_train.txt"))
  testData  <- read.table( file.path( testPath , "X_test.txt"))

#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#
    trainingData  <- trainingData[, featuresIndexArray]
    testData   <- testData[, featuresIndexArray]

#
# 1. Merges the training and the test sets to create one data set.
#
  xData <- rbind( trainingData, testData)

# completes #2. Extracts only the measurements on the mean and standard deviation for each measurement.
  names( xData) <- features[featuresIndexArray, 2]

# prepare for # 3. Uses descriptive activity names to name the activities in the data set

  trainingActivityCodes <- read.table( file.path( trainPath , "y_train.txt"))
  testActivityCodes  <- read.table( file.path( testPath , "y_test.txt"))
  activityCodes <- rbind( trainingActivityCodes , testActivityCodes)

    activityLabels <- read.table( file.path( metadataPath , "activity_labels.txt"))
    activityLabels[, 2] <-  gsub( "_", " ", activityLabels[, 2])
    activityLabels[, 2] = stri_trans_totitle( as.character( activityLabels[, 2]))

  activityCodes[,1] = activityLabels[ activityCodes[,1], 2] 
  names( activityCodes ) <- "Activity" 

# gather subject data
  trainingData <- read.table( file.path( trainPath , "subject_train.txt"))
  testData  <- read.table( file.path( testPath , "subject_test.txt"))
  subjectData <- rbind( trainingData, testData)
  names( subjectData ) <- "Subject"

# initialize for #5. From the data set in step 4, creates a second, independent tidy data set ...
 compositeData <- cbind( subjectData, activityCodes, xData)

# just for checking the intermediate result
 write.csv(compositeData , "compositeData.csv") 

# prepare to generate "...average of each variable for each activity and each subject." for step #5.
uniqueSubjects = sort( unique(subjectData[,1] ))
uniqueActivities =  activityLabels[, 2]

subjectIndex <- rep( uniqueSubjects , length(uniqueActivities))
activityIndex <- rep( uniqueActivities, 1, each=length(uniqueSubjects ))

nSubjectByActivity <- length(uniqueSubjects ) * length(uniqueActivities )

# Kludge: this is a bad way to initialize the 2d array but nothing better in R
  summarized  = compositeData [1:nSubjectByActivity , ] 
  summarized[ , ] <-  NA   # compensate for the kludge: make sure no cruft from compositeData

  nEndColumn <- ncol(compositeData)

#
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
  for ( iRow in 1: nSubjectByActivity ) {
     ridiculous <- compositeData[
                     compositeData$Subject == subjectIndex[iRow] 
                   & compositeData$Activity == activityIndex[iRow], ] 
     summarized[ iRow, 3:nEndColumn ] <- colMeans( ridiculous[, 3:nEndColumn ])

     summarized[ iRow, 1 ] <- subjectIndex[iRow]

# complete #3. Uses descriptive activity names to name the activities in the data set
     summarized[ iRow, 2 ] <- activityIndex[iRow]
  }

# generate file for "Please upload your data set as a txt file created with write.table() using row.name=FALSE"
write.table( format(summarized, digits=8), "runAnalysisCleanAveragedReplicationMeasurements.txt", row.name=FALSE, sep=",") 

# just for checking results
write.csv( format(summarized, digits=8), "runAnalysisCleanAveragedReplicationMeasurements.csv") 

# end of main procedure

##############################################################

# for #4.	Appropriately labels the data set with descriptive variable names

cleanColumnNames <- function( features) { # features: data.frame of strings updated in-place
  # accomodate R's arbitrary limitation on the form of column names    
  # transform feature names into basic valid unique csv column names

  originalFeatureNames <- features$V2
  features$V2 <- make.names( features$V2, unique=TRUE)

  featureNameOriginal <- features$V2
  for ( i in 1: nrow(features) ) {
  
    featureName <- features$V2[[i]]
    x <- gsub( "[.,)(\\-]", "-", featureName)
    x <- gsub( "[-][-]", "-", x)
    x <- gsub( "[-][-]", "-", x) # repeated because I don't trust R regex to work right
        
    xm <- sub("mean","", featureName, ignore.case=TRUE)
    xs <- sub("std","", featureName, ignore.case=TRUE)
    
    # if featureName contains mean or std-----------------------------
    if (nchar(xm) != nchar(featureName) | nchar(xs) != nchar(featureName)) { 
      x <- gsub( "[-]mean", "-Mean", x, ignore.case = TRUE)
      x <- gsub( "mean[-]", "-Mean-", x, ignore.case = TRUE)
      x <- gsub( "[-]std", "-Std", x, ignore.case = TRUE)
      x <- gsub( "std[-]", "-Std-", x, ignore.case = TRUE)
      
      x <- gsub( "[-][-]", "-", x) 
      x <- gsub( "[-][-]", "-", x) # repeated because I don't trust R regex to work right
      x <- gsub( "[-]$", "", x)
      
      # eliminate multiple Mean substrings in the name
      y1 <- sub( "Mean", "", x, ignore.case = TRUE)
      y2 <- sub( "Mean", "", y1, ignore.case = TRUE)
      if (nchar(y1) != nchar(y2)) {
        x <- y1
      }
      
      y1 <- sub( "Std", "", x, ignore.case = TRUE)
      y2 <- sub( "Std", "", y1, ignore.case = TRUE)
      if (nchar(y1) != nchar(y2)) {
        x <- y1
      }   

      x <- gsub( "-MeanFreq-X", "-Freq-X-Mean", x, ignore.case = TRUE)
      x <- gsub( "-MeanFreq-Y", "-Freq-Y-Mean", x, ignore.case = TRUE)
      x <- gsub( "-MeanFreq-Z", "-Freq-Z-Mean", x, ignore.case = TRUE)
      
      x <- gsub( "MeanFreq", "-FreqMean", x, ignore.case = TRUE)
      
      x <- gsub( "-Mean-X", "-X-Mean", x, ignore.case = TRUE)
      x <- gsub( "-Mean-Y", "-Y-Mean", x, ignore.case = TRUE)
      x <- gsub( "-Mean-Z", "-Z-Mean", x, ignore.case = TRUE)
      
      x <- gsub( "-std-X", "-X-Std", x, ignore.case = TRUE)
      x <- gsub( "-std-Y", "-Y-Std", x, ignore.case = TRUE)
      x <- gsub( "-std-Z", "-Z-Std", x, ignore.case = TRUE)
      
      x <- gsub( "Mean-gravity", "gravity-Mean", x, ignore.case = TRUE)

      x <- gsub( "X-gravity", "gravity-X", x, ignore.case = TRUE)
      x <- gsub( "Y-gravity", "gravity-Y", x, ignore.case = TRUE)
      x <- gsub( "Z-gravity", "gravity-Z", x, ignore.case = TRUE)
      
      x <- gsub( "Body", "B", x, ignore.case = TRUE)
      x <- gsub( "Acc", "a", x, ignore.case = TRUE)
      x <- gsub( "Gravity", "G", x, ignore.case = TRUE)
      x <- gsub( "Jerk", "J", x, ignore.case = TRUE)
      x <- gsub( "Gyro", "g", x, ignore.case = TRUE)
      x <- gsub( "Mag", "M", x, ignore.case = TRUE)
      x <- gsub( "Freq", "F", x, ignore.case = TRUE)
      x <- gsub( "angle", "V", x, ignore.case = TRUE)

#      x <- gsub( "Mean", "u", x, ignore.case = TRUE)
#      x <- gsub( "std", "s", x, ignore.case = TRUE)
      
      x <- gsub( "[-][-]", "-", x)
      x <- gsub( "[-][-]", "-", x)
      x <- gsub( "[-]$", "", x)

      # generate code-book table of tidy column names to corresponding feature names
     print( sprintf( "%s %s %s", i, x, originalFeatureNames[i]))
      
#   } else { # ignore features that do not contain mean or std (columns will be ignored)
#      x <- gsub( "[-][-]", "-", x)
#      x <- gsub( "[-][-]", "-", x)
#      x <- gsub( "[-]$", "", x)
 
    }
    features$V2[[i]] <-  x
  # check uniqueness (no accidental trailing mean or std:
  #    print( sprintf( "%s %s %s", i, x, originalFeatureNames[i]))

  }
  features
}



