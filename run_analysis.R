#script ; run_analysis.R
# Folder "UCI HAR Dtaset",(which contains 3 files and 2 folders) is extracted ,
# and put into my current directory,and i added this folder to the path to get  
# a new working directory this way :
#
setwd(paste0(getwd(),"/UCI HAR Dataset"))
#
# read features and activity labels
#
features <-read.table("features.txt",stringsAsFactors=FALSE,header=FALSE)
actvlabl <- read.table("activity_labels.txt",stringsAsFactors=FALSE)
#
# read from "train" folder :  X_train.txt 
#
train.data <- read.table(paste0(getwd(),"/train/X_train.txt"),nrows=7352,colClass="numeric",header=FALSE)
#
#read from "test" folder : X_test.txt
#
test.data <- read.table(paste0(getwd(),"/test/X_test.txt"),nrows=2947,colClass="numeric",header=FALSE)
#
#combine train.data and test.data using rbind
#
cmbdata <- rbind(train.data,test.data)
#
# subset the combined data "cmbdata" to extract only the mean and stabdard 
# deviations variables using grepl():
#
names(cmbdata) <- features[,2]
bool1 <- grepl("mean()",names(cmbdata))
bool2 <- grepl("std()",names(cmbdata))
bool3 <- bool1|bool2
subcmbdata <- cmbdata[,bool3]
#
# Remove  "_" and "()" from all variables and replce with "." and ""
#
names(subcmbdata) <- gsub("-",".",names(subcmbdata))
names(subcmbdata) <- gsub("\\(\\)","",names(subcmbdata))
#
# Adding subject and activity columns :
#
subjecttr  <- read.table(paste0(getwd(),"/train/subject_train.txt"),nrows=7352,colClass="numeric",stringsAsFactors=FALSE,header=FALSE)
activitytr <- read.table(paste0(getwd(),"/train/y_train.txt"),nrows=7352,stringsAsFactors=FALSE,header=FALSE)
subjectts  <- read.table(paste0(getwd(),"/test/subject_test.txt"),nrows=2947,colClass="numeric",stringsAsFactors=FALSE,header=FALSE)
activityts  <- read.table(paste0(getwd(),"/test/y_test.txt"),nrows=2947,stringsAsFactors=FALSE,header=FALSE)
activity <-rbind(activitytr,activityts)
subject  <-rbind(subjecttr,subjectts) 
mydata   <- cbind(subject,activity,subcmbdata)
names(mydata) <-c("subject","activity",names(subcmbdata))
#
# Createa tidy data set with the average of each variable for each subject and 
# each activity ( mean of the means) by using aggregate()
#
mytidy1 <- aggregate(mydata,by=list(mydata$subject,mydata$activity),FUN=mean)
#
# Rename the numeric activity labels with names to reshape tidy data mytydi1
#
mytidy1$activity[mytidy1$activity==1] <- "walking"
mytidy1$activity[mytidy1$activity==2] <- "walkup"
mytidy1$activity[mytidy1$activity==3] <- "walkdown"
mytidy1$activity[mytidy1$activity==4] <- "sitting"
mytidy1$activity[mytidy1$activity==5] <- "standing"
mytidy1$activity[mytidy1$activity==6] <- "laying" 
# 
#table(data.frame(subject,activity))
# Removing "Groupe.1" and "Group.2" colunms produced by aggregate() to get
# an easy to read tidy data
#
mytidy1 <- mytidy1[,-1]
mytidy1 <- mytidy1[,-1]
#
# write mytidy1 to a file "mytidy1.txt
#
write.table(format(mytidy1,scientific=TRUE),file="mytidy1.txt",row.names=FALSE,quote=FALSE)
#
# go back to working directory where "UCI HAR Dataset" was extracted to be able 
# multiple script run
#
setwd("../")
#
# end