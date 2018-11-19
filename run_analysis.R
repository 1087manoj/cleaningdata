#File name run_analysis.R
#Created by Manoj Medarametla
#Created on 2018-11-19

#Please note, this script assume the working directory is 
#already set to Samsung data as mentioned in the instrcutions

#if data.table is not installed, install it before loading
#Required for melting & casting
if (!"data.table" %in% installed.packages()) {
  install.packages("data.table")
}
library(data.table)

#if dplyr is not installed, install it before loading
#Required for joining
if (!"dplyr" %in% installed.packages()) {
  install.packages("dplyr")
}
library(dplyr)

#read the train data
trvect <- read.table(".\\train\\X_train.txt")
trlabels <- read.table(".\\train\\Y_train.txt")
trsub <- read.table(".\\train\\subject_train.txt")

#read the test data
tstvect <- read.table(".\\test\\X_test.txt")
tstlabels <- read.table(".\\test\\Y_test.txt")
tstsub <- read.table(".\\test\\subject_test.txt")

#read info data & add the labels
actlbls <- read.table("activity_labels.txt")
names(actlbls) <- c("activity.id","activity.name")

features <- read.table("features.txt")
names(features) <- c("feature.id","feature.name")


#1. Merge the training and the test sets to create one data set.

##merge subjects & add the labels
sub <- rbind(trsub,tstsub)
names(sub) <- c("subject")

##merge vectors & add the labels
vect<-rbind(trvect,tstvect)
names(vect) <- features$feature.name

##merge labes & add the labels
lbls <- rbind(trlabels,tstlabels)
names(lbls) <- c("activity.id")

##Combine three tables
ds <- cbind(sub,lbls,vect)

#2. Extracts only the measurements on the mean and standard deviation for each 
#   measurement.
meanstd<-ds[,grep("^sub|^act|mean()|std()",names(ds),value = TRUE)]

#3. Uses descriptive activity names to name the activities in the data set
meanstd <- meanstd %>% inner_join(actlbls,by = "activity.id")

#4. Appropriately labels the data set with descriptive variable names.

#all the columns are appropriatel labelled already! e.g., subject or activity.id etc
#please use names(meanstd) to check the labels for completion

#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
melted <- melt(data.table(meanstd)
               ,id.vars = c("subject","activity.name")
               ,measure.vars = grep("mean()|std()",names(meanstd),value = TRUE))

tidydata <- dcast(melted, subject+activity.name ~ variable, mean)

#Write the tidy data into file
write.table(tidydata,"tidydata.txt",row.names = FALSE)