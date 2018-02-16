# Getting and Cleaning Data

This script creates a tidy data file called secondTidySet.txt.

The code creates the data file using the following steps:
1. Sets the working directory. 
2. Downloads and unzips the data.
3. Reads the test and training data as well as the features and activities.
4. Merges the data to create dataset of test and training data.
5. Gets columns that have mean or standard deviation data.
4. Loads the activity and subject data for each dataset.
5. Merges the two datasets.
6. Converts the columns to factors.
7. Creates a tidy dataset with the mean of each variable for each subject and activity pair.