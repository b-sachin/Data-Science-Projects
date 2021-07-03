The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.
<h3> 1.	Download the dataset</h3>
<ul>
  <li>Dataset downloaded and extracted in the folder called <i>UCI HAR Dataset</i></li>
</ul>

<h3> 2.	Assign each data to variables</h3>
<ul>
  <li><i>train_subject <- UCI HAR Dataset/train/subject_train.txt :</i> 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed</li>
  <li><i>train <- UCI HAR Dataset/train/X_train.txt :</i> 7352 rows, 561 columns
contains recorded features train data</li>
  <li><i>train_activity <- UCI HAR Dataset/train/Y_train.txt :</i> 7352 rows, 1 columns
contains train data of activities’code labels</li>
  <li><i>test_subject <- UCI HAR Dataset/test/subject_test.txt :</i> 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed</li>
  <li><i>test <- UCI HAR Dataset/test/X_test.txt :</i> 2947 rows, 561 columns
contains recorded features test data</li>
  <li><i>test_activity <- UCI HAR Dataset/test/Y_test.txt :</i> 2947 rows, 1 columns
contains test data of activities’code labels</li>
  <li><i>features_raw <- UCI HAR Dataset/features.txt :</i> 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.</li>
  <li><i>activity_labels <- UCI HAR Dataset/activity_labels.txt :</i> 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)</li>
</ul>

<h3> 3.	Merges the training and the test sets to create one data set</h3>
<ul>
  <li><i>train</i> (7352 rows, 563 column) is created by merging <i>train_subject</i>, <i>train_activity</i> and <i>train</i> using <b>cbind()</b> function</li>
  <li>test (2947 rows, 563 column) is created by merging</li>
  <li><i>test_subject</i>, <i>test_activity</i> and <i>test</i> using <b>cbind() </b>function</li>
  <li><i>all_data</i> (10299 rows, 561 columns) is created by merging <i>train</i> and <i>test</i> using <b>rbind()</b> function</li>
</ul>

<h3> 4.	Extracts only the measurements on the mean and standard deviation for each measurement</h3>
<ul>
  <li><i>req_data</i> (10299 rows, 81 columns) is created by first, applying <b>grep()</b> on <i>feature_raw</i>, to collect measurements on the mean and standard deviation (<i>std</i>) for each measurement and then applying it to <i>all_data</i> to extract <i>req_data</i>.</li>
  <li>Added column names to all columns of the <i>req_data</i> as “<i>subject</i>”,”<i>activity</i>” and feature name respectively.</li>
</ul>


<h3> 5.	Uses descriptive activity names to name the activities in the data set</h3>
<ul>
  <li>Entire numbers in activity column of the <i>req_data</i> replaced with corresponding activity taken from second column of the <i>activity_labels</i> variable.</li>
</ul>

<h3> 6.	Appropriately labels the data set with descriptive variable names</h3>
<ul>
  <li><i>activity</i> column in <i>req_data</i> renamed into <i>activity_labels</i></li>
  <li>All <i>Acc</i> in column’s name replaced by <i>Accelerometer</i></li>
  <li>All <i>Gyro</i> in column’s name replaced by <i>Gyroscope</i></li>
  <li>All <i>Mag</i> in column’s name replaced by <i>Magnitude</i></li>
  <li>All start with character <i>f</i> in column’s name replaced by <i>FrequencyDomain</i></li>
  <li>All start with character <i>t</i> in column’s name replaced by <i>TimeDomain</i></li>
</ul>

<h3> 7.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject</h3>
<ul>
    <li><i>mean_data</i> (180 rows, 81 columns) is created by reshaping <i>req_data</i>. Firstly, melting <i>req_data</i> along with <i>subject</i> and <i>activity</i> as id variables and the <i>melt_data</i> is casted to take mean for each <i>subject</i> and <i>activity</i> group.</li>
    <li>Export <i>mean_data</i> into <i>tidy_data.txt</i> file.</li>
</ul>
