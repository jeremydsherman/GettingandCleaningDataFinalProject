# GettingandCleaningDataFinalProject
This is my submission for the Coursera R Getting and Cleaning Data course final project

The first thing the script does is load in the necessary packages.

Then it reads the data into R for the test and the training data sets. It assembles these into a matrix which also contains a variable indicating which set (training or test) the data in that row came from. Then, per the instructions in **Question 4** it renames the headers of each column to a more descriptive name, taken directly from the UCI data folder. 

Then, per the instructions in **Question 1** it combines the training and test sets into one dataframe.

Then, per the instructions in **Question 3** it turns the "test" variable into a factor, then replaces that 1-6 factor with a descriptive name, like "walking".

Then, per the instructions in **Question 2** it removes all the columns that do not contain a variable describing a mean or standard deviation.

Then, per the instructions in **Question 5** it uses the melt and dcast functions to create a tidy data set containing the mean of each value for all instances of a given subject and test. 
