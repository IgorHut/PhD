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

