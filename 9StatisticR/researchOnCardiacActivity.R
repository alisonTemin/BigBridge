install.packages("RJDBC",dep=TRUE)
setwd("C:/Users/khugu/Dropbox/PROJET_MBDS_BIGDATA/2PROJET_BIGDATA_IMREDD/ProjetBigdataImredd2017/9StatisticR")
library(RJDBC)

if(!exists("foo", mode="function")) 
  
  source("oracleConnection.R")

.jinit() 

oracleDriver <- JDBC("oracle.jdbc.OracleDriver", classPath="driver\\ojdbc7.jar", " ")
conn_oracle <- dbConnect(oracleDriver, "jdbc:oracle:thin:@192.168.1.22:1521:orcl", "system", "welcome1")

# selecting all the profiles from DB


profileData <- dbGetQuery(conn_oracle, "select userid, weight, height, age, smoking, drinking, fullname, gender from profile_hive_ext
                           ")

# calculating the BMI for risk group classification

profileData$BMI <- round((as.numeric(profileData$WEIGHT)/((as.numeric(profileData$HEIGHT))*(as.numeric(profileData$HEIGHT))))*10000, digits=1)




# select the profiles from DB which are allowed to high risk group according to the conception

highRiskProfiles  <- dbGetQuery(conn_oracle, "(select userid, bmi, age, smoking, drinking, fullname, gender
                                from (
                                select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                                where bmi>=18.5 and bmi<=24.9 and age>=60)
                                UNION
                                (select userid, bmi, age, smoking, drinking, fullname, gender
                                from (
                                select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                                where (smoking='Yes' or drinking='Yes') and age>=50)
                                UNION
                                (select userid, bmi, age, smoking, drinking, fullname, gender
                                from (
                                select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                                where bmi>25 and age>=50)
                                UNION
                                (select userid, bmi, age, smoking, drinking,fullname, gender
                                from (
                                select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                                where bmi>25 and (smoking='Yes' or drinking='Yes') and age>=45)
                                ")

mediumRiskProfiles<- dbGetQuery(conn_oracle, "select userid, bmi, age, smoking, drinking, fullname, gender from
(
  (select userid, bmi, age, smoking, drinking, fullname, gender
  from (
  select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) )
  MINUS (
  (select userid, bmi, age, smoking, drinking, fullname, gender
  from (
  select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
  where bmi>=18.5 and bmi<=24.9 and age>=60)
  UNION
  (select userid, bmi, age, smoking, drinking, fullname, gender
  from (
  select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
  where (smoking='Yes' or drinking='Yes') and age>=50)
  UNION
  (select userid, bmi, age, smoking, drinking, fullname, gender
  from (
  select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
  where bmi>25 and age>=50)
  UNION
  (select userid, bmi, age, smoking, drinking, fullname, gender
  from (
  select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
  where bmi>25 and (smoking='Yes' or drinking='Yes') and age>=45)
  
  )
  
  
)
                                where (age>=46 or bmi >=25) or ((smoking='Yes' or drinking='Yes') and age>=30)
                                
                                ")

lowRiskProfiles <- dbGetQuery(conn_oracle, "(select userid, bmi, age, smoking, drinking, fullname, gender
from (
                              select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext))
                              MINUS
                              (
                              select userid, bmi, age, smoking, drinking, fullname, gender from
                              (
                              (select userid, bmi, age, smoking, drinking, fullname, gender
                              from (
                              select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) )
                              MINUS (
                              (select userid, bmi, age, smoking, drinking, fullname, gender
                              from (
                              select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                              where bmi>=18.5 and bmi<=24.9 and age>=60)
                              UNION
                              (select userid, bmi, age, smoking, drinking, fullname, gender
                              from (
                              select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                              where (smoking='Yes' or drinking='Yes') and age>=50)
                              UNION
                              (select userid, bmi, age, smoking, drinking, fullname, gender
                              from (
                              select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                              where bmi>25 and age>=50)
                              UNION
                              (select userid, bmi, age, smoking, drinking, fullname, gender
                              from (
                              select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                              where bmi>25 and (smoking='Yes' or drinking='Yes') and age>=45)
                              
                              )
                              
                              
                              )
                              where (age>=46 or bmi >=25) or ((smoking='Yes' or drinking='Yes') and age>=30)
                              )
                              
                              MINUS
                              
                              (
                              (select userid, bmi, age, smoking, drinking, fullname, gender
                              from (
                              select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                              where bmi>=18.5 and bmi<=24.9 and age>=60)
                              UNION
                              (select userid, bmi, age, smoking, drinking, fullname, gender
                              from (
                              select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                              where (smoking='Yes' or drinking='Yes') and age>=50)
                              UNION
                              (select userid, bmi, age, smoking, drinking, fullname, gender
                              from (
                              select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                              where bmi>25 and age>=50)
                              UNION
                              (select userid, bmi, age, smoking, drinking, fullname, gender
                              from (
                              select ROUND(weight/(height*height)*10000,1) as bmi, age, userid, smoking, drinking, fullname, gender from profile_hive_ext) 
                              where bmi>25 and (smoking='Yes' or drinking='Yes') and age>=45)
                              )
                                            
                                            ")

highRiskProfiles$GROUPOFRISK <- 2
mediumRiskProfiles$GROUPOFRISK <- 1
lowRiskProfiles$GROUPOFRISK <- 0

rm(profileData)
profileData<-rbind(highRiskProfiles,mediumRiskProfiles,lowRiskProfiles)



install.packages("ggvis")


# Load in `ggvis`
library(ggvis)

# scatter plot
profileData222 <- profileData

profileData222$AGE <- as.numeric(profileData222$AGE)

profileData222 %>% ggvis(~BMI, ~AGE,  fill = ~GROUPOFRISK) %>% layer_points()

profileData222$GENDER <-  as.factor(profileData222$GENDER)
profileData222$GROUPOFRISK <-  as.factor(profileData222$GROUPOFRISK)
profileData222$SMOKING <-  as.factor(profileData222$SMOKING)
profileData222$DRINKING <-  as.factor(profileData222$DRINKING)

summary (profileData222)



realPollutionData <-dbGetQuery(conn_oracle, "select date_pol, quality, value from pollution_hive_ext")

cardiacData<-dbGetQuery(conn_oracle, "select userid, datetime, minutesfat, caloriesfat from fitbit_hive_ext
                        ")

newFrame <- merge(x = cardiacData, y = profileData, by = "USERID", all = TRUE)

library(dplyr)

cardiacDataForHighRiskProfiles <- filter(newFrame, GROUPOFRISK==2)

table(cardiacDataForHighRiskProfiles$DATETIME)


subcardiacDataForHighRiskProfiles <- filter(cardiacDataForHighRiskProfiles, MINUTESFAT>0)

# datetime set for profiles with high risk which had unnormal cardiac activity

dataSet <- data.frame(table(subcardiacDataForHighRiskProfiles$DATETIME))

names(dataSet)<-c("DATETIME","NUMBEROFPROFILES")
names(realPollutionData)<-c("DATETIME","AIRQUALITY")



newFrame2 <- merge(x = realPollutionData, y = dataSet, by = "DATETIME", all = TRUE)
newFrame2 %>% ggvis(~DATETIME, ~NUMBEROFPROFILES,  fill = ~AIRQUALITY) %>% layer_points()



install.packages("caret")
library(caret)

install.packages("ellipse")
library(ellipse)

install.packages("MASS")
library(MASS)

install.packages("e1071")
library(e1071)




dim(profileData222)

sapply(profileData222,class)

levels(profileData222$GROUPOFRISK)

# summarize the class distribution
percentage <- prop.table(table(profileData222$GROUPOFRISK)) * 100
cbind(freq=table(profileData222$GROUPOFRISK), percentage=percentage)


# split input and output
x <- profileData222[,2:3]
y <- profileData222[,8]

plot (y)
# boxplot for each attribute on one image


featurePlot(x=x, y=y, plot="ellipse")


profileDataForPrediction <- data.frame(profileData222$BMI, profileData222$AGE, profileData222$GROUPOFRISK)
names(profileDataForPrediction) <- c("BMI","AGE","GROUPOFRISK")
profileDataForPrediction$GROUPOFRISK <- as.factor(profileDataForPrediction$GROUPOFRISK)

# create a list of 80% of the rows in the original dataset we can use for training
validation_index <- createDataPartition(profileDataForPrediction$GROUPOFRISK, p=0.80, list=FALSE)
# select 20% of the data for validation
validation <- profileDataForPrediction[-validation_index,]
# use the remaining 80% of data to training and testing the models
profileDataForPrediction <- profileDataForPrediction[validation_index,]

summary(profileDataForPrediction)
# Run algorithms using 10-fold cross validation
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"

# a) linear algorithms
set.seed(7)
fit.lda <- train(GROUPOFRISK~., data=profileDataForPrediction, method="lda", metric=metric, trControl=control)
# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(GROUPOFRISK~., data=profileDataForPrediction, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(GROUPOFRISK~., data=profileDataForPrediction, method="knn", metric=metric, trControl=control)

results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn))
summary(results)


# compare accuracy of models
dotplot(results)

# summarize Best Model
print(fit.cart)

# estimate skill of CART on the validation dataset
library (rpart)
predictions <- predict(fit.cart, validation)
confusionMatrix(predictions, validation$GROUPOFRISK)