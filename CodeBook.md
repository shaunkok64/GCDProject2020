1.	Install the following library
      a.	library(tidyverse)
      b.	The following packages are loaded by default:
            i.	   library(dplyr)
            ii.	library(forcats)
            iii.	library(ggplot2)
            iv.	library(purrr)
            v.	   library(readr)
            vi.	library(stringr)
            vii.	library(tibble)
            viii.	library(tidyr)

2.	Download the file from the link provided:
      a.	https://d396qusza40orc.cloudfront.net
            /getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

3.	Read-in the UCI HAR Dataset (8 files)
      a.	("./UCI HAR Dataset/features.txt")
      b.	("./UCI HAR Dataset/activity_labels.txt")
      c.	("./UCI HAR Dataset/test/subject_test.txt")
      d.	("./UCI HAR Dataset/test/x_test.txt")
      e.	("./UCI HAR Dataset/test/y_test.txt")
      f.	("./UCI HAR Dataset/train/subject_train.txt")
      g.	("./UCI HAR Dataset/train/x_train.txt")
      h.	("./UCI HAR Dataset/train/y_train.txt")

** Information about the dataset: UCI HAR Dataset
      a. README.txt
      b.	features.txt 
      c. features_info.txt

** Inertial Signals: The files within are not part of this project assignment 
                     at this time.

4.	Generate two data sets: SubjectTest and SubjectTrain using cbind.
      a.	SubjectTest <- cbind(ytest, subjecttest, xtest)
      b.	SubjectTrain <- cbind(ytrain, subjecttrain,  xtrain)

5.	Assign column names to the two data sets as follows:
      a.	Column 1:      "Code"
      b.	Column 2:      "Subject"
      c.	Column 3:563:  Values from features.txt
      d.	Assignment of column names can be performed during the initial 
            reading of the text files in R.

6.	Write the datasets to file: write.csv()
      a.	write.csv(SubjectTest, "SubjectTest.csv", row.names = FALSE)
      b.	write.csv(SubjectTrain, "SubjectTrain.csv", row.names = FALSE)

7.	Create a single dataset:
      a.	Combine the two datasets into a single dataset using rbind().
            i.	SubjectTestTrain <- rbind(SubjectTest, SubjectTrain)
      b.	Combine SubjectTestTrain and Activity datasets using merge()
            i.	SubjectTestTrain <- merge(SubjectTestTrain, activity, by = "Code")
      c.	Rearrange the columns: " Code, Subject, Activity" ....
            i.	SubjectTestTrain <- SubjectTestTrain[, c(1, 2, 564, 3:563)]
      d.	Arrange the file according to "Code ==> Subject"
            i.	SubjectTestTrain <- arrange(SubjectTestTrain, Code, Subject)
      e.	Write the dataset to file: write.csv(SubjectTestTrain, "SubjectTestTrain.csv", row.names = FALSE)

8.	Add descriptive titles to the dataset.
      a.	Edit the list of names provided in features.txt The list contains 561
            items so editing in a text editor would be tedious.
      b.	Edit the list of names using a combination of R commands (sub(), 
            gsub(), grep(), grepl(), etc.) and the appropriate regex expression.
            i.	https://rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf
      c.	Use consistent formatting.
      d.	Remember the goal is to improve the appearance, readability, and 
            information.
      e. Perform a comparison of the two sets of column names:
            SubjectTestTrain_Vector
            SubjectTestTrain_Vector_New
      f. write.csv(ComparisonColumnNames, "ComparisonColumnNames.txt", row.names = FALSE)

9.	Subset the dataset, SubjectTestTrain: 
      a.	Select columns containing the means and standard deviations for the 
            variables collected during the course of the study. Assign the values 
            to a new dataset
      b.	MSD <- SubjectTestTrain %>% select(contains("Mean"), contains("Std"))
      c.	TidyData_1 <- cbind(SubjectTestTrain[, 1:3], MSD)
      d.	TidyData_1 <- arrange(TidyData_1, Code, Subject)
      e.	write.csv(TidyData_1, "TidyData_1.csv", row.names = FALSE)

10.	Edit/Add descriptive variable labels if necessary.

11.	Create a second, independent tidy data set with the average of each 
      variable for each activity and each subject.
      a.	TidyData_2 <- TidyData_1 %>%
         	   group_by(Subject, Activity) %>%
   	         summarise_all(list(mean))
      b.	TidyData_2 <- arrange(TidyData_2, Subject, Code)      

12.   Write to file:
	a.    write.csv(TidyData_2, "TidyData_2.csv", row.names = FALSE)

13.   Data Parameters: (run_analysis.R)
      Num	Name	                           Class	                  Dimensions
      1	   activity	                        data.frame	            6 obs. of  2 variables
      2     ComparisonColumnNames            data.frame              564 obs. of 3 variables
      3	   features	                        data.frame	            561 obs. of  2 variables
      4     MSD                              data.frame              10299 obs. of 86 variables
      5	   subject_test	                  data.frame	            2947 obs. of  1 variable
      6	   subject_train	                  data.frame	            7352 obs. of  1 variable
      7	   SubjectTest	                     data.frame        	   2947 obs. of  563 variables
      8	   SubjectTestTrain	               data.frame	            10299 obs. of 564 variables
      9     SubjectTestTrain_Vector          data.frame              564 obs. of 2 variables
      10    SubjectTestTrain_Vector_New      data.frame              564 obs. of 2 variables
      11	   SubjectTrain	                  data.frame	            7352 obs. of  563 variable      
      12	   TidyData_1   	                  data.frame	            10299 obs. of 89 variables
      13	   TidyData_2     	               data.frame 	            180 obs. of  176 variables
      14    TidyData_Vector                  data.frame              89 obs. of 2 variables         
      15    x_test	                        data.frame	            2947 obs. of  561 variables
      16	   x_train	                        data.frame        	   7352 obs. of  561 variables
      17	   y_test	                        data.frame	            2947 obs. of  1 variable
      18	   y_train	                        data.frame	            7352 obs. of  1 variable


14.   Results: (run_alysis.R)
      Num   Name
      1     ComparisonColumnNames.csv
      2     Features.txt
      3     Features_1.txt
      4     SubjectTest.csv
      5     SubjectTestTrain.csv
      6     SubjectTestTrain_Vector.csv
      7     SubjectTestTrain_Vector_New.csv
      8     SubjectTrain.csv    
      9     TidyData_1.csv
      10    TidyData_2.csv
      11    TidyData_Vector.csv


