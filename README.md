run_analysis.R

#Title: Generate Tidy Data for Activity Sensor Measurements.

##Usage:
  unzip the getdata_projectfiles_UCI HAR Dataset.zip file into a directory named "data"
      directly under a project directory of your choice.
  
  Edit the run_analysis.R file.
	source the run_analysis.R file.
  
  Find the results in the runAnalysisCleanAveragedReplicationMeasurements.txt file.
	The program also generates two .csv file, intended only for convenience checking.

##Details:

  To edit the run_analysis.R file and change one line as follows.
	Change the file path to match the path to your working directory (where you unzipped the input file).
	
  projectPath = file.path("C:","edu","_DataScienceJohnsHopkins","_GettingCleaningData","Project")
	
  So, if your project directory is as shown, "Project", it must contain a directory "data" in which 
	  you have unzipped the input file.

##Note:

    The program will install a package and load packages that it requires. No dependency preparation by user is needed.


The unzipped hierarchy should resemble this:
	
data:

drwxrwxrwx+ 1 You  None        0 Jul 20 17:22 getdata_projectfiles_UCI HAR Dataset

-rwxrwxrwx+ 1 You  None 62556944 Aug 26 14:35 getdata_projectfiles_UCI HAR Dataset.zip

-rwxrwxrwx+ 1 You  None      421 Aug 26 14:16 UCI Machine Learning Repository Human Activity Recognition Using Smartphones Data Set.website


data/getdata_projectfiles_UCI HAR Dataset:

-rwxrwxrwx+ 1 You  None 15971 Jul 20 17:22 combinedTrainingAndTestData.txt

drwxrwxrwx+ 1 You  None     0 Jul 26 15:55 UCI HAR Dataset

data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset:


-rwxrwxrwx+ 1 You  None    80 Oct 10  2012 activity_labels.txt

-rwxrwxrwx+ 1 You  None 15785 Oct 11  2012 features.txt

drwxrwxrwx+ 1 You  None     0 Jul 13 16:05 test

drwxrwxrwx+ 1 You  None     0 Jul 21 13:25 train

data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test:

drwxrwxrwx+ 1 You  None        0 Jul 13 16:05 Inertial Signals

-rwxrwxrwx+ 1 You  None     7934 Nov 29  2012 subject_test.txt

-rwxrwxrwx+ 1 You  None 26458166 Nov 29  2012 X_test.txt

-rwxrwxrwx+ 1 You  None     5894 Nov 29  2012 y_test.txt



data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals:

-rwxrwxrwx+ 1 You  None 6041350 Nov 29  2012 body_acc_x_test.txt

-rwxrwxrwx+ 1 You  None 6041350 Nov 29  2012 body_acc_y_test.txt

-rwxrwxrwx+ 1 You  None 6041350 Nov 29  2012 body_acc_z_test.txt

-rwxrwxrwx+ 1 You  None 6041350 Nov 29  2012 body_gyro_x_test.txt

-rwxrwxrwx+ 1 You  None 6041350 Nov 29  2012 body_gyro_y_test.txt

-rwxrwxrwx+ 1 You  None 6041350 Nov 29  2012 body_gyro_z_test.txt

-rwxrwxrwx+ 1 You  None 6041350 Nov 29  2012 total_acc_x_test.txt

-rwxrwxrwx+ 1 You  None 6041350 Nov 29  2012 total_acc_y_test.txt

-rwxrwxrwx+ 1 You  None 6041350 Nov 29  2012 total_acc_z_test.txt



data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train:

drwxrwxrwx+ 1 You  None        0 Jul 13 16:05 Inertial Signals

-rwxrwxrwx+ 1 You  None    20152 Nov 29  2012 subject_train.txt

-rwxrwxrwx+ 1 You  None 66006256 Nov 29  2012 X_train.txt

-rwxrwxrwx+ 1 You  None    14704 Nov 29  2012 y_train.txt


data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals:

-rwxrwxrwx+ 1 You  None 15071600 Nov 29  2012 body_acc_x_train.txt

-rwxrwxrwx+ 1 You  None 15071600 Nov 29  2012 body_acc_y_train.txt

-rwxrwxrwx+ 1 You  None 15071600 Nov 29  2012 body_acc_z_train.txt

-rwxrwxrwx+ 1 You  None 15071600 Nov 29  2012 body_gyro_x_train.txt

-rwxrwxrwx+ 1 You  None 15071600 Nov 29  2012 body_gyro_y_train.txt

-rwxrwxrwx+ 1 You  None 15071600 Nov 29  2012 body_gyro_z_train.txt

-rwxrwxrwx+ 1 You  None 15071600 Nov 29  2012 total_acc_x_train.txt

-rwxrwxrwx+ 1 You  None 15071600 Nov 29  2012 total_acc_y_train.txt

-rwxrwxrwx+ 1 You  None 15071600 Nov 29  2012 total_acc_z_train.txt
