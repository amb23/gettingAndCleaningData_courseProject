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
  
  1. Download and local save:
       The function opens a connection to the web address above. It then downloads and saves the file locally on the             computer in a file called "temp_data". The file is then unzipped and the parts necessary for the project, i.e not         the inertial signals, are read in as data.frames.
  
  2. Merge the two data sets:
       The file contains data sets for both training and testing. We merge the files of the same type. At the end of this        step we have three data.frames: one containing the subjects identification, one containing the activites, and one         for the actual measurements.

  3. Creates data set with just mean and std:
       The function now creates a data.frame which contains only the mean and standard deviation of the corresponding            measurements in the raw data file. If we read through the "features_info.txt" in the file at the url above. We see        that the measurements that have been estimated as the mean and standard deviation of the raw inertial signals             contain the string "mean()" or "std()" respectively. We therefore only consider features whose name contains this         substring.

  4. Clean activities and varaible names:
       In this step we perform two operations. The first is to replace the numerical representtions of an activity, an           integer in the range 1-6, with a descriptive name, e.g. WALKING, see the codebook for more details. We then make 
       the variable names descriptive, again see the codebook for details on the descriptive variable names.
  
  5. Average over subject and activity:
       Finally we average the data set created above for each choice of subject and identity. This gives us a final tidy         data set which the function then returns. This tidy data set is the one which is uploaded to the coursera site.
     
