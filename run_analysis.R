# https://rpubs.com/Zanin_Pavel/158283

# Set working directory.

setwd("C:\\Users\\jlapierr\\Documents\\Research and Development\\Getting and Cleaning Data")

# Download the data.

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url
  , destfile="Data.zip"
  )

# Unzip the data.

unzip("Data.zip")

# Read the data.

xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Read the features.

features <- read.table('./UCI HAR Dataset/features.txt')

# Read the activity labels.

activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')

# Assign the column names.

colnames(xTrain) <- features[,2] 
colnames(yTrain) <-"activityId"
colnames(subjectTrain) <- "subjectId"
colnames(xTest) <- features[,2] 
colnames(yTest) <- "activityId"
colnames(subjectTest) <- "subjectId"
colnames(activityLabels) <- c('activityId'
  , 'activityType'
  )

# Merge the data.

mergedTrain <- cbind(yTrain
  , subjectTrain
  , xTrain
  )
mergedTest <- cbind(yTest
  , subjectTest
  , xTest
  )
mergedAll <- rbind(mergedTrain
  , mergedTest)

# Remove the data?

# Get the column names. 

columnNames <- colnames(mergedAll)

# Create the vector.

meanAndStD <- (grepl("activityId", columnNames)
  | grepl("subjectId", columnNames)
  | grepl("mean..", columnNames)
  | grepl("std..", columnNames) 
  )

# Get the subset from mergedAll

setForMeanAndStD <- mergedAll[, meanAndStD == TRUE]

# Assign descriptive names to the activities.

setWithActivityNames <- merge(setForMeanAndStD
  , activityLabels
  , by='activityId'
  , all.x=TRUE
  )

# Make tidy data sets that contain the variable averages.

secondTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secondTidySet <- secondTidySet[order(secondTidySet$subjectId, secondTidySet$activityId),]

write.table(secondTidySet, "secondTidySet.txt", row.name=FALSE)