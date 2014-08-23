## The Code Book

### This describes the variables and transformations that I performed to clean up the provided data and obtain TidyData2.txt



* Change the working directory to the directory containing the files activity_labels.txt, features.txt, etc
* Read all the text files into appropriate frames or list:

	1. activity_labels is a vector of 6 strings, which are the 6 activity names
	2. featurenames is a vector of 561 strings, which are all the features' names
	3. test_subjectnames is a frame of 2947 observations. This lists the names of the subjects in each observation (test case)
	4. test_activities is a frame of 2947 observations, listing the activities performed in each observation (test case)
	5. test_featurevalues is the values of all the features in the test case
	6. train_subjectnames is a frame of 7352 observations.This lists the names of the subjects in each observation (train case)
	7. train_activities is a frame of 2947 observations, listing the activities performed in each observation (train case)
	8. train_featurevalues is the values of all the features in the training case


* Change the levels of test_activities and train_activities to the actual activity names instead of numbers

* Make testframe and trainframe, frames of 2947 and 7352 observations, respectively, corresponding to the test cases and training cases. They both contain the following columns: SubjectNum (Number of Subject), Activity (activity performed), and all the features in featurenames.

* total frame is the combination of testframe and trainframe, using rbind.

* good_cols is a [TRUE/FALSE] vector of length 563 which identifies the 'good' columns: the first two columns, together with columns containing strings "std" or "mean"

* goodframe is the filtered result after selecting only the 'good' columns 

* After that I replaced the column names in goodframe to make them descriptive. For the purpose of this project, 'descriptive' names is taken to mean: no abbreviation, no whitespace or punctuation such as () or -. Due to the long names of the columns, capital letter is used for each word to improve readability. For example, 'timeBodyAccelerationJerkStandardDeviationZ' instead of 'timebodyaccelerationjerkstandarddeviationZ' (the second case is much harder to read).

* The data set is melted according to the combination of the SubjectNum and Activity. This produces the 'melted' frame

* It is then recast to show the mean of all variables (features) for each combination of SubjectNum and Activity. Since there are 30 subjects and 6 activities, the final 'casted' frame contains 30 x 6 = 180 rows.

* This final data set is tidy because:
	1. Each variable is in one column. There is a column for each of the variables that I selected (variables containing 'mean' or 'std'.)
	2. Each 'observation' is in a different row. Here, an 'observation' is just a combination of the SubjectNum and Activity.


* Finally the frame casted is written into a text file 'TidyData2.txt'