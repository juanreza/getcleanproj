# CodeBook for Assignment: Activity Sensor Measurements

This CodeBook describes the variables, data, and transformations  to clean the Activity Sensor Measurements data.
The associated README.md explains how the scripts work and how they are connected.

##The run_analysis.R program performs these operations:

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##Cleaning operations.

###1. Cleaning Variable names.

   Variable names are derived from feature names.
   
   UNITS are included in the column (abbreviated) feature name !!!!!!!
   
   For example, the column "tBa-X-Mean" tells you that the values are in units of ACCELERATION ( "a" ).
   See Table 1.
   
   The justification for this cleaning operation is that the data is hard to follow in a spreadsheet or print out
   with header names that are quite long. They are often so similar that it amounts to a lot of visual noise.

   The feature names were edited to conform to valid column name format, representing delimiters as single dash (hyphen)..
   These names were abbreviated by taking long words and substituting single letters.
     This mapping of words to letters is in Table 1 (below in this CodeBook).
   The names containing the words "mean" or "std" were rearranged with those words at the end (rightmost) position, yielding the final vairable name.

###2. Filtering in only the data representing means and standard deviation measurements.
   
   See Table 2 for a complete mapping of these abbreviated variable names to corresponding feature names.

###3. Precision of data

	The input data values appear to have at most 8 decimal digits. However, after generating averages the precision which is output by write.table is about 15 places.
	The final cleaning operation is to limit all output numeric values to 8 places.

###4. Cleaning Activity codes.
   
   Numeric Activity codes are substituted with corresponding names
   These come from the input file activity_labels.txt


###Table 1. Words (left) are converted to letter (right)

       "Body" -->	 "B"
       "Acc" -->	 "a"
       "Gravity" --> "G"
       "Jerk" -->	 "J"
       "Gyro" -->	 "g"
       "Mag" --> 	"M"
       "Freq" -->	 "F"
       "angle" --> "V"


###Table 2. Variable to Feature names
  
  The table shows the feature number, derived (cleaned) variable name, and the original unedited feature on each line.
	
1	tBa-X-Mean	tBodyAcc-mean()-X
2	tBa-Y-Mean	tBodyAcc-mean()-Y
3	tBa-Z-Mean	tBodyAcc-mean()-Z
4	tBa-X-Std	tBodyAcc-std()-X
5	tBa-Y-Std	tBodyAcc-std()-Y
6	tBa-Z-Std	tBodyAcc-std()-Z
41	tGa-X-Mean	tGravityAcc-mean()-X
42	tGa-Y-Mean	tGravityAcc-mean()-Y
43	tGa-Z-Mean	tGravityAcc-mean()-Z
44	tGa-X-Std	tGravityAcc-std()-X
45	tGa-Y-Std	tGravityAcc-std()-Y
46	tGa-Z-Std	tGravityAcc-std()-Z
81	tBaJ-X-Mean	tBodyAccJerk-mean()-X
82	tBaJ-Y-Mean	tBodyAccJerk-mean()-Y
83	tBaJ-Z-Mean	tBodyAccJerk-mean()-Z
84	tBaJ-X-Std	tBodyAccJerk-std()-X
85	tBaJ-Y-Std	tBodyAccJerk-std()-Y
86	tBaJ-Z-Std	tBodyAccJerk-std()-Z
121	tBg-X-Mean	tBodyGyro-mean()-X
122	tBg-Y-Mean	tBodyGyro-mean()-Y
123	tBg-Z-Mean	tBodyGyro-mean()-Z
124	tBg-X-Std	tBodyGyro-std()-X
125	tBg-Y-Std	tBodyGyro-std()-Y
126	tBg-Z-Std	tBodyGyro-std()-Z
161	tBgJ-X-Mean	tBodyGyroJerk-mean()-X
162	tBgJ-Y-Mean	tBodyGyroJerk-mean()-Y
163	tBgJ-Z-Mean	tBodyGyroJerk-mean()-Z
164	tBgJ-X-Std	tBodyGyroJerk-std()-X
165	tBgJ-Y-Std	tBodyGyroJerk-std()-Y
166	tBgJ-Z-Std	tBodyGyroJerk-std()-Z
201	tBaM-Mean	tBodyAccMag-mean()
202	tBaM-Std	tBodyAccMag-std()
214	tGaM-Mean	tGravityAccMag-mean()
215	tGaM-Std	tGravityAccMag-std()
227	tBaJM-Mean	tBodyAccJerkMag-mean()
228	tBaJM-Std	tBodyAccJerkMag-std()
240	tBgM-Mean	tBodyGyroMag-mean()
241	tBgM-Std	tBodyGyroMag-std()
253	tBgJM-Mean	tBodyGyroJerkMag-mean()
254	tBgJM-Std	tBodyGyroJerkMag-std()
266	fBa-X-Mean	fBodyAcc-mean()-X
267	fBa-Y-Mean	fBodyAcc-mean()-Y
268	fBa-Z-Mean	fBodyAcc-mean()-Z
269	fBa-X-Std	fBodyAcc-std()-X
270	fBa-Y-Std	fBodyAcc-std()-Y
271	fBa-Z-Std	fBodyAcc-std()-Z
294	fBa-F-X-Mean	fBodyAcc-meanFreq()-X
295	fBa-F-Y-Mean	fBodyAcc-meanFreq()-Y
296	fBa-F-Z-Mean	fBodyAcc-meanFreq()-Z
345	fBaJ-X-Mean	fBodyAccJerk-mean()-X
346	fBaJ-Y-Mean	fBodyAccJerk-mean()-Y
347	fBaJ-Z-Mean	fBodyAccJerk-mean()-Z
348	fBaJ-X-Std	fBodyAccJerk-std()-X
349	fBaJ-Y-Std	fBodyAccJerk-std()-Y
350	fBaJ-Z-Std	fBodyAccJerk-std()-Z
373	fBaJ-F-X-Mean	fBodyAccJerk-meanFreq()-X
374	fBaJ-F-Y-Mean	fBodyAccJerk-meanFreq()-Y
375	fBaJ-F-Z-Mean	fBodyAccJerk-meanFreq()-Z
424	fBg-X-Mean	fBodyGyro-mean()-X
425	fBg-Y-Mean	fBodyGyro-mean()-Y
426	fBg-Z-Mean	fBodyGyro-mean()-Z
427	fBg-X-Std	fBodyGyro-std()-X
428	fBg-Y-Std	fBodyGyro-std()-Y
429	fBg-Z-Std	fBodyGyro-std()-Z
452	fBg-F-X-Mean	fBodyGyro-meanFreq()-X
453	fBg-F-Y-Mean	fBodyGyro-meanFreq()-Y
454	fBg-F-Z-Mean	fBodyGyro-meanFreq()-Z
503	fBaM-Mean	fBodyAccMag-mean()
504	fBaM-Std	fBodyAccMag-std()
513	fBaM-FMean	fBodyAccMag-meanFreq()
516	fBBaJM-Mean	fBodyBodyAccJerkMag-mean()
517	fBBaJM-Std	fBodyBodyAccJerkMag-std()
526	fBBaJM-FMean	fBodyBodyAccJerkMag-meanFreq()
529	fBBgM-Mean	fBodyBodyGyroMag-mean()
530	fBBgM-Std	fBodyBodyGyroMag-std()
539	fBBgM-FMean	fBodyBodyGyroMag-meanFreq()
542	fBBgJM-Mean	fBodyBodyGyroJerkMag-mean()
543	fBBgJM-Std	fBodyBodyGyroJerkMag-std()
552	fBBgJM-FMean	fBodyBodyGyroJerkMag-meanFreq()
555	V-tBa-G-Mean	angle(tBodyAccMean,gravity)
556	V-tBaJ-G-Mean	angle(tBodyAccJerkMean),gravityMean)
557	V-tBg-G-Mean	angle(tBodyGyroMean,gravityMean)
558	V-tBgJ-G-Mean	angle(tBodyGyroJerkMean,gravityMean)
559	V-G-X-Mean	angle(X,gravityMean)
560	V-G-Y-Mean	angle(Y,gravityMean)
561	V-G-Z-Mean	angle(Z,gravityMean)
