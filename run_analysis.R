#reading data set into r data frames

train_data <- read.table(text = gsub("  ", " ", readLines('UCI HAR Dataset/train/X_train.txt')))
test_data <- read.table(text = gsub("  ", " ", readLines('UCI HAR Dataset/test/X_test.txt')))
variable_names <- read.delim('UCI HAR Dataset/features.txt',header = FALSE,sep = " ")
train_activities <- read.delim('UCI HAR Dataset/train/y_train.txt',header = FALSE)
test_activities <- read.delim('UCI HAR Dataset/test/y_test.txt',header = FALSE)
activity_labels <- read.delim('UCI HAR Dataset/activity_labels.txt', header = FALSE, sep = " ")
train_subjects <- read.delim('UCI HAR Dataset/train/subject_train.txt',header = FALSE)
test_subjects <- read.delim('UCI HAR Dataset/test/subject_test.txt',header = FALSE)

library(plyr) #for mapvalues()
library(dplyr) 

#combining the train and test sets

merged_data <- merge(train_data,test_data, all = TRUE, sort = FALSE)

#labeling the data set with descriptive variable names

colnames(merged_data) <- variable_names$V2

#Extracting only the measurements on the mean and standard deviation for each measurement

only_means <- select(merged_data,grep("mean()",colnames(merged_data), fixed = TRUE,value = TRUE))
only_sd <- select(merged_data,grep("std()",colnames(merged_data), fixed = TRUE,value = TRUE))
only_mean_and_sd_data <- cbind(only_means,only_sd)

#descriptive activity names to name the activities in the data set
activities <- data.frame(v1=character(0))
activities <- rbind(activities,train_activities)
activities <- rbind(activities,test_activities)
desc_activity_colmn <- mapvalues(activities$V1,activity_labels$V1,activity_labels$V2)
only_mean_and_sd_data <- cbind(only_mean_and_sd_data, activity.description = desc_activity_colmn)

#average of each variable for each activity and each subject

subjects <- data.frame(v1=character(0))
subjects <- rbind(subjects,train_subjects)
subjects <- rbind(subjects,test_subjects)
only_mean_and_sd_data <- cbind(only_mean_and_sd_data, subject = subjects$V1)
valid_column_names <- make.names(names=names(only_mean_and_sd_data), unique=TRUE, allow_ = TRUE)
names(only_mean_and_sd_data) <- valid_column_names #labeling the data set with descriptive variable names
grouped_by_activity_and_subject <- only_mean_and_sd_data %>% group_by(activity.description,subject)
mean_for_each_activity_and_subject <- grouped_by_activity_and_subject %>% summarise_at(1:66,mean)

