##Call necessary packages
library(dplyr)
library(tidyr)
library(reshape2)



##Read in the data for the test set

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                        header = FALSE, 
                        sep = "")
x_test <- read.table("UCI HAR Dataset/test/x_test.txt", 
                        header = FALSE, 
                        sep = "")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
                        header = FALSE, 
                        sep = "")
headers <- read.table("UCI HAR Dataset/features.txt",
                      header = FALSE,
                      sep = "")

##Combine the subject, test type, and the data into a single data frame
teststats <- cbind(subject_test, y_test, x_test)

##Add a column that indicates which data set is represented
set <- rep("test", 2947)
##Add the dataset label into the data frame
teststatsfull <- cbind(set, teststats)
##Rename the headers
values <- as.vector(headers[, 2])
firstvals <- as.vector(c("set", "subject", "test"))
heading <- as.vector(c(firstvals, values))
names(teststatsfull) <- heading


##Repeat all steps for the train set

##Read in the data for the train set

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                           header = FALSE, 
                           sep = "")
x_train <- read.table("UCI HAR Dataset/train/x_train.txt", 
                     header = FALSE, 
                     sep = "")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
                     header = FALSE, 
                     sep = "")

##Combine the subject, test type, and the data into a single data frame
trainstats <- cbind(subject_train, y_train, x_train)

##Add a column that indicates which data set is represented
set <- rep("train", 7352)
##Add the dataset label into the data frame
trainstatsfull <- cbind(set, trainstats)
##Rename the headers
names(trainstatsfull) <- heading


##Combine the sets
phonedata <- rbind(trainstatsfull, teststatsfull)

##Add descriptive labels to the type of test column
phonedata$test <- as.factor(phonedata$test)
levels(phonedata$test) <- c("walking", "walking_upstairs", 
                            "walking_downstairs", "sitting", 
                            "standing", "laying")

#Only keep the columns with data regarding means and stds
meancols <- grep("[Mm]ean", heading)
stdcols <- grep("std", heading)
goodcols <- c(1:3, meancols, stdcols)
pick <- sort(goodcols)
msdata <- phonedata[, pick]


##Make the final tidy dataset with one mean and mean std dev
##for each value for each subject/test combination

##combine subject and test into one column so they can be sorted together
sub_test <- paste(msdata$subject, ",", msdata$test, sep = "")
sortable <- cbind(sub_test, msdata)
##melt the data and apply dcast
newheads <- names(msdata)
datamelt <- melt(sortable, id= 1:4, 
                 measure.vars = 5:90)
quickdata <- dcast(datamelt, sub_test ~ variable, mean)

##separate the subject and test columns again
tidydata <- separate(quickdata, sub_test, into = c("subject", "test"), 
                        sep = ",", remove = TRUE)
##make the subject column numeric
tidydata$subject <- as.numeric(tidydata$subject)
tidydata <- arrange(tidydata, tidydata$subject)

##Show the new fancy tidy data!
View(tidydata)
