*  README.md 
*   Hi fellow coursera students :
*  My first step for the script run_analysis.R ,was extacting the folder UCI HAR Dataset, and put it into  my current directory.and:
* 1: setting a new directory that adds the new folder like this:
*        setwd(paste0(getwd(),/UCI HAR Dataset"))

* 2: read features and activity labels from my working directory
* 3: read X_train.txt file from "train" folder and put it in train.data variable
* 4: read X_test.txt  file from "test"  folder and put it in test.data  variable
* 5: combine train.data and test.data using rbind function and put it in cmbdata :
*       cmbdata <- rbind(train.data,test.data)

* 6:S ubset the combined table cmbdata to get mean and standerd deviation related 
    variables (table/columns).Here i used the grepl function this way:
*        names(cmbdata) <- features[,2]

*        bool1 <- grepl ("mean()",names(cmbdata))

*        bool2 <- grepl ("std()",names(cmbdata))

*        bool3 <- bool1|bool2

*        subcmbdata <- cmbdata[],bool3]

* 7: Removed "()" and "_" from all variables and replaced them with "" and "." by 
    using gsub
* 8: Added subject and activity labels to the combened cleaned data ,to do this 
*     * read the files subject_train.txt and Y_train.txt from "train" folder
*     * read the files subject_test.txt  and Y_test.txt from  "test" folder
*     * to make R run faster i added nrows and colClass stringsAsFactors arguments
*    * combined subjects from train and test
*     * combined activities from train and test
*    like this :
*     activity <- rbind ( activitytr,activityts )

*     subject  <- rbind (subjecttr,subjectts )

*     and finally add all these blocks to make a complete table with subject and   
*     activity columns and the features variables by using cbind() like this :
*     mydata <- cbind ("subject""actuvity",subcmbdata)

*     and i have to set the names for this table like this :
*     names (mydata) <- c("subject","activity",names(subcmbdata))
       
* 9: Create tidy data set with the average of each variable for each subject and 
*    each activity (mean of the means) by using the aggregate function like this:
*    mytidy1 <- aggregate(mydata,by=list(mydata$subject,mydata$activity),FUN=mean)

*      aggregate() adds two columns "Group.1" and "Group.2" for a readable table i 
     removed them.
* 10: I renamed the numeric activity labels with real names like this :
*     mytidy1$activity[mytidy1$actvity==1] <- "waliking"
  
*     ........same for other codes 2,3,4,5,6 
* 11: Finally i write the content of my tidy table (mytidy1) into a file called 
      mytidy1.txt without row names no quotes and number in a scientific format
* 12: Force R to go back to the first directory where "UCI HAR Dataset" was   
      extracted , and this to be able to make fresh R runs.
* 13: Thanks for your time and thanks coursera for the opportunity.    
 
      
  
     
    
     
     
    