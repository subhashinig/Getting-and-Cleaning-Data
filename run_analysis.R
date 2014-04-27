## ------------------------------------------------- Peer Assignments - Getting and Cleaning Data --------------------------------------------- ##
##  You should create one R script called run_analysis.R that does the following. 
##  1. Merges the training and the test sets to create one data set.
##  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3. Uses descriptive activity names to name the activities in the data set
##  4. Appropriately labels the data set with descriptive activity names. 
##  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##  Date: 27/04/2014
## -------------------------------------------------------------------------------------------------------------------------------------------- ##

library(reshape2) ##library should be loaded to use in the analysis

setwd("C:/Users/GopalanS/Documents/Adi/DataScience/Wk_3/Getting & Cleaning data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/") 												##setting working directory

X_test <- read.table("C:/Users/GopalanS/Documents/Adi/DataScience/Wk_3/Getting & Cleaning data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt") 					##reading X_test to X_test data frame
X_train <- read.table("C:/Users/GopalanS/Documents/Adi/DataScience/Wk_3/Getting & Cleaning data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt") 				##reading X_train to X_train data frame

Y_test <- read.table("C:/Users/GopalanS/Documents/Adi/DataScience/Wk_3/Getting & Cleaning data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt") 					##reading Y_test to Y_test data frame
Y_train <- read.table("C:/Users/GopalanS/Documents/Adi/DataScience/Wk_3/Getting & Cleaning data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt") 				##reading Y_train to Y_train data frame

subject_test <- read.table("C:/Users/GopalanS/Documents/Adi/DataScience/Wk_3/Getting & Cleaning data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt") 		##reading subject_test to subject_test data frame
subject_train <- read.table("C:/Users/GopalanS/Documents/Adi/DataScience/Wk_3/Getting & Cleaning data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt") 	##reading subject_train to subject_train data frame

features<-read.table("C:/Users/GopalanS/Documents/Adi/DataScience/Wk_3/Getting & Cleaning data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt") 					##reading features to features data frame

##	1. Merges the training and the test sets to create one data set ---------------------------------------------------------------------------- ##

X_dataset<-NULL 													##assigning NULL to clear, if any junks
Activity_dataset<-NULL												##assigning NULL to clear, if any junks
Subject_dataset<-NULL												##assigning NULL to clear, if any junks

X_dataset <- merge(X_train,X_test,all=TRUE)							##merging all features variable to single dataset

colnames(X_dataset)<-features[,2] 									##assigning labels to all features variable

Activity_dataset<-rbind(Y_train,Y_test) 							##binding ActivityID of both train & test
Subject_dataset<-rbind(subject_train,subject_test) 					##binding SubjectID of both train & test

colnames(Activity_dataset)<-c("ActivityID")							##assigning label to Activity_dataset
colnames(Subject_dataset)<-c("SubjectID")							##assigning label to Subject_dataset

dataset<-cbind(Activity_dataset,Subject_dataset,X_dataset)			##binding all data to form giant dataset for study analysis

#	2. Extracts only the measurements on the mean and standard deviation for each measurement --------------------------------------------------- ##

x<-grep("*Activity*|*Subject*|*mean\\()*|*std\\()*",names(dataset)) ##filtering necessary columns for given analysis and index will be assigned -> x

Extracted_dataset<-NULL												##assigning NULL to clear, if any junks

for (i in 1:length(x))
{
  temp_dataset<-dataset[,x[i]]									## pulling particular column of dataset based on index
  Extracted_dataset<-cbind(Extracted_dataset,temp_dataset)		## binding column data to new data frame
  colnames(Extracted_dataset)[i]<-colnames(dataset)[x[i]]			## assigning colnames to new data frame
  rm(temp_dataset)												## removing temporary data frame
}
Extracted_dataset<-as.data.frame(Extracted_dataset)					## converting to data frame

##	3. Uses descriptive activity names to name the activities in the data set -------------------------------------------------------------------- ##
##	4. Appropriately labels the data set with descriptive activity names ------------------------------------------------------------------------- ##

Extracted_dataset$ActivityLabels <- "unset"											## subsetting the Activity labels for the given ActivityID
Extracted_dataset$ActivityLabels[Extracted_dataset$ActivityID == 1] <- "WALKING"
Extracted_dataset$ActivityLabels[Extracted_dataset$ActivityID == 2] <- "WALKING_UPSTAIRS"
Extracted_dataset$ActivityLabels[Extracted_dataset$ActivityID == 3] <- "WALKING_DOWNSTAIRS"
Extracted_dataset$ActivityLabels[Extracted_dataset$ActivityID == 4] <- "SITTING"
Extracted_dataset$ActivityLabels[Extracted_dataset$ActivityID == 5] <- "STANDING"
Extracted_dataset$ActivityLabels[Extracted_dataset$ActivityID == 6] <- "LAYING"
Extracted_dataset$ActivityLabels <- as.factor(Extracted_dataset$ActivityLabels)		## adding a new column for ActivityLabels in Extracted_dataset

Extracted_dataset<-cbind(Extracted_dataset[,69],Extracted_dataset[,2],Extracted_dataset[,3:68])		## re-ordering the columns
colnames(Extracted_dataset)[1]<-"ActivityID"														## assigning label on re-order dataset
colnames(Extracted_dataset)[2]<-"SubjectID"															## assigning label on re-order dataset

##	5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject ------------------------- ##

melted_data<-melt(Extracted_dataset,id=c("ActivityID","SubjectID"))					## melting the data 
Tidydata<-dcast(melted_data, SubjectID + ActivityID ~ variable, mean)				## casting the data to get mean for final tidy dataset

## ----------------------------------------------------- OUTPUT --------------------------------------------------------------------------------- ##
write.table(Tidydata,"C:/Users/GopalanS/Documents/Adi/DataScience/Wk_3/Getting & Cleaning data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/tidydata.txt")## tidy data will be generated in the specified path
