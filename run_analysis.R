
library(reshape2)

#Read all the text files into appropriate frames

activity_labels <- read.table('./activity_labels.txt')[,2]
featurenames<-as.vector(read.table('./features.txt')[,2])
test_subjectnames<- read.table('./test/subject_test.txt')
test_featurevalues <- read.table('./test/X_test.txt')
test_activities <- factor(read.table('./test/y_test.txt')[,1])
levels(test_activities) <- activity_labels
testframe <- data.frame(test_subjectnames,test_activities,test_featurevalues)
colnames(testframe) <- c("SubjectNum","Activity",featurenames)



train_subjectnames<- read.table('./train/subject_train.txt')
train_featurevalues <- read.table('./train/X_train.txt')
train_activities <- factor(read.table('./train/y_train.txt')[,1]) 
levels(train_activities) <- activity_labels
trainframe <- data.frame(train_subjectnames,train_activities,train_featurevalues)
colnames(trainframe) <- c("SubjectNum","Activity",featurenames)

totalframe <- rbind(trainframe,testframe)

#Extract the columns with mean and std. Also retain the first 2 columns (activity
# name and subject name)

good_cols<-
        grepl("std",names(totalframe))|grepl("mean",
        names(totalframe))|names(totalframe)=="SubjectNum" | names(totalframe) == "Activity"
goodframe<- totalframe[,good_cols]

#Replace 'std' with StandardDev
names(goodframe)<-gsub("std","StandardDeviation",names(goodframe))

#Remove '-' and '()' from column names
names(goodframe)<- gsub("[[:punct:]]", "", names(goodframe))
names(goodframe)<- gsub(" ", "", names(goodframe))

#Replace 'Acc' with 'acceleration', 'Mag' with 'magnitude'
names(goodframe)<- gsub("Acc", "Acceleration", names(goodframe))
names(goodframe)<- gsub("mean", "Mean", names(goodframe))
names(goodframe)<- gsub("Mag", "Magnitude", names(goodframe))
names(goodframe)<- gsub("Gyro", "Gyroscope", names(goodframe))
names(goodframe)<- gsub("Freq", "Frequency", names(goodframe))

#Fix the repetition in BodyBody
names(goodframe)<- gsub("BodyBody", "Body", names(goodframe))

#Replace 't' with 'time' and 'f' with 'frequency'
names(goodframe)<- gsub("^t", "time", names(goodframe))
names(goodframe)<- gsub("^f", "FFT", names(goodframe))


# Melt the data set
melted<-melt(goodframe,id=c("SubjectNum","Activity"),
             measure.vars=colnames(goodframe)[3:ncol(goodframe)])

# Recast the data set
casted<-dcast(melted,SubjectNum+Activity ~ variable,mean)

# Write the final data set to a file
write.table(casted,'TidyData2.txt',row.names=FALSE)