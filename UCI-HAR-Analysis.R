# Download data

fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}


# 1. Merges the training and the test sets to create one data set.

train <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_activity <- read.table("./UCI HAR Dataset/train/Y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_subject, train_activity, train)

test <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_activity <- read.table("./UCI HAR Dataset/test/Y_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_subject, test_activity, test)

features_raw <- read.csv("./UCI HAR Dataset/features.txt", sep="", header=FALSE)
features <- grep("mean|std", features_raw[,2])

all_data <- rbind(train, test)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

req_data <- all_data[,c(1,2,features+2)]
feature_col<-features_raw[features,2]

colnames(req_data) <- c("subject", "activity", as.character(feature_col))

# 3. Uses descriptive activity names to name the activities in the data set

activity_labels <- read.csv("./UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
activity_labels <- as.character(activity_labels[,2])
req_data$activity <- activity_labels[req_data$activity]


# 4. Appropriately labels the data set with descriptive variable names.

data_names <- names(req_data)
data_names <- gsub("[(][)]", "", data_names)
data_names <- gsub("^t", "TimeDomain_", data_names)
data_names <- gsub("^f", "FrequencyDomain_", data_names)
data_names <- gsub("Acc", "Accelerometer", data_names)
data_names <- gsub("Gyro", "Gyroscope", data_names)
data_names <- gsub("Mag", "Magnitude", data_names)
data_names <- gsub("-mean-", "_Mean_", data_names)
data_names <- gsub("-std-", "_StandardDeviation_", data_names)
data_names <- gsub("-", "_", data_names)
names(req_data) <- data_names

req_data$activity <- as.factor(req_data$activity)
req_data$subject <- as.factor(req_data$subject)


# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

if (!"reshape2" %in% installed.packages()){install.packages("reshape2")}
library(reshape2)

melt_data <- melt(req_data, id = c("subject", "activity"))
mean_data <- dcast(melt_data, subject + activity ~ variable, mean)


# save data
write.table(mean_data, "UCI-HAR-tidy_data.txt", row.names = FALSE, quote = FALSE)

#Final Check Stage
str(mean_data)
View(mean_data)
