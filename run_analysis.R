##load & preprocess the data
features=read.table("C:\\Users\\frozenl\\Desktop\\coursera\\project 6\\UCI HAR Dataset\\features.txt", header=FALSE, sep="")
features=as.character(features[ ,2])
train_x=read.table("C:\\Users\\frozenl\\Desktop\\coursera\\project 6\\UCI HAR Dataset\\train\\X_train.txt", header=FALSE, sep="")
train_y=read.table("C:\\Users\\frozenl\\Desktop\\coursera\\project 6\\UCI HAR Dataset\\train\\y_train.txt", header=FALSE, sep="")
train_subject=read.table("C:\\Users\\frozenl\\Desktop\\coursera\\project 6\\UCI HAR Dataset\\train\\subject_train.txt", header=FALSE, sep="")
data_train=data.frame(train_subject,train_y,train_x)
names(data_train)=c("subject", "y", features)
test_x=read.table("C:\\Users\\frozenl\\Desktop\\coursera\\project 6\\UCI HAR Dataset\\test\\X_test.txt", header=FALSE, sep="")
test_y=read.table("C:\\Users\\frozenl\\Desktop\\coursera\\project 6\\UCI HAR Dataset\\test\\y_test.txt", header=FALSE, sep="")
test_subject=read.table("C:\\Users\\frozenl\\Desktop\\coursera\\project 6\\UCI HAR Dataset\\test\\subject_test.txt", header=FALSE, sep="")
data_test=data.frame(test_subject,test_y,test_x)
names(data_test)=c("subject", "y", features)

##merge the data
data=rbind(data_train, data_test)

##extract the measurements on the mean and standard deviation
mean_std_measurements=grep("mean|std", features)
mean_std_select=data[, c(mean_std_measurements+2)]

##use descriptive activity names to name the activities
activity_labels=read.table("C:\\Users\\frozenl\\Desktop\\coursera\\project 6\\UCI HAR Dataset\\activity_labels.txt", header=FALSE, sep="")
activity_labels=as.character(activity_labels[ ,2])
data_select=data[, c(1,2,mean_std_measurements+2)]
data_select$y=activity_labels[data_select$y]

##label the data set with descriptive variable names
name=names(data_select)
name=gsub("[(][)]","", name)
name=gsub("^t","Time_", name)
name=gsub("^f","Frequency_", name)
name=gsub("Acc","Accelerometer", name)
name=gsub("Gyro","Gyroscope", name)
name=gsub("Mag","Magnitude", name)
name=gsub("mean","Mean", name)
name=gsub("std", "StandardDeviation", name)
name=gsub("-","_", name)
names(data_select)=name

##create a tidy data set with average of each variable
tidy_data=aggregate(data_select[,3:81], by=list(y=data_select$y, subject=data_select$subject), FUN=mean)
write.table(x=tidy_data, file="C:\\Users\\frozenl\\Desktop\\coursera\\project 6\\tidy_data.txt", row.names=FALSE)

