library(data.table)
library(plyr)


# get names from features
col_names <- read.table("UCI HAR Dataset/features.txt")

# get activities
acts <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("ID", "Act"))

# get data with labels
ttable <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=col_names[,2])

# get subject IDs
tsubj <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names="SubjID")

# get activities
tact <- read.table("UCI HAR Dataset/train/y_train.txt", col.names="Activity")

# combine to table
data <- cbind(tsubj, tact, ttable)

# now do the same for test data...

# get data with labels
tttable <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=col_names[,2])

# get subject IDs
ttsubj <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="SubjID")

# get activities
ttact <- read.table("UCI HAR Dataset/test/y_test.txt", col.names="Activity")

# combine test data to table
test_table <- cbind(ttsubj, ttact, tttable)

# combine to one big table
data <- rbind(data, test_table)

# get subjID & Activity columns
subjid <- data[, 1:2]

# get columns with 'std'
cols_std <- data[, grep("std", names(data))]

# get columns with means
cols_mean <- data[, grep("mean", names(data), fixed=TRUE)]

# remove columns with meanFreq
cols_mean <- cols_mean[, grep("meanFreq", names(cols_mean), fixed=TRUE, invert=TRUE)]

# now stick the three back together
data <- cbind(subjid, cols_mean, cols_std)

# put text instead of numbers for activities
data[, "Activity"] <- acts[data[,2], 2]

# prepare new table for export
dtab <- data.table(data)
final <- as.data.frame(dtab[,lapply(.SD,mean), by=c("SubjID","Activity")])

# sort by SubjID, then Activity
final <- arrange(final, SubjID, Activity)

# write tidy data
write.table(final, "tidy.txt", row.name=FALSE)
