## Initical data wrangling for PhD ##
#####################################
library(readxl)
library(ggplot2)
library(dplyr)
library(tidyr)
date()

initData<-read_excel("IGOR HUT TTRPSouthend2015.xlsx")

initData # Posto je initData tbl ovo je sasvim ok

useData<-initData[-(1:3)] #Uklanjam prve tri kolone jer mi nece trebati za inicijalnu analizu

useData

# Let's make factors out of chr markings

useData$Case<-as.factor(useData$Case)

# Check the outcome

levels(useData$Case)

# Putting all the CANCER* factor levels iside one CANCER wraper 
 
levels(useData$Case)<-sub("CANCER.*", "CANCER", levels(useData$Case))

# Check the situation

levels(useData$Case)

summary(useData$Case)

# Zeroes are a huge problem in terms of calculating mean, sd etc. so let's get rid of them
# Keeping only the columns with abs(colSum)>=0.2

useData1<-select(useData,abs(colSums(useData[2:length(useData)]))>=0.2)

# Putting the first column back

useData1<-cbind(useData[1],useData1)

# Making a table again

useData1<-tbl_df(useData1)

useData1


