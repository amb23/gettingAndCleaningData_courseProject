project_function = function() {

#firstly we open a connection to the url of the data and then we load the corresponding file names


if( !file.exists("temp_data") ){
  dir.create("temp_data")
}
setwd(".\\temp_data")

url_ <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url_, destfile = "t_data.dat")

unzip("t_data.dat")

f_ <- list.files("UCI HAR Dataset",full.names = T)



#This binds the training and the test data for 1. the participant's id 2. the main data set 3. the activity

id_table <- rbind(read.table(list.files(f_[5],full.names=T)[2]),read.table(list.files(f_[6],full.names=T)[2])) 

raw_table <- rbind( read.table(list.files(f_[5],full.names=T)[3]) , read.table(list.files(f_[6],full.names=T)[3]))

activity_table <- rbind(read.table(list.files(f_[5],full.names=T)[4]) , read.table(list.files(f_[6],full.names =T)[4]))


#This is the full list of features contained within the data set

feature_list <- read.table(f_[2],stringsAsFactors = F)

#Now we have finished downloading we also return the directory to where we started

setwd("..\\")

#Checking the feature_info.txt we see that those that are the mean or std  will have features containig the terms "mean()" or "std()"

feature_list_req_loc <- grep("mean\\(|std\\(",feature_list[,2])


#we now replace the names in the raw feature list with descriptive variable names -- see the cookbook for more details

clean_variable=function(x){
  
  #this removes some mistakes in the original variables due to repeated use of body
  x<-gsub("BodyBody","Body",x)
  
  #this cleans up all the data sorts
  x<-gsub("\\-","_",x)
  x<-gsub("\\(\\)","\\",x)

  firstChar  = substr(x,1,1)
  if( firstChar == "t" ){
    x<- paste("time",substr(x,2,nchar(x)),sep="_")
  }
  else if(firstChar == "f"){
    x<- paste("freq",substr(x,2,nchar(x)),sep="_")
  }
  if(grepl("Mag",x)){
    x<-gsub("Mag","",x)
    x<-paste(x,"Mag",sep="_")
  }

  x<-gsub("BodyAcc","bodyAcceleration",x)
  x<-gsub("GravityAcc","gravityAcceleration",x)
  x<-gsub("BodyGyro", "bodyAngularVelocity",x)
  
  return(x)
}

feature_list_clean <- c()
for( t in 1:nrow(feature_list)){
  feature_list_clean = c( feature_list_clean , clean_variable(feature_list[t,2]))
}

feature_list_req_clean <- feature_list_clean[feature_list_req_loc]


descriptive_activities = function(x)
{
  if(x==1){return("WALKING")}
  else if(x==2){return("WALKING_UPSTAIRS")}
  else if(x==3){return("WALKING_DOWNSTAIRS")}
  else if(x==4){return("SITTING")}
  else if(x==5){return("STANDING")}
  else if(x==6){return("LAYING")}
}

activity_table_desc = c() 
for( t in 1:nrow(activity_table) ){
activity_table_desc <- c( activity_table_desc , descriptive_activities(activity_table[t,1]))
}


# we now construct the tidy data set according to the requirements.

tidy_table1_ <- raw_table[,feature_list_req_loc]
names(tidy_table1_) <- feature_list_req_clean

names(id_table) <- "subjectId"
names(activity_table_desc) <- "activity"

tidy_table1 <- cbind(id_table,activity_table_desc,tidy_table1_)



# finally we construct the second tidy data set. To do this we use the aggregate function as we are applying it universally over the columns

tidy_table2 <- aggregate(tidy_table1_,by=list(subjectId = tidy_table1$subjectId,activity = tidy_table1$activity), FUN=mean)

return(tidy_table2)
}