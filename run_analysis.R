##Peer project Getting and Cleaning Data
### August 22th 2014

setwd("C:/Users/Ingrid/desktop/Coursera/GettingCleaningData/data") 

#######Step 1: Read label and variable information into R
File_feature<-"C:/Users/Ingrid/Desktop/Coursera/GettingCleaningData/data/activity/UCI HAR Dataset/features.txt"
feature<-read.table(File_feature)

File_activitylabels<-"C:/Users/Ingrid/Desktop/Coursera/GettingCleaningData/data/activity/UCI HAR Dataset/activity_labels.txt"
activitylabels<-read.table(File_activitylabels)

#######Step 2: Read Test-data into R and add names to make it a tidy dataset
#read TEST-data file into R
File_test<-"C:/Users/Ingrid/Desktop/Coursera/GettingCleaningData/data/activity/UCI HAR Dataset/test/X_test.txt"
data_test<-read.table(File_test)

# add variable names == feature$V2 as columnames to TEST-dataset
feature$columnames <- as.character(feature$V2)
names(data_test)<-feature$columnames

#read Subject-identifier TEST-data into R
File_subjects_test<-"C:/Users/Ingrid/Desktop/Coursera/GettingCleaningData/data/activity/UCI HAR Dataset/test/subject_test.txt"
subjects_test<-read.table(File_subjects_test)
        ##add subject identifier column to TEST-data
        data_test$subject<-subjects_test$V1

#read label test.txt file in to R and apply to TEST-dataset as column 'activity'
File_testlabels<-"C:/Users/Ingrid/Desktop/Coursera/GettingCleaningData/data/activity/UCI HAR Dataset/test/y_test.txt"
labels_test<-read.table(File_testlabels)
        ##add activity labels as column 'activity'to TEST-data
        data_test$activity<-labels_test$V1

#######Step 3: Read Train-data into R and add names to make it a tidy dataset
#read TEST-data file into R
File_train<-"C:/Users/Ingrid/Desktop/Coursera/GettingCleaningData/data/activity/UCI HAR Dataset/train/X_train.txt"
data_train<-read.table(File_train)

# add variable names == feature$V2 as columnames to TRAIN-dataset
feature$columnames <- as.character(feature$V2)
names(data_train)<-feature$columnames

#read Subject-identifier TRAIN-data into R
File_subjects_train<-"C:/Users/Ingrid/Desktop/Coursera/GettingCleaningData/data/activity/UCI HAR Dataset/train/subject_train.txt"
subjects_train<-read.table(File_subjects_train)
        ##add subject identifier column to data-train
        data_train$subject<-subjects_train$V1

#read label test.txt file in to R and apply to TRAIN-dataset as column 'activity'
File_trainlabels<-"C:/Users/Ingrid/Desktop/Coursera/GettingCleaningData/data/activity/UCI HAR Dataset/train/y_train.txt"
labels_train<-read.table(File_trainlabels)
        ##add activity labels as column 'activity'to TRAIN-data
        data_train$activity<-labels_train$V1

#########STEP 4: Merge test & train datasets to create one dataframe (DF).
DF<-rbind(data_test,data_train)


#########STEP 5: Extract only columns with measurements on mean and standard deviation for each measurement
#make vector of columnnumbers containing mean() or std() data of each measurement
# plus information on labels and subject.
subset<-c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543, 562:563)
subsetDF<-DF[ ,subset]

####### STEP 6: Assign descriptive activity names to name the activities in the data set
subsetDF$activitylabel<-factor(subsetDF$activity, labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

########STEP 7; Appropriately label the data set with descriptive variable names. 
names(subsetDF)<-gsub("-|\\()", "", names(subsetDF))

########STEP 8; write .txt file for upload in coursera website
?write.table()
write.table(subsetDF, file="./TidyDataset.txt",row.names=FALSE)



