<h1> Project </h1>
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

<h2> Data & it's background </h2>
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

<h2> Project Contents </h2>

* **README.TXT**  - Describes how the script works
* **Codebook.md** - Describes the variables, the data, and any transformations or work that is performed to clean up the data
* **run_analysis.R** -R script which is on running cleans up the data and writes the tidy data. More details after this secion.
* **tidydata.TXT** - Tidy data set with the average of each variable for each activity and each subject. Result of run_analysis.R

<h3> More on run_analysis.R </h3>

It contains the R script whose job is to
1. Merges the training and the test sets to create one data set. I used *rbind*  and *cbind* mainly for this task
2. Extracts only the measurements on the mean and standard deviation for each measurement. *grep* is used to find the columns with the matching criteria
3. Uses descriptive activity names to name the activities in the data set. *inner_join* is used to add the activity names to the subset of the data of Step2
4. Appropriately labels the data set with descriptive variable names. Inserted the column names into header by accessing it using *names*
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. Used *melt* & *cast* for this task.
6. The tidy data resulted from the Step 5 is written to tidydata.txt using *write.table()* with paramenter *row.name=FALSE*

***These steps in-detail in addition to all the necessary information is mentioned in the file itself in readable format***
