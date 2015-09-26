# load data
X_train <- read.table('UCI HAR Dataset/train/X_train.txt', header = FALSE)
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt', header = FALSE)
y_train <- read.table('UCI HAR Dataset/train/y_train.txt', header = FALSE)

X_test <- read.table('UCI HAR Dataset/test/X_test.txt', header = FALSE)
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt', header = FALSE)
y_test <- read.table('UCI HAR Dataset/test/y_test.txt', header = FALSE)

features <- rbind(X_train, X_test)
subjects <- rbind(subject_train, subject_test)
labelIndex <- rbind(y_train, y_test)

# extract relevant features and properly name columns
featureNames <- read.table('UCI HAR Dataset//features.txt', header = FALSE)
toExtract <- sapply(featureNames[, 2], function(featureName) length(grep('mean()', featureName)) > 0 || length(grep('std()', featureName)) > 0)
features <- features[, toExtract]
colnames(features) <- featureNames[toExtract, 2]

# append labels and subjects to the right of the feature data frame
activities <- c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING')
features$label <- sapply(labelIndex[, 1], function(index) activities[index])
features$subject <- subjects[, 1]

# calculate mean by activity and subject
featureMean <- aggregate(features[, 1:(ncol(features) - 2)], list(features$label, features$subject), mean)
write.table(featureMean, file = 'TidyDataSet.txt', row.name = FALSE)
