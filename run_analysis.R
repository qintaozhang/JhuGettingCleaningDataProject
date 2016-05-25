setwd("C:\\qtzhang\\study\\Classes\\John Hopkins data science\\Getting and Cleaning Data\\week4\\UCI HAR Dataset")
#read feature name
features<-read.table("./features.txt",header = FALSE)
#read train raw data
train_dataset<-read.table("./train/X_train.txt",header = FALSE)
#change column name to features
colnames(train_dataset)=features[,2]
#read training labels
train_label<-read.table("./train/y_train.txt",header = FALSE)
#combin train label to a new column to train dataset
train_dataset[,"labels"]<-train_label[,1]
#read train subject and combin to data
train_subject<-read.table("./train/subject_train.txt",header = FALSE)
train_dataset[,"subjects"]<-train_subject[,1]
train_dataset[,"train_test"]<-"train"

#repeat same process for test dataset
#read test raw data
test_dataset<-read.table("./test/X_test.txt",header = FALSE)
#change column name to features
colnames(test_dataset)=features[,2]
#read test labels
test_label<-read.table("./test/y_test.txt",header = FALSE)
#combin test label to a new column to test dataset
test_dataset[,"labels"]<-test_label[,1]
#read test subject and combin to test data
test_subject<-read.table("./test/subject_test.txt",header = FALSE)
test_dataset[,"subjects"]<-test_subject[,1]
#lable test and train in original dataset
test_dataset[,"train_test"]<-"test"


#First step: combine test and train to form a new dataset
train_test<-rbind(train_dataset,test_dataset)
#remove unused dataset
rm(train_dataset,train_item,train_label,features,test_label,test_dataset)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
#get names from trian_test
train_test_names <-names(train_test)
mean_std<-grep("mean()|std()|labels|subjects",train_test_names)
mean_std_data<-train_test[,mean_std]


#step3:Uses descriptive activity names to name the activities in the data set
label_longname<-read.table("./activity_labels.txt",header = FALSE)
colnames(label_longname)=c("labels","Activity.Long.Name")
#merge the train_test with longname labels
mean_std_data<-merge(mean_std_data,label_longname,by.x="labels",by.y="labels",all=FALSE)
rm(label_longname,test_subject,train_subject)
#step4 done in the step1

#step5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
mean_std_data_nogroup<-subset( mean_std_data, select = -c(Activity.Long.Name,subjects) )
tidyMean<-aggregate(x = mean_std_data_nogroup, by = list(Activity.Long.Name=mean_std_data[,"Activity.Long.Name"],subjects=mean_std_data[,"subjects"]), FUN = "mean")
write.csv(tidyMean,"tidyMean.csv")
