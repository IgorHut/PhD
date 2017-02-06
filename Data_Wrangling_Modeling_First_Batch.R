library(readxl)
library(ggplot2)
library(ggthemes)
library(dplyr)
library(tidyr)
library(matrixStats)
library(caret)
library(AppliedPredictiveModeling)
date()

setwd("~/GitHub/PhD")

initData<-read_excel("IGOR HUT TTRPSouthend2015.xlsx")

initData # Checking the tbl

useData<-initData[-(1:3)] # First three columns are not needed for initial analysis

useData[1:10] # Checking first columns of useData

# Let's make factors out of chr markings

useData$Case<-as.factor(useData$Case)

# Check the outcome

levels(useData$Case)

# Putting factor levels inside apropriate wrapers so I get 4 classes:"NEGATIVE", "LG", "HG", "CANCER"  

levels(useData$Case)<-sub("CANCER.*", "CANCER", levels(useData$Case))
levels(useData$Case)<-sub("BL*", "LG", levels(useData$Case))
levels(useData$Case)<-sub("MD*", "LG", levels(useData$Case))
levels(useData$Case)<-sub("SD*", "HG", levels(useData$Case))
levels(useData$Case)<-sub("CIN2&HG*", "HG", levels(useData$Case))
levels(useData$Case)<-sub("Negative", "NEGATIVE", levels(useData$Case))


# Check the situation

levels(useData$Case)

summary(useData$Case)

# # Zeroes are a huge problem in terms of calculating mean, sd etc. so let's get rid of them
# # Keeping only the columns with abs(colSum)>=2
# 
# useData1<-useData[,(colSums(abs(useData[2:length(useData)])))>=2]
# 
# # Putting the first column back
# 
# useData1<-cbind(useData[1],useData1)


# Removing vars with nearly zero variance
nzv <- nearZeroVar(useData)
useData <- useData[, -nzv]

# Making a table again
useData<-tbl_df(useData)




# Let's form the training and test sets, based on 75% and 25% of the total data (useData1), respectfuly
set.seed(333)

inTrain <- createDataPartition(y=useData$Case,p=0.75, list=FALSE)

training <- useData[inTrain,]
testing <- useData[-inTrain,]

# Running RF

modFit <- train(Case~ ., data=training, method="rf", prox=TRUE)

# Check the model

modFit 

testPred <- predict(modFit, testing)

confusionMatrix(testPred, testing$Case) 



