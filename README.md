# Cleaning_Getting_Assignment_coursera
This repository is for the Cleaning and Getting Data Assignment of coursera R programming specialization.
**R Script uses dplyr and needs to be installed** 


### Working Directory

The following R code was designed to working inside a directory that has just another folder with the unzip files from the Assignments as they are and with no other modifications. 

- It should look like this:
* UCI HAR Dataset
  + test
    + Invertial Signals
    + subject_test.txt
    + X_test.txt
    + Y_test.txt
  + train
    + Invertial Signals
    + subject_test.txt
    + X_train.txt
    + Y_train.txt
  + activity_labels.txt
  + features.txt
  + features_info.txt


#### Step 1 *(Lines 2-30)*
* Data is read from the different directories of the folder **UCI HAR DATASET** 
  + Test datasets are processed
  + Train datasets are processed
  + Features dataset is processed and cleaned in order to avoid special characters such as **()**,  **-** and **,**. 
  + Activity dataset is processed and all words are set to lower case. 
  + Subjects datasets are processed
  
#### Step 2 
* In order to match the activity accordingly i use the merge function

#### Step 3 *(Lines 36-40)* **(Optional)** 
* Just in case someone would wanted to add a "Type" variable to distinguish between train and test datasets. You would need to add the *type_train* and the *type_test* variables in the **cbind** in lines 42 and 43. 

#### Step 4 
* Datasets are bind together depending if they are train or test datasets
* Later rbind is used since they have the same number of columns. 

#### Step 5 
* **grep** is used to get the index of which columns we should keep. Either if they are have the words mean or std. 
* Since we also have meanFreq and is not a mean variable per se I have decided to omit it. 
* **final_dataset** is created which is grouped by activity and subject and has the means of all the variables previously subsetted.
* A new txt file is created under the same name. 
