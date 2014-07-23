gettingAndCleaningData_courseProject
====================================

This repository constitutes part of the course project assignment for the course "Getting and Cleaning Data"

====================================

The files contained within this repo are as follows:

1. run_analysis.R  
    
    This is an R-script that when executed downloads the data and performs the associated analysis before returning 
    the tidy data set. For more details on the exact process see below and read the "CodeBook.md" file for details
    on the varaibles.
    

2. CodeBook.md

    This file contains a more detailed explenation of the data used in this project and the analysis performed on 
    the raw data set. It also contains a list of the variables used in the tidy table produced by the above script.
    
    
3. tidy_table.Rda

    An .Rda file containing the tidy table as required from part 5 of the assignment.
    
  
4. tidy_table.txt

   A plain text file with the same information as above.
 
==================================

Analysis:

  The "run_analysis.R" file in this repo contains the source code for an R scipt. This scipt contains a function
  called "project_function", that takes no arguments and returns a data.frame. The function's action can be 
  broken down into the following steps:
  
  1. Firstly it downloads the data contained at the web address above. This is to ensure that the function has the 
     same input regardless of what machine it is run on. A temporary directory called "temp_data" is created, if not 
     already in existence, that will contain the above zipped file and its unzipped file. The final part of this 
     preprocessing step is to download the part of the data that is necessary in this project. As we are only 
     required to extract measurements on the mean and std we need not look at the raw inertial signal files. All the
     necessary files, for both train and test, are extracted and we return the wd to its original.
     
  2. In this step we merge the data sets for the train and test files. We merge rows before columns so we end up
     with three data.frames, one for the subject id, one for the activities, and one for the measurements.
     
  3. We now clean the variable names. This is performed by a function defined within the source code that gives all
     the variables descriptive names. See the section in CodeBook.md detailed explenation of the variable names.
     We also give all the activities their descriptive names.
     
  4. The function then constructs a tidy data set that only takes the means and standard deviations of the original
     data set. If we read through the "features_info.txt" in the file at the url above. We see that the measurements
     that have been estimated as the mean and standard deviation of the raw inertial signals contain the string
     "mean()" or "std()" respectively. We therefore only consider features whose name contains this substring.
     
  5. Finally we average the data set created at the end of the last step for each choice of subject and identity. 
     This gives us a final tidy data set which the function then returns. This tidy data set is the one which is
     uploaded to the coursera site.
     
