
library(dplyr)

test_dir="./UCI HAR Dataset/test"
train_dir="./UCI HAR Dataset/train"
# add test dataframes
test_x=read.table(paste0(test_dir,"/","X_test.txt"))
test_act=read.table(paste0(test_dir,"/","y_test.txt"))

# add train dataframes
train_x=read.table(paste0(train_dir,"/","X_train.txt"))
train_act=read.table(paste0(train_dir,"/","y_train.txt"))

#add variable names
features=read.table(paste0("./UCI HAR Dataset","/features.txt"))
features$V2= tolower(features$V2)
features$V2=gsub("\\()","",features$V2)
features$V2=gsub("-","",features$V2)
features$V2=gsub(",","",features$V2)

activity=read.table(paste0("./UCI HAR Dataset","/activity_labels.txt"))
activity$V2= tolower(activity$V2)

#add subjects
test_sub=read.table(paste0(test_dir,"/subject_test.txt"))
train_sub=read.table(paste0(train_dir,"/subject_train.txt"))

names(test_sub)="subject"
names(train_sub)="subject"

activity_test=test_act %>% merge(activity)
names(activity_test)[2]="activity"
activity_train=train_act %>% merge(activity)
names(activity_train)[2]="activity"

#### code just in case you wanted to differenciate as a variable if values are from training or test
#type_test=data.frame(rep(c("test"),nrow(test_x)))
#names(type_test)="type"
#type_train=data.frame(rep(c("train"),nrow(train_x)))
#names(type_train)="type"

test_x=cbind(activity=activity_test$activity,subject=test_sub,test_x)
train_x=cbind(activity=activity_train$activity,subject=train_sub,train_x)

dataset=rbind(test_x,train_x)

#keep only columns for mean and std. Ignore meanFreq as it is not a proper mean calculation for the variables
names(dataset)[3:ncol(dataset)]=features$V2
mean=grep("*.mean.*",x = names(dataset))
freq_mean=grep("*.meanfreq.*",x = names(dataset))
mean=setdiff(mean,freq_mean)
std=grep("*std*",x = names(dataset))

dataset=dataset[,c(1:2,mean,std)]

final_dataset=dataset %>% group_by(activity,subject) %>% summarise_all(funs(mean))
write.csv(final_dataset,"final_dataset.txt")
#write.table(final_dataset,"final_dataset.txt")
