## Code book for "Getting and Cleaning Data - Peer Assignment"

### Data Extracted
Following text files were uploaded to R variables,

* X_test.txt -> X_test
* X_train.txt -> X_train
* y_test.txt -> y_test
* y_train.txt -> y_train
* subject_test.txt -> subject_test
* subject_train.txt -> subject_train
* features.txt -> features

### Variables and Transformation

* Variables merged 'X_train' and 'X_test' to single dataset variable 'X_dataset' using "merge" function
* Column names are assigned to 'X_dataset' from 'features' for all features variable using "colnames" function
* Variables merged 'Y_train' and 'Y_test' to form 'Activity_dataset' using "rbind" function
* Variables merged 'subject_train' and 'subject_test' to form 'Subject_dataset' using "rbind" function
* Variables merged 'Activity_dataset','Subject_datase't and 'X_dataset' to form 'dataset' using "cbind" function
* Using "grep" function, filtered the necessary columns 'mean','std','ActivityID' and 'SubjectID'
* Based on index of "grep" function, columns appended to new dataframe 'Extracted_dataset' usinig "cbind" function and column names assigned by using "colnames" function
* Subsetting the value of 'ActivityLabels' to 'ActivityID'
* Re-ordering the columns of 'Extracted_dataset' dataframe using "colnames()" function and assigned labels 'ActivityID','SubjectID'
* Melting the dataframe with id as 'ActivityID','SubjectID' using "melt()" function and assigned to 'melted_data'
* Now, to find the mean grouping by the 'ActivityID','SubjectID' using "dcast()" function to dataframe 'Tidydata'
* Finally writing the output from 'Tidydata' dataframe to text file "Tidydata.txt"
