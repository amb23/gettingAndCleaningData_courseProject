
Data:

  The data considered in this project is derived from a smartphone with embedded inertial sensors whilst participants 
  were performing certain activity sets (see variables below). The data we have collected is derived from that 
  contained at "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones". Our data set 
  looks at a subset of the above and performs some basic analysis as well as tidying the table. 
  
  The location of the zip file from where we do our analysis is:
  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


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
     with three data.frames, one for the subject id, one for the measurements, and one for the measurements.
     
  3. We now clean the variable names. This is performed by a function defined within the source code that gives all
     the variables descriptive names. See the section below for a more detailed explenation of the variable names.
     We also give all the activities their descriptive names.
     
  4. The function then constructs a tidy data set that only takes the means and standard deviations of the original
     data set. If we read through the "features_info.txt" in the file at the url above. We see that the measurements
     that have been estimated as the mean and standard deviation of the raw inertial signals contain the string
     "mean()" or "std()" respectively. We therefore only consider features whose name contains this substring.
     
  5. Finally we average the data set created at the end of the last step for each choice of subject and identity. 
     This gives us a final tidy data set which the function then returns. This tidy data set is the one which is
     uploaded to the coursera site.
     
     
=====================================

Variables:

  There are two types of variables: I. those used for identifying the subject and the activity, II. those derived
  from the sensor's data. We give a uniform method of describing the second variable so we shall discuss these
  two types of variables seperately.
  
  Variable type I:
  
    "subjectId":
      This variable is an integer in the range [1,30] that determines the identification of the associated participant.

    "activity":
      This variable is an explicit description of the activity undertaken by the participant.
      
  Variable type II:
  
    A varible in this category is represented as the concatenation of four sub variables:  domain_variable2_stat_dir.
    These subvariables are defined as follows.
    
    "domain":
      This variable takes the values "time" or "freq" depending on whether tehe measurement corresponds to one taken
      in the time domain or one taken in the frequency domain respectively.
      
    "stat":
      This variable determines the statistic being measured. It is equal to "mean" or "std" corresponding to the 
      mean and the standard deviation repsectively.
      
    "dir":
      This variable measures the direction in which the measurement is taken. It can take one of four values "X",
      "Y", "Z" or "Mag". If it takes one of the values "X", "Y" or "Z" this just means the cartesian direction of 
      the measurement. If it takes the value "Mag" it means we consider the Euclidean norm of the vector spanned
      by the other 3 directions.
      
    "variable2":
      This variable can take on one of 5 values corresponding to the type of measurement being estimated. These are:
        
        "bodyAcceleration":
          Meausures the body acceleration of the participant. Derived from the accelerometer measurements.

        "gravitatyAcceleration":
          Measures the gravitational acceleration of the participent. Derived from the accelerometr measurements.

        "bodyAccelerationJerk":
          Measures the jerk applied to the body. Derived from the body acceleration, essentially its rate of change.

        "bodyAngularVelocity":
          Measures the angular velocity. Derived from the gyroscope measurements.

        "bodyAngularJerk":
          Measures the jerk of the angular velocity.
          
    ##Example: The variable that measures the standard deviation of the mganitude of the angular velocity of the body in
               the frequency domain is "freq_bodyAngularVelocity_std_Mag".
  
  
  
  
  
  
  
  
  
  
