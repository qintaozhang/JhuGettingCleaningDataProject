## Code Book

This code book describes the variables, the data, and any transformations or work performed to clean up the data.

### Overview

This is from UCI public data that 30 volunteers performed 6 different activities while wearing a smartphone. The smartphone captured various data about their movements.

### Files that explain relationship between all datasets:

* 'README.txt': the center point explains relationships among all files

* 'features_info.txt': Shows meaningful information about the variables used on the feature vector.

* 'features.txt': List of all features which are short names good for column names added to both train and test dataset

* 'activity_labels.txt': Links the class labels that saved in y_train and y_test with their activity name.

* 'train/X_train.txt': Training set that only saved data without labels

* 'train/y_train.txt': Training labels that need to be matched with activity_labels

* 'test/X_test.txt': Test set that only saved data without labels

* 'test/y_test.txt': Test labels that need to be matched with activity_labels



### Processing steps

1. Read all relevant data files using read.table into data frames
2. add column names using features.txt and combin data with labels, like X_train,y_train
3. concate train and test data with rbind
4. use grep to get columns whose name has mean() or std(). I decided to include meanFreq and so on which not just mean()
5. merge the dataset with activity_labels.txt, thus to convert integer labels to meaningful activities names
6. A tidy data set was created containing the mean of each feature for each subject and each activity using aggregate function
7. The tidy data set was output to a CSV file.
