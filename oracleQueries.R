#checking mode and file
if(!exists("foo", mode="function")) 
  
#add source file with connection to Oracle SQL Database 12c  
source("oracleConnection.R")

#check JVM
.jinit() 

#SQL Queries
query <- dbGetQuery(conn_oracle, "select * from pollution_kv where rownum <= 15")
result <- head(query, 10)

#add the query result to data frame
myData <- data.frame(result)

#if you want to add just few rows from SQL table
query2 <- dbGetQuery(conn_oracle, "select station, pollutant from pollution_kv where rownum <= 10")
View(query2)
#you can add this variable query2 directly to dataframe, using
myData2 <- data.frame(query2)
View(myData2)


#I did not test, but may be you can work with data without dataframes, just using SQL Query
querryPollution <- dbGetQuery(conn_oracle, "select * from pollution")
querryDyspnea <- dbGetQuery(conn_oracle, "select * from dyspnee")
View(querryDyspnea)
View(querryPollution)
querryPollutionNO <- dbGetQuery(conn_oracle, "select * from pollution_kv where pollutant='NO'")
querryPollutionNO2 <- dbGetQuery(conn_oracle, "select * from pollution_kv where pollutant='NO2'")
querryPollutionNOX <- dbGetQuery(conn_oracle, "select * from pollution_kv where pollutant='NOX'")
View(querryPollutionNO)

patientsData <- dbGetQuery(conn_oracle, "select * from
(Select to_date(substr(admission, 0, 10),'MM/DD/YYYY') as day_,
                           count(*) as numberOfPatients, ((SELECT AVG(numberOfPatients) from
                           (select to_date(substr(admission, 0, 10),'MM/DD/YYYY') as day_, count(*) as numberOfPatients from dyspnee
                           group by to_date(substr(admission, 0, 10),'MM/DD/YYYY')))) as Average,
                           (((count(*) - ((SELECT AVG(numberOfPatients) from 
                           (select to_date(substr(admission, 0, 10),'MM/DD/YYYY') as day_, count(*) as numberOfPatients from dyspnee 
                           group by to_date(substr(admission, 0, 10),'MM/DD/YYYY')))))/((SELECT AVG(numberOfPatients) from
                           (select to_date(substr(admission, 0, 10),'MM/DD/YYYY') as day_, count(*) as numberOfPatients from dyspnee 
                           group by to_date(substr(admission, 0, 10),'MM/DD/YYYY')))))*100) As Difference
                           from dyspnee
                           
                           group by to_date(substr(admission, 0, 10),'MM/DD/YYYY')
                           order by to_date(substr(admission, 0, 10),'MM/DD/YYYY'))
                           
                           
                           where day_ is not null
                           
                           ")


environmentDataNO <- dbGetQuery(conn_oracle, "select to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') As day_,
                                avg(value_pol) as sr_znach,
                                (select avg(value_) from (
                                select  avg(value_pol) as value_,to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                from pollution
                                where POLLUTANT='NO'
                                group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                )) as Average,
                                
                                (((avg(value_pol) - (select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                from pollution
                                where POLLUTANT='NO'
                                group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                )))/(select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                from pollution
                                where POLLUTANT='NO'
                                group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                )))*100) as Percent_
                                
                                from pollution
                                where POLLUTANT='NO'
                                group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS')
                                ")

environmentDataNO2 <- dbGetQuery(conn_oracle, "select to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') As day_,
                                 avg(value_pol) as sr_znach,
                                 (select avg(value_) from (
                                 select  avg(value_pol) as value_,to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 from pollution
                                 where POLLUTANT='NO2'
                                 group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 )) as Average,
                                 
                                 (((avg(value_pol) - (select avg(value_) from (
                                 select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 from pollution
                                 where POLLUTANT='NO2'
                                 group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 )))/(select avg(value_) from (
                                 select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 from pollution
                                 where POLLUTANT='NO2'
                                 group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 )))*100) as Percent_
                                 
                                 from pollution
                                 where POLLUTANT='NO2'
                                 group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 ")

environmentDataNOX <- dbGetQuery(conn_oracle, "

                                 select to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') As day_,
                                 avg(value_pol) as sr_znach,
                                 (select avg(value_) from (
                                 select  avg(value_pol) as value_,to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 from pollution
                                 where POLLUTANT='NOX'
                                 group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 )) as Average,
                                 
                                 (((avg(value_pol) - (select avg(value_) from (
                                 select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 from pollution
                                 where POLLUTANT='NOX'
                                 group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 )))/(select avg(value_) from (
                                 select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 from pollution
                                 where POLLUTANT='NOX'
                                 group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 )))*100) as Percent_
                                 
                                 from pollution
                                 where POLLUTANT='NOX'
                                 group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                 order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS')
                                 ")

environmentDataO3 <- dbGetQuery(conn_oracle, "

select to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') As day_,
                                avg(value_pol) as sr_znach,
                                (select avg(value_) from (
                                select  avg(value_pol) as value_,to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                from pollution
                                where POLLUTANT='O3'
                                group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                )) as Average,
                                
                                (((avg(value_pol) - (select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                from pollution
                                where POLLUTANT='O3'
                                group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                )))/(select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                from pollution
                                where POLLUTANT='O3'
                                group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                )))*100) as Percent_
                                
                                from pollution
                                where POLLUTANT='O3'
                                group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                ")

environmentDataPM10 <- dbGetQuery(conn_oracle, "

                                  select to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') As day_,
                                  avg(value_pol) as sr_znach,
                                  (select avg(value_) from (
                                  select  avg(value_pol) as value_,to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  from pollution
                                  where POLLUTANT='PM10'
                                  group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  )) as Average,
                                  
                                  (((avg(value_pol) - (select avg(value_) from (
                                  select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  from pollution
                                  where POLLUTANT='PM10'
                                  group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  )))/(select avg(value_) from (
                                  select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  from pollution
                                  where POLLUTANT='PM10'
                                  group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  )))*100) as Percent_
                                  
                                  from pollution
                                  where POLLUTANT='PM10'
                                  group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  ")

environmentDataPM25 <- dbGetQuery(conn_oracle, " select to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') As day_,
                                  avg(value_pol) as sr_znach,
                                  (select avg(value_) from (
                                  select  avg(value_pol) as value_,to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  from pollution
                                  where POLLUTANT='PM2.5'
                                  group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  )) as Average,
                                  
                                  (((avg(value_pol) - (select avg(value_) from (
                                  select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  from pollution
                                  where POLLUTANT='PM2.5'
                                  group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  )))/(select avg(value_) from (
                                  select  avg(value_pol) as value_, to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  from pollution
                                  where POLLUTANT='PM2.5'
                                  group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  )))*100) as Percent_
                                  
                                  from pollution
                                  where POLLUTANT='PM2.5'
                                  group by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  order by to_date(date_poL,'MM/DD/YYYY HH24:MI:SS') 
                                  ")


newDate <- strftime("2014-03-22 00:00:00.0","%Y-%m-%d %H:%M:%S.0")
newDate2 <- strftime("2014-08-10 00:00:00.0","%Y-%m-%d %H:%M:%S.0")
newDate3 <- strftime("2014-09-25 00:00:00.0","%Y-%m-%d %H:%M:%S.0")

n <- c(newDate, newDate2, newDate3)
s <- c(0,0,0)
b <- c((-100),(-100),(-100))
newDataFrame <- data.frame(n,s,b)
names(newDataFrame)<-c("DAY_","NUMBEROFPATIENTS","DIFFERENCE")
patientsData <- subset( patientsData, select = -AVERAGE)

patientsData2<-rbind(patientsData,newDataFrame)

patientsData2<-patientsData2[order(patientsData2$DAY_),]
rownames(patientsData2) <- 1:nrow(patientsData2)


# correlation coefficient with NO
cor(environmentDataNO$PERCENT_, patientsData2$DIFFERENCE, method="pearson") 
# [1] 0.1804087
cor(environmentDataNO$PERCENT_, patientsData2$DIFFERENCE, method="spearman") 
# [1] 0.1773235

correlationResults <- data.frame(1,"NO","Patients",cor(environmentDataNO$PERCENT_, patientsData2$DIFFERENCE, method="pearson"))
names(correlationResults) <-c("CASE","DATASET1","DATASET2","COEFF")

cor(environmentDataNO2$PERCENT_, patientsData2$DIFFERENCE, method="pearson") 
# [1] 0.1012164
cor(environmentDataNO2$PERCENT_, patientsData2$DIFFERENCE, method="spearman") 
# [1] 0.09048158

correlationResultsTemp <- data.frame(1,"NO2","Patients",cor(environmentDataNO2$PERCENT_, patientsData2$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)


cor(environmentDataNOX$PERCENT_, patientsData2$DIFFERENCE, method="pearson") 
# [1] 0.1616413
cor(environmentDataNOX$PERCENT_, patientsData2$DIFFERENCE, method="spearman") 
# [1] 0.1489374

correlationResultsTemp <- data.frame(1,"NOX","Patients",cor(environmentDataNOX$PERCENT_, patientsData2$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(environmentDataO3$PERCENT_, patientsData2$DIFFERENCE, method="pearson") 
# [1] -0.2199504
cor(environmentDataO3$PERCENT_, patientsData2$DIFFERENCE, method="spearman") 
# [1] -0.2110049

correlationResultsTemp <- data.frame(1,"O3","Patients",cor(environmentDataO3$PERCENT_, patientsData2$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(environmentDataPM10$PERCENT_, patientsData2$DIFFERENCE, method="pearson")
# [1] 0.05497636
cor(environmentDataPM10$PERCENT_, patientsData2$DIFFERENCE, method="spearman") 
# [1] 0.0440984

correlationResultsTemp <- data.frame(1,"PM10","Patients",cor(environmentDataPM10$PERCENT_, patientsData2$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(environmentDataPM25$PERCENT_, patientsData2$DIFFERENCE, method="pearson")
# [1] 0.0786113
cor(environmentDataPM25$PERCENT_, patientsData2$DIFFERENCE, method="spearman")
# [1] 0.08181723

correlationResultsTemp <- data.frame(1,"PM2,5","Patients",cor(environmentDataPM25$PERCENT_, patientsData2$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)


m1 <- lm(environmentDataNO$PERCENT_~patientsData2$DIFFERENCE)

summary(m1)

# group data by diagnosis heart - I , lung - J

heartPatiensData <- dbGetQuery(conn_oracle, "Select count (*) as numberOfPatients, day_ from
                               (Select diag1, to_date(substr(admission, 0, 10),'MM/DD/YYYY') as day_ from dyspnee where substr(diag1,0,1)='I')
                               group by day_ order by day_")


newFrame <- merge(x= patientsData2, y= heartPatiensData, by= 'DAY_', all.x= T)

newFrame <- newFrame[,c(1,4)]
names(newFrame) <-c("DAY_","NUMBEROFPATIENTS")

# replace NA by 0
newFrame[is.na(newFrame)] <- 0

#the average number of patients
mean_value_heart <- mean(newFrame$NUMBEROFPATIENTS)

#THe difference column
newFrame$DIFFERENCE <- ((newFrame$NUMBEROFPATIENTS - mean_value_heart)/mean_value_heart)*100

heartPatiensData <- newFrame

# COEFFICIENTS FOR HEART PATIENTS
cor(environmentDataNO$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson")
# [1] 0.1060834
cor(environmentDataNO$PERCENT_, heartPatiensData$DIFFERENCE, method="spearman")
# [1] 0.1032935

correlationResultsTemp <- data.frame(2,"NO","Patients_Heart",cor(environmentDataNO$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)


cor(environmentDataNO2$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson")
# [1] 0.03138159
cor(environmentDataNO2$PERCENT_, heartPatiensData$DIFFERENCE, method="spearman")
# [1] 0.03393236

correlationResultsTemp <- data.frame(2,"NO2","Patients_Heart",cor(environmentDataNO2$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(environmentDataNOX$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson")
# [1] 0.08371402
cor(environmentDataNOX$PERCENT_, heartPatiensData$DIFFERENCE, method="spearman")
# [1] 0.07850038

correlationResultsTemp <- data.frame(2,"NOX","Patients_Heart",cor(environmentDataNOX$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(environmentDataO3$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson")
# [1] -0.1386231
cor(environmentDataO3$PERCENT_, heartPatiensData$DIFFERENCE, method="spearman")
# [1] -0.1357204

correlationResultsTemp <- data.frame(2,"O3","Patients_Heart",cor(environmentDataO3$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)


cor(environmentDataPM10$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson")
# [1] -0.005957092
cor(environmentDataPM10$PERCENT_, heartPatiensData$DIFFERENCE, method="spearman")
# [1] 0.003326509

correlationResultsTemp <- data.frame(2,"PM10","Patients_Heart",cor(environmentDataPM10$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)


cor(environmentDataPM25$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson")
#[1] 0.002553244
cor(environmentDataPM25$PERCENT_, heartPatiensData$DIFFERENCE, method="spearman")
#[1] -0.005303402

correlationResultsTemp <- data.frame(2,"PM2,5","Patients_Heart",cor(environmentDataPM25$PERCENT_, heartPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)




lungPatiensData <- dbGetQuery(conn_oracle, "Select count (*) as numberOfPatients, day_ from
                              + (Select diag1, to_date(substr(admission, 0, 10),'MM/DD/YYYY') as day_ from dyspnee where substr(diag1,0,1)='J')
                              +                                group by day_ order by day_")

tempFrame <- merge(x= patientsData2, y= lungPatiensData, by= 'DAY_', all.x= T)
tempFrame <- tempFrame[,c(1,4)]
tempFrame[is.na(tempFrame)] <- 0
names(tempFrame) <-c("DAY_","NUMBEROFPATIENTS")
mean_value_lung <- mean(tempFrame$NUMBEROFPATIENTS)
tempFrame$DIFFERENCE <- ((tempFrame$NUMBEROFPATIENTS - mean_value_lung)/mean_value_lung)*100
lungPatiensData <- tempFrame
rm(tempFrame)


# COEFFICIENTS FOR LUNG PATIENTS
cor(environmentDataNO$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson")
# [1] 0.1719213
cor(environmentDataNO$PERCENT_, lungPatiensData$DIFFERENCE, method="spearman")
# [1] 0.1702768

correlationResultsTemp <- data.frame(2,"NO","Patients_Lung",cor(environmentDataNO$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)


cor(environmentDataNO2$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson")
# [1] 0.08888615
cor(environmentDataNO2$PERCENT_, lungPatiensData$DIFFERENCE, method="spearman")
# [1] 0.08138525

correlationResultsTemp <- data.frame(2,"NO2","Patients_Lung",cor(environmentDataNO2$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(environmentDataNOX$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson")
# [1] 0.1535681
cor(environmentDataNOX$PERCENT_, lungPatiensData$DIFFERENCE, method="spearman")
# [1] 0.1495301

correlationResultsTemp <- data.frame(2,"NOX","Patients_Lung",cor(environmentDataNOX$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)


cor(environmentDataO3$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson")
# [1] -0.2045952
cor(environmentDataO3$PERCENT_, lungPatiensData$DIFFERENCE, method="spearman")
# [1] -0.2018235

correlationResultsTemp <- data.frame(2,"O3","Patients_Lung",cor(environmentDataO3$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(environmentDataPM10$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson")
# [1] 0.06846391
cor(environmentDataPM10$PERCENT_, lungPatiensData$DIFFERENCE, method="spearman")
#  [1] 0.06674187

correlationResultsTemp <- data.frame(2,"PM10","Patients_Lung",cor(environmentDataPM10$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(environmentDataPM25$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson")
#[1] 0.0973422
cor(environmentDataPM25$PERCENT_, lungPatiensData$DIFFERENCE, method="spearman")
#[1] 0.1180241

correlationResultsTemp <- data.frame(2,"PM2,5","Patients_Lung",cor(environmentDataPM25$PERCENT_, lungPatiensData$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

# GROUP PATIENTS BY 5 DAY
testPatientsData2 <- patientsData2
testPatientsData2$fifth_day_index <- c(0, rep(1:(nrow(testPatientsData2)-1)%/%5))
fiveDaysPatients <- group_by(testPatientsData2, fifth_day_index) %>% summarise(sum_patients = sum(NUMBEROFPATIENTS))
rm(testPatientsData2)

names(fiveDaysPatients)<-c("PERIOD","TOTALNUMBEROFPATIENTS")
fiveDaysPatients$Z=as.numeric(fiveDaysPatients$`TOTALNUMBEROFPATIENTS`)
mean_value_grouping_patients <- mean(as.numeric(fiveDaysPatients$Z),na.rm=T)

fiveDaysPatients$DIFFERENCE<- ((as.numeric(fiveDaysPatients$`TOTALNUMBEROFPATIENTS`) - mean_value_grouping_patients)/mean_value_grouping_patients)*100

fiveDaysPatients <- fiveDaysPatients[,c(1,2,4)]

# GROUP POLLUTANTS BY 5 DAYS

testEnvironmentDataNO <- environmentDataNO
testEnvironmentDataNO$fifth_day_index <- c(0, rep(1:(nrow(testEnvironmentDataNO)-1)%/%5))
fiveDaysNO <- group_by(testEnvironmentDataNO, fifth_day_index) %>% summarise(av_value = mean(SR_ZNACH))
rm(testEnvironmentDataNO)

testEnvironmentDataNO2 <- environmentDataNO2
testEnvironmentDataNO2$fifth_day_index <- c(0, rep(1:(nrow(testEnvironmentDataNO2)-1)%/%5))
fiveDaysNO2 <- group_by(testEnvironmentDataNO2, fifth_day_index) %>% summarise(av_value = mean(SR_ZNACH))
rm(testEnvironmentDataNO2)

testEnvironmentDataNOX <- environmentDataNOX
testEnvironmentDataNOX$fifth_day_index <- c(0, rep(1:(nrow(testEnvironmentDataNOX)-1)%/%5))
fiveDaysNOX <- group_by(testEnvironmentDataNOX, fifth_day_index) %>% summarise(av_value = mean(SR_ZNACH))
rm(testEnvironmentDataNOX)

testEnvironmentDataO3 <- environmentDataO3
testEnvironmentDataO3$fifth_day_index <- c(0, rep(1:(nrow(testEnvironmentDataO3)-1)%/%5))
fiveDaysO3 <- group_by(testEnvironmentDataO3, fifth_day_index) %>% summarise(av_value = mean(SR_ZNACH))
rm(testEnvironmentDataO3)

testEnvironmentDataPM10 <- environmentDataPM10
testEnvironmentDataPM10$fifth_day_index <- c(0, rep(1:(nrow(testEnvironmentDataPM10)-1)%/%5))
fiveDaysPM10 <- group_by(testEnvironmentDataPM10, fifth_day_index) %>% summarise(av_value = mean(SR_ZNACH))
rm(testEnvironmentDataPM10)

testEnvironmentDataPM25 <- environmentDataPM25
testEnvironmentDataPM25$fifth_day_index <- c(0, rep(1:(nrow(testEnvironmentDataPM25)-1)%/%5))
fiveDaysPM25 <- group_by(testEnvironmentDataPM25, fifth_day_index) %>% summarise(av_value = mean(SR_ZNACH))
rm(testEnvironmentDataPM25)


mean_fiveDaysNO <- mean(fiveDaysNO$av_value)
fiveDaysNO$PERCENT_ <- ((fiveDaysNO$av_value - mean_fiveDaysNO)/mean_fiveDaysNO)*100

mean_fiveDaysNO2 <- mean(fiveDaysNO2$av_value)
fiveDaysNO2$PERCENT_ <- ((fiveDaysNO2$av_value - mean_fiveDaysNO2)/mean_fiveDaysNO2)*100

mean_fiveDaysNOX <- mean(fiveDaysNOX$av_value)
fiveDaysNOX$PERCENT_ <- ((fiveDaysNOX$av_value - mean_fiveDaysNOX)/mean_fiveDaysNOX)*100

mean_fiveDaysO3 <- mean(fiveDaysO3$av_value)
fiveDaysO3$PERCENT_ <- ((fiveDaysO3$av_value - mean_fiveDaysO3)/mean_fiveDaysO3)*100

mean_fiveDaysPM10 <- mean(fiveDaysPM10$av_value)
fiveDaysPM10$PERCENT_ <- ((fiveDaysPM10$av_value - mean_fiveDaysPM10)/mean_fiveDaysPM10)*100

mean_fiveDaysPM25 <- mean(fiveDaysPM25$av_value)
fiveDaysPM25$PERCENT_ <- ((fiveDaysPM25$av_value - mean_fiveDaysPM25)/mean_fiveDaysPM25)*100

# NOW WE CAN SEARCH THE CORRELATION WITH PERIODS
cor(fiveDaysNO$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson")
# [1] 0.36395
cor(fiveDaysNO$PERCENT_, fiveDaysPatients$DIFFERENCE, method="spearman")
# [1] 0.3842203

correlationResultsTemp <- data.frame(3,"NO","Patients",cor(fiveDaysNO$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(fiveDaysNO2$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson")
# [1] 0.2697953
cor(fiveDaysNO2$PERCENT_, fiveDaysPatients$DIFFERENCE, method="spearman")
# [1] 0.2058233

correlationResultsTemp <- data.frame(3,"NO2","Patients",cor(fiveDaysNO2$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(fiveDaysNOX$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson")
# [1] 0.3613143
cor(fiveDaysNOX$PERCENT_, fiveDaysPatients$DIFFERENCE, method="spearman")
# [1] 0.3467781

correlationResultsTemp <- data.frame(3,"NOX","Patients",cor(fiveDaysNOX$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)


cor(fiveDaysO3$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson")
# [1] -0.371573
cor(fiveDaysO3$PERCENT_, fiveDaysPatients$DIFFERENCE, method="spearman")
# [1] -0.3616781

correlationResultsTemp <- data.frame(3,"O3","Patients",cor(fiveDaysO3$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(fiveDaysPM10$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson")
# [1] 0.1243245
cor(fiveDaysPM10$PERCENT_, fiveDaysPatients$DIFFERENCE, method="spearman")
# [1] 0.1167465

correlationResultsTemp <- data.frame(3,"PM10","Patients",cor(fiveDaysPM10$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)

cor(fiveDaysPM25$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson")
#[1] 0.1249298
cor(fiveDaysPM25$PERCENT_, fiveDaysPatients$DIFFERENCE, method="spearman")
#[1] 0.1415242

correlationResultsTemp <- data.frame(3,"PM2,5","Patients",cor(fiveDaysPM25$PERCENT_, fiveDaysPatients$DIFFERENCE, method="pearson"))
names(correlationResultsTemp) <-c("CASE","DATASET1","DATASET2","COEFF")                                 
correlationResults <- rbind(correlationResults,correlationResultsTemp)



#LINEAR REGRESSION MODEL

lm(formula = fiveDaysNO$av_value ~ fiveDaysPatients$DIFFERENCE)

# PREDICTION VALUE OF POLLUTION TO YEAR OF 2017

pred <- seq(as.Date("2017/1/1"), as.Date("2017/12/31"), by = "day")
daysDatarame <- data.frame(pred)
daysDatarame$pred <- strftime(daysDatarame$pred,"%Y-%m-%d %H:%M:%S.0")
names(daysDatarame) <- c("DAY_")



model <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataNO)
daysDatarame$predValueNO = predict(model,daysDatarame)

model <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataNO2)
daysDatarame$ppredValueNO2 = predict(model,daysDatarame)

model <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataNOX)
daysDatarame$ppredValueNOX = predict(model,daysDatarame)

model <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataO3)
daysDatarame$ppredValueO3 = predict(model,daysDatarame)

model <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataPM10)
daysDatarame$ppredValuePM10 = predict(model,daysDatarame)

model <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataPM25)
daysDatarame$ppredValuePM25 = predict(model,daysDatarame)


# PREDICTION NUMBER OF PATIENTS TO YEAR OF 2017

pred <- seq(as.Date("2017/1/1"), as.Date("2017/12/31"), by = "day")
daysDatarame <- data.frame(pred)
daysDatarame$pred <- strftime(daysDatarame$pred,"%Y-%m-%d %H:%M:%S.0")
names(daysDatarame) <- c("DAY_")


model <- lm(NUMBEROFPATIENTS ~ as.Date(DAY_), data=patientsData2)
predictionPatients <- data.frame(c(daysDatarame$DAY_))
names(predictionPatients) <- c("DAY_")
predictionPatients$predNumber = predict(model,predictionPatients)


# PLOTS

plot(as.Date(environmentDataNO$DAY_), environmentDataNO$PERCENT_, col="green", xlab = "Day", ylab = "")
lines(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="sky blue")
legend("topleft", bg="transparent", legend=c("NO", "Number of Patients"), col=c("green", "sky blue"), lty=1:2, cex=0.8)

plot(as.Date(environmentDataNO2$DAY_), environmentDataNO2$PERCENT_, col="coral1", xlab = "Day", ylab = "")
lines(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="sky blue")
legend("topleft", bg="transparent", legend=c("NO2", "Number of Patients"), col=c("coral1", "sky blue"), lty=1:2, cex=0.8)

plot(as.Date(environmentDataNOX$DAY_), environmentDataNOX$PERCENT_, col="darkorchid", xlab = "Day", ylab = "")
lines(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="sky blue")
legend("topleft", bg="transparent", legend=c("NOX", "Number of Patients"), col=c("darkorchid", "sky blue"), lty=1:2, cex=0.8)

plot(as.Date(environmentDataO3$DAY_), environmentDataO3$PERCENT_, col="gold", xlab = "Day", ylab = "")
lines(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="sky blue")
legend("topleft", bg="transparent", legend=c("O3", "Number of Patients"), col=c("gold", "sky blue"), lty=1:2, cex=0.8)

plot(as.Date(environmentDataPM10$DAY_), environmentDataPM10$PERCENT_, col="chocolate1", xlab = "Day", ylab = "")
lines(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="sky blue")
legend("topleft", bg="transparent", legend=c("PM10", "Number of Patients"), col=c("chocolate1", "sky blue"), lty=1:2, cex=0.8)

plot(as.Date(environmentDataPM25$DAY_), environmentDataPM25$PERCENT_, col="deeppink", xlab = "Day", ylab = "")
lines(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="sky blue")
legend("topleft", bg="transparent", legend=c("PM2,5", "Number of Patients"), col=c("deeppink", "sky blue"), lty=1:2, cex=0.8)


# MAKING TABLE WITH RESUlTS IN SQL

for (i in 1:nrow(correlationResults)) {
  row <- correlationResults[i,]
  dbSendUpdate(conn_oracle, "INSERT INTO rresults VALUES(?,?,?,?)", row[,1], row[,2],row[,3],row[,4])
}


plot(fiveDaysNO$fifth_day_index, fiveDaysNO$PERCENT_, col="green", xlab = "Day", ylab = "")
lines(fiveDaysPatients$PERIOD,fiveDaysPatients$DIFFERENCE,col="sky blue")
legend("topleft", bg="transparent", legend=c("NO", "Number of Patients"), col=c("green", "sky blue"), lty=1:2, cex=0.8)

plot(fiveDaysNO2$fifth_day_index, fiveDaysNO2$PERCENT_, col="coral1", xlab = "Day", ylab = "")
lines(fiveDaysPatients$PERIOD,fiveDaysPatients$DIFFERENCE,col="sky blue")
legend("topleft", bg="transparent", legend=c("NO2", "Number of Patients"), col=c("coral1", "sky blue"), lty=1:2, cex=0.8)

plot(fiveDaysNOX$fifth_day_index, fiveDaysNOX$PERCENT_, col="darkorchid", xlab = "Day", ylab = "")
lines(fiveDaysPatients$PERIOD,fiveDaysPatients$DIFFERENCE,col="sky blue")
legend("topleft", bg="transparent", legend=c("NOX", "Number of Patients"), col=c("darkorchid", "sky blue"), lty=1:2, cex=0.8)

# MAKING TABLE WITH CHARTS IN SQL

for (i in 1:nrow(fiveDaysNO)) {
  row <- fiveDaysNO[i,]
  dbSendUpdate(conn_oracle, "INSERT INTO rchart_pol VALUES(?,?)", 'NO', row[,3])
}

for (i in 1:nrow(fiveDaysNO2)) {
  row <- fiveDaysNO2[i,]
  dbSendUpdate(conn_oracle, "INSERT INTO rchart_pol VALUES(?,?)", 'NO2', row[,3])
}

for (i in 1:nrow(fiveDaysNOX)) {
  row <- fiveDaysNOX[i,]
  dbSendUpdate(conn_oracle, "INSERT INTO rchart_pol VALUES(?,?)", 'NOX', row[,3])
}

for (i in 1:nrow(fiveDaysPatients)) {
  row <- fiveDaysPatients[i,]
  dbSendUpdate(conn_oracle, "INSERT INTO rchart_patients VALUES(?,?)", row[,1], row[,3])
}

# 1 step : merge



x1 <- patientsData
x2 <- environmentDataNO
y <- patientsDataNo

plot(as.Date(environmentDataNO$DAY_), environmentDataNO$PERCENT_, col="coral1", xlab = "Day", ylab = "")
points(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="blue")
abline(modelNO)

plot(as.Date(environmentDataNO2$DAY_), environmentDataNO2$PERCENT_, col="coral1", xlab = "Day", ylab = "")
points(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="blue")
abline(modelNO2)

plot(as.Date(environmentDataNOX$DAY_), environmentDataNOX$PERCENT_, col="coral1", xlab = "Day", ylab = "")
points(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="blue")
abline(modelNOX)

plot(as.Date(environmentDataO3$DAY_), environmentDataO3$PERCENT_, col="gold", xlab = "Day", ylab = "")
points(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="blue")
abline(modelO3)

plot(as.Date(environmentDataPM10$DAY_), environmentDataPM10$PERCENT_, col="chocolate1", xlab = "Day", ylab = "")
points(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="blue")
abline(modelePM10)

plot(as.Date(environmentDataPM25$DAY_), environmentDataPM25$PERCENT_, col="coral1", xlab = "Day", ylab = "")
points(as.Date(patientsData2$DAY_),patientsData2$DIFFERENCE,col="blue")
abline(modelePM25)

myline.fit <- lm(environmentDataNO$PERCENT ~ as.Date(environmentDataNO$DAY_))
summary(myline.fit)
abline(myline.fit)

modelNO <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataNO)

modelNO2 <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataNO2)

modelNOX <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataNOX)

modelO3 <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataO3)

modelePM10 <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataPM10)

modelePM25 <- lm(SR_ZNACH ~ as.Date(DAY_), data=environmentDataPM25)

a <- environmentDataNO$PERCENT_
b <- environmentDataNO2$PERCENT_
c <- environmentDataNOX$PERCENT_
d <- environmentDataO3$PERCENT_
e <- environmentDataPM10$PERCENT_
r <- patientsDataNo$DIFFERENCE
h <- hist(r, plot=F)
plot(h$counts, log="xy", pch=20, col="blue",
     main="patients distribution",
     xlab="Value", ylab="Frequency") 
boxplot(r, xlab = "frequency", ylab = "day", main = "patients Data")

plot(h$counts, log="xy", pch=20, col="blue",
     main="patients distribution",
     xlab="Value", ylab="Frequency")
boxplot(r, xlab = "frequency", ylab = "day", main = "patients Data")

boxplot(a, xlab = "frequency", ylab = "day", main = "NO")
boxplot(b, xlab = "frequency", ylab = "day", main = "NO2")
boxplot(c, xlab = "frequency", ylab = "day", main = "NOX")
boxplot(d, xlab = "frequency", ylab = "day", main = "O3")
boxplot(e, xlab = "frequency", ylab = "day", main = "PM10")

boxplot(r, a, b, c, d, e, names=c("patients Data","NO","NO2", "NOX", "O3","PM10"))

hist(r,a, names=c("NO","NX"),breaks=20)
hist(a, main = "NO")


install.packages("RGtk2")
install.packages("rattle")
library(RGtk2)
library(rattle)
rattle()


install.packages("sp")
install.packages("rgdal")

# Installation des packages accessoires
install.packages("RColorBrewer")
install.packages("classInt")

# Installation des packages de rendu
install.packages("ggplot2")
install.packages("ggmap")
install.packages("maptools")

library("sp")
library("rgdal")

library("RColorBrewer")
library("classInt")

library("ggplot2")
library("ggmap")
library("maptools")


pathToShp <- "./GEOFLA/GEOFLA/GEOFLA/1_DONNEES_LIVRAISON_2016-06-00236/shp/COMMUNE"
ogrInfo(dsn = pathToShp,layer="COMMUNE")
# Import via la fonction readOGR de rgdal
comm <- readOGR(dsn = pathToShp, layer="COMMUNE", stringsAsFactors=FALSE)
# Description de la structure globale
str(comm, 2)
# Description de la structure des donn?es associ?es 
str(comm@data, 2)
# Description de la structure des donn?es vectorielles 
head(comm@polygons, n=1)
# On repr?sente les contours des communes de France avec la fonction plot
plot(comm)
# On plot la commune de Nice (CODE_COMM ?gal ? 88)
plot(comm[comm$ID_GEOFLA=="COMMUNE00000000000011063",],)

pollutantNO <- environmentDataNO
pollutantNO2 <- environmentDataNO2
pollutantNOX <- environmentDataNOX
pollutantO3 <- environmentDataO3
pollutantPM10 <- environmentDataPM10
pollutantPM25 <- environnmentDataPM25

comm@data <- data.frame(comm@data, querryPollution[match(comm@data[, "INSEE_COM"],querryPollution[, "STATION"]), ])
head(comm@data)
str(querryPollution)

##Trouver une variable commune

data(franceMapEnv)

install.packages("rMaps")

install.packages("ggmap")
install.packages("dplyr")
install.packages("tmap")

framePatientsDataNO <- data.frame(patientsDataNo)
fit <- rpart(NUMBEROFPATIENTS ~  DIFFERENCE + SR_ZNACH + DAY_ + PERCENT_,
             data=framePatientsDataNO,
             method="class")
querryDyspneaNo <- merge(x= querryDyspnea, y= environmentDataNO, by.x = "ADMISSION", by.y = "DAY_", all.x= T)
View(querryDyspneaNo)

summary(querryDyspneaNo)
summary(patientsDataNo)
built_tree<-C5.0(SR_ZNACH~.,data=patientsDataNo)

patientsNO.rpart1 = rpart(NUMBEROFPATIENTS ~  DIFFERENCE + SR_ZNACH + DAY_ + PERCENT_, 
                     data = patientsDataNo)
plotcp(patientsNO.rpart1)
printcp(patientsNO.rpart1)
patientsNO.rpart2 = prune(patientsNO.rpart1, cp = 0.02)
plot(patientsNO.rpart2, uniform = TRUE)
text(patientsNO.rpart2, use.n = TRUE, cex = 0.75)

########################################################

#Decision tree 

patientsDataNo <- merge(x= patientsData2,y= environmentDataNO, by= 'DAY_', all.x= T)
patientsDataNo2 <- merge(x=patientsData2, y= environmentDataNO2, by= 'DAY_', all.x = T)
patientsDataNox <- merge(x = patientsData2, y=environmentDataNOX, by= 'DAY_', all.x= T)
patientsDataO3 <- merge(x= patientsData2, y=environmentDataO3, by= 'DAY_', all.x = T)
patientsDataPM10 <- merge(x=patientsData2, y=environmentDataPM10, by ='DAY_', all.x = T)
patientsDataPM25 <- merge(x=patientsData2, y=environmentDataPM25, by = 'DAY_', all.x = T)





id <- c(1:1096)
patientsDataNo$ID<-id
patientsDataNo2$ID <- id
patientsDataNox$ID <- id
patientsDataO3$ID <- id
patientsDataPM10$ID <- id
patientsDataPM25$ID <- id


patientsDataNo <- patientsDataNo[sample(1:nrow(patientsDataNo),nrow(patientsDataNo)),]
View(patientsDataNo)

patientsDataNo_EA <- patientsDataNo[1:548,]
patientsDataNo_ET <- patientsDataNo[549:1096,]
id_patientsDataNo_EA <- patientsDataNo_EA$ID
patientsDataNo_EA <- subset(patientsDataNo_EA, select = -ID)
View(patientsDataNo_EA)
View(patientsDataNo_ET)
summary(patientsDataNo_EA)
summary(patientsDataNo_ET)
summary(patientsDataNo)
library(rpart)
library(rpart.plot)
tree.rp1 <- rpart(patientsDataNo~.,patientsDataNo_EA)
tree.rp1


#################################
#Mapping
pathToShp <- "./GEOFLA/GEOFLA/GEOFLA/1_DONNEES_LIVRAISON_2016-06-00236/shp/COMMUNE"
ogrInfo(dsn = pathToShp,layer="COMMUNE")
comm <- readOGR(dsn = pathToShp, layer="COMMUNE", stringsAsFactors=FALSE)
plot(comm[comm$ID_GEOFLA=="COMMUNE00000000000011063",],)
plot(coordonnees$x, coordonnees$y, col = "red", cex = .6)

View(querryPollution)

summary(querryPollution)


idpol <- c(1:23016)
querryPollution$ID<-idpol

latitudeContes <- 48.8119
longitudeConte <- 7.31389
latitudeAeroport <- 43.6597
longitudeAeroport <- 7.2148
latitudeProm <- 43.6814
longitudeProm <- 7.2322
latitudeArson <- 43.7218931
longitudeArson <- 7.2529446
latitudePeillon <- 43.777924
longitudePeillon <- 7.382182
latitudeNiceOuest <- 43.6848962
longitudeNiceOuest <- 7.2095236

latitude <- c(latitudeContes,latitudeAeroport,latitudeProm,latitudeArson,latitudePeillon,latitudeNiceOuest)
longitude <- c(longitudeConte,longitudeAeroport,longitudeProm,longitudeArson,longitudePeillon,longitudeNiceOuest)
names <- c('Contes','Aeroport', 'Promenade', 'Arson', 'Peillon', 'Nice Ouest')

querryPollution$LATITUDE <- latitude
querryPollution$LONGITUDE <- longitude



library(maps)
library(mapdata)

map('worldHires')
locator(4)

#map('worldHires', xlim=c(43.762579,43.769026,43.633754,43.636767), ylim=c(7.149935,7.326403,7.161265,7.348505))
map('worldHires', xlim=range(7.144785,7.333441), ylim=range(43.758798,43.659156))
points(7.31389, 48.8119, pch=16)
text(7.31389, 48.8119, label ="Contes 2")
points(7.2322, 43.6814, pch=16)
text(7.2322, 43.6814, label ="promenade")
points(7.2148, 43.6597, pch=16)
text(7.2148, 43.6597, label ="aeroport")
points(7.2529446, 43.7218931, pch=16)
text(7.2529446, 43.7218931, label ="Arson")
points(7.382182, 43.777924, pch=16)
text(7.382182, 43.777924, label ="Peillon")
points(7.2095236, 43.6848962, pch=16)
text(7.2095236, 43.6848962, label ="Nice Ouest")




MakeMap <- function(latitude, longitude, e, scaleby, size = 100, add=FALSE, col='blue', pch=20, color, data, ...){
  if(!missing(data)) {
    data <- substitute(data)
    longitude <- substitute(longitude)
    latitude <- substitute(latitude)
    long_text <- paste0(data, "$", longitude)
    lat_text <- paste0(data, "$", latitude)
    longitude <- eval(parse(text=long_text))
    latitude <- eval(parse(text=lat_text))
    xy1 <- cbind(longitude, latitude)
    if(!missing(scaleby)) {
      scaleby <- substitute(scaleby)
      scaleby_text <- paste0(data, "$", scaleby)
      scaleby <- eval(parse(text=scaleby_text))
    }
    if(!missing(col)) {
      col <- substitute(col)
      if(class(col)!="character") {
        col <- substitute(col)
        col_text <- paste0(data, "$", col)
        col <- as.factor(as.character(eval(parse(text=col_text))))
      } else {
        col <- substitute(col)
      }
    }
  } else {
    xy1 <- cbind(longitude, latitude) 
  }
  projected <- mercator(xy1)
  if(!missing(color)) {
    stop("Remember to use the argument 'col' and not 'color'.")
  }
  if(missing(e)) {
    if(nrow(projected) == 1) {
      latrange <- extendrange(latitude, r = c(latitude - 0.1, latitude + 0.1),
                              f=0.3)
      lonrange <- extendrange(longitude, r = c(longitude - 0.1, longitude + 0.1),
                              f=0.5)
      x <- extent(lonrange[1], lonrange[2], latrange[1], latrange[2])
    } else {
      latrange <- extendrange(latitude, f=0.04)
      lonrange <- extendrange(longitude, f=0.04)
      x <- extent(lonrange[1], lonrange[2], latrange[1], latrange[2])
      f1 <- (latrange[2] - latrange[1])/(lonrange[2] - lonrange[1])
      if (f1 < 1/4) {
        latrange <- extendrange(latitude, f = 1.5 - f1)
        x <- extent(lonrange[1], lonrange[2], latrange[1], latrange[2])      
      }
      if (f1 > 5/4) {
        lonrange <- extendrange(longitude, f = f1 - 1)
        x <- extent(lonrange[1], lonrange[2], latrange[1], latrange[2])      
      }
    }
  }  
  else {
    x <- e
    subset1 <- which(projected[,2]<ymax(x) & projected[,2]>ymin(x) & projected[,1]<xmax(x) & projected[,1]>xmin(x))
    projected <- projected[subset1,]
    if (!missing(scaleby)){
      scaleby <- scaleby[subset1]
    }
  }
  r = gmap(x, scale=2)
  par.old <- par(no.readonly = TRUE)$mar
  if (add==FALSE) {
    plot(r, interpolate=TRUE) 
  }
  if (!missing(scaleby)){
    radius <- sqrt(scaleby /pi)
    bubble.size <- 0.35 * size / 100
    if (is.factor(col)) {
      symbols(projected[order(-radius), ], circles=radius[order(-radius)], inches=bubble.size, add=TRUE, bg=col[order(-radius)], fg='white',...)
    } else {
      symbols(projected[order(-radius), ], circles=radius[order(-radius)], inches=bubble.size, add=TRUE, bg=col, fg='white',...)
    }
  } else {
    point.size <- size / 100
    points(projected, col=col, pch = pch, cex = point.size)
    par(mar=par.old);   
  }
}

MakeMap(querryPollution$LATITUDE, querryPollution$LONGITUDE)
e = drawExtent()
f = drawExtent()
MakeMap(newQuerryPolNo$latitude2, newQuerryPolNo$longitude2)
MakeMap(newQuerryPolNo$latitude2, newQuerryPolNo$longitude2,f, scaleby = newQuerryPolNo$AVG)


library(maps)
library(mapdata)
library(geosphere)
library(mapproj)
library(raster)
library(ggmap)
library(RgoogleMaps)
library(sp)
library(rasterVis)
library(maptools)
library(rgeos)
library(dismo)
library(sqldf)


querryNo <- subset(querryPollution, querryPollution$POLLUTANT=='NO')
querryNo
querryNoContes <- subset(querryNo, querryNo$STATION=='Contes 2')
querryNoContes <- querryNoContes[,-7]
querryNoContes$LATITUDE <- latitudeContes
querryNoContes$LONGITUDE <- longitudeConte
querryNoContes$AVGNOCONTES <- mean(querryNoContes$VALUE_POL)
View(querryNo)
querryNo$AVGNO <- mean(querryNo$VALUE_POL)

querryNoAeroport <- subset(querryNo, querryNo$STATION=='Aeroport de Nice')
querryNoAeroport <- querryNoAeroport[,-7]
querryNoAeroport$LATITUDE <- latitudeAeroport
querryNoAeroport$LONGITUDE <- longitudeAeroport
querryNoAeroport$AVGNOAERO <- mean(querryNoAeroport$VALUE_POL)

querryNoProm <- subset(querryNo, querryNo$STATION=='Nice Promenade des Anglais')
querryNoProm <- querryNoProm[,-7]
View(querryNoProm)
querryNoProm$LATITUDE <- latitudeProm
querryNoProm$LONGITUDE <- longitudeProm
querryNoProm$AVGNOPROM <- mean(querryNoProm$VALUE_POL)

querryNoArson <- subset(querryNo, querryNo$STATION=='Nice Arson')
querryNoArson <- querryNoArson[,-7]
querryNoArson$LATITUDE <- latitudeArson
querryNoArson$LONGITUDE <- longitudeArson
querryNoArson$AVGNOARSON <- mean(querryNoArson$VALUE_POL)

Name <- c('contes', 'Promenade','Aeroport','Arson')
longitude2<- c(longitudeConte,longitudeProm,longitudeAeroport,longitudeArson)
latitude2<- c(latitudeContes,latitudeProm, latitudeAeroport, latitudeArson)
AVG <- c(9.839122,27.92336,5.877737,13.50821)
newQuerryPolNo <- data.frame(Name,latitude2,longitude2,AVG)


querryNO2 <- subset(querryPollution, querryPollution$POLLUTANT=='NO2')
querryNo2Aeroport <- subset(querryNO2, querryNO2$STATION=='Aeroport de Nice')
querryNo2Aeroport$LATITUDE <- latitudeAeroport
querryNo2Aeroport$LONGITUDE <- longitudeAeroport
querryNo2Aeroport$AVGNO2AERO <- mean(querryNo2Aeroport$VALUE_POL)

querryNo2Prom <- subset(querryNO2,querryNO2$STATION=='Nice Promenade des Anglais')
querryNo2Prom$LATITUDE <- latitudeProm
querryNo2Prom$LONGITUDE <- longitudeProm
querryNo2Prom$AVGNO2PROM <- mean(querryNo2Prom$VALUE_POL)

querryNo2Arson <- subset(querryNO2,querryNO2$STATION=='Nice Arson')
querryNo2Arson$LATITUDE <- latitudeArson
querryNo2Arson$LONGITUDE <- longitudeArson
querryNo2Arson$AVGNO2ARSON <- mean(querryNo2Arson$VALUE_POL)

Name2 <- c('Aeroport','Promenade','Arson')
longitude3 <- c(longitudeAeroport,longitudeProm,longitudeArson)
latitude3 <- c(latitudeAeroport,latitudeProm,latitudeArson)
AVG2 <- c(20.0073,46.2719,35.26369)
newQuerryPolNO2 <- data.frame(Name2,latitude3,longitude3,AVG2)

MakeMap(newQuerryPolNo$latitude2, newQuerryPolNo$longitude2,f, scaleby = newQuerryPolNo$AVG)
MakeMap(newQuerryPolNO2$latitude3, newQuerryPolNO2$longitude3, f, scaleby = newQuerryPolNO2$AVG2,col="red",add = TRUE)
MakeMap(newquerryPolNox$latitude4, newquerryPolNox$longitude4, f, scaleby = newquerryPolNox$AVG3,col="green",add = TRUE)
MakeMap(newQuerryPolO3$latitude5, newQuerryPolO3$longitude5, f, scaleby = newQuerryPolO3$AVG4,col="coral",add = TRUE)
MakeMap(newQuerryPolPM10$latitude6, newQuerryPolPM10$longitude6, f, scaleby = newQuerryPolPM10$AVG5,col="cyan",add = TRUE)
MakeMap(newQuerryPolPM25$latitude7, newQuerryPolPM25$longitude7, f, scaleby = newQuerryPolPM25$AvG6,col="gold",add = TRUE)
MakeMap(newQuerryPatients$latitude8, newQuerryPatients$longitude8, f, scaleby = newQuerryPatients$NbPatient,col="orchid",add = TRUE)

querryNox <- subset(querryPollution, querryPollution$POLLUTANT=='NOX')
querryNOXContes <- subset(querryNox, querryNox$STATION=='Contes 2')
querryNOXContes$LATITUDE <- latitudeContes
querryNOXContes$LONGITUDE <- longitudeConte
querryNOXContes$AVGNOXCONTES <- mean(querryNOXContes$VALUE_POL)

querryNOXAeroport <- subset(querryNox, querryNox$STATION=='Aeroport de Nice')
querryNOXAeroport$LATITUDE <- latitudeAeroport
querryNOXAeroport$LONGITUDE <- longitudeAeroport
querryNOXAeroport$AVGNOXAEROPORT <- mean(querryNOXAeroport$VALUE_POL)

querryNOXPromenade <- subset(querryNox, querryNox$STATION=='Nice Promenade des Anglais')
querryNOXPromenade$LATITUDE <- latitudeProm
querryNOXPromenade$LONGITUDE <- longitudeProm
querryNOXPromenade$AVGNOXPROM <- mean(querryNox$VALUE_POL)

querryNOXArson <- subset(querryNox, querryNox$STATION=='Nice Arson')
querryNOXArson$LATITUDE <- latitudeArson
querryNOXArson$LONGITUDE <- longitudeArson
querryNOXArson$AVGNOXARSON <- mean(querryNOXArson$VALUE_POL)

Names3 <- c('Contes','Aeroport','Promenade','Arson')
longitude4 <- c(longitudeConte,longitudeAeroport,longitudeProm,longitudeArson)
latitude4 <- c(latitudeContes,latitudeAeroport,latitudeProm,latitudeArson)
AVG3 <- c(34.28285,29.45438,52.16583,55.94434)
newquerryPolNox <- data.frame(Names3,longitude4,latitude4,AVG3)

querryO3 <- subset(querryPollution, querryPollution$POLLUTANT=='O3')
querryO3Aeroport <- subset(querryO3, querryO3$STATION=='Aeroport de Nice')
querryO3Aeroport$LATITUDE <- latitudeAeroport
querryO3Aeroport$LONGITUDE <- longitudeAeroport
querryO3Aeroport$AVGO3Aero <- mean(querryO3Aeroport$VALUE_POL)

querryO3Arson <- subset(querryO3, querryO3$STATION=='Nice Arson')
querryO3Arson$LATITUDE <- latitudeArson
querryO3Arson$LONGITUDE <- longitudeArson
querryO3Arson$AVGO3Arson <- mean(querryO3Arson$VALUE_POL)

querryO3NiceOuest <- subset(querryO3, querryO3$STATION=='Nice Ouest Botanique')
querryO3NiceOuest$LATITUDE <- latitudeNiceOuest
querryO3NiceOuest$LONGITUDE <- longitudeNiceOuest
querryO3NiceOuest$AVGNiceOuest <- mean(querryO3$VALUE_POL)

Name4 <- c('Aeroport','Arson','Nice Ouest')
longitude5 <- c(longitudeAeroport,longitudeArson,longitudeNiceOuest)
latitude5 <- c(latitudeAeroport,latitudeArson,latitudeNiceOuest)
AVG4 <- c(51.02372,42.83668,52.71928)
newQuerryPolO3 <- data.frame(Name4,latitude5,longitude5,AVG4)

querryPM10 <- subset(querryPollution, querryPollution$POLLUTANT=='PM10')
querryPM10Contes <- subset(querryPM10, querryPM10$STATION=='Contes 2')
querryPM10Contes$LATITUDE <- latitudeContes
querryPM10Contes$LONGITUDE <- longitudeConte
querryPM10Contes$AVGPM10Contes <- mean(querryPM10Contes$VALUE_POL)

querryPM10Aeroport <- subset(querryPM10, querryPM10$STATION=='Aeroport de Nice')
querryPM10Aeroport$LATITUDE <- latitudeAeroport
querryPM10Aeroport$LONGITUDE <- longitudeAeroport
querryPM10Aeroport$AVGPM10Aero <- mean(querryPM10Aeroport$VALUE_POL)

querryPM10Prom <- subset(querryPM10, querryPM10$STATION=='Nice Promenade des Anglais')
querryPM10Prom$LATITUDE <- latitudeProm
querryPM10Prom$LONGITUDE <- longitudeProm
querryPM10Prom$AVGPMProm <- mean(querryPM10Prom$VALUE_POL)

querryPM10Arson <- subset(querryPM10, querryPM10$STATION=='Nice Arson')
querryPM10Arson$LATITUDE <- latitudeArson
querryPM10Arson$LONGITUDE <- longitudeArson
querryPM10Arson$AVGPM10Arson <- mean(querryPM10Arson$VALUE_POL)

querryPM10Peillon <- subset(querryPM10, querryPM10$STATION=='Peillon')
querryPM10Peillon$LATITUDE <- latitudePeillon
querryPM10Peillon$LONGITUDE <- longitudePeillon
querryPM10Peillon$AVGPM10Peillon <- mean(querryPM10Peillon$VALUE_POL)

Name5 <- c('Contes', 'Aeroport', 'Promenade', 'Arson', 'Peillon')
longitude6 <- c(longitudeConte, longitudeAeroport, longitudeProm, longitudeArson, longitudePeillon)
latitude6 <- c(latitudeContes, latitudeAeroport, latitudeProm, latitudeArson, latitudePeillon)
AVG5 <- c(22.72536, 19.95803, 28.76186, 24.87409, 23.15146)

newQuerryPolPM10 <- data.frame(Name5,latitude6,longitude6,AVG5)

querryPM25 <- subset(querryPollution, querryPollution$POLLUTANT=='PM2.5')
querryPM25Prom <- subset(querryPM25, querryPM25$STATION =='Nice Promenade des Anglais')
querryPM25Prom$LATITUDE <- latitudeProm
querryPM25Prom$LONGITUDE <- longitudeProm
querryPM25Prom$AVGPM25Prom <- mean(querryPM25Prom$VALUE_POL)

querryPM25Arson <- subset(querryPM25, querryPM25$STATION=='Nice Arson')
querryPM25Arson$LATITUDE <- latitudeArson
querryPM25Arson$LONGITUDE <- longitudeArson
querryPM25Arson$AVGPM25Arson <- mean(querryPM25Arson$VALUE_POL)

Name6 <- c('Promenade', 'Arson')
longitude7 <- c(longitudeProm, longitudeArson)
latitude7 <- c(latitudeProm, latitudeArson)
AvG6 <- c(14.04288,24.87409)

newQuerryPolPM25 <- data.frame(Name6, latitude7, longitude7, AvG6)


querryDyspneaAeroport <- subset(querryDyspnea, querryDyspnea$STATION=='Aeroport de Nice')
querryDyspneaAeroport$LATITUDE <- latitudeAeroport
querryDyspneaAeroport$LONGITUDE <- longitudeAeroport
querryDyspneaAeroport$NBPatients <- nrow(querryDyspneaAeroport)

querryDyspneaContes <- subset(querryDyspnea, querryDyspnea$STATION=='Contes 2')
querryDyspneaContes$LATITUDE <- latitudeContes
querryDyspneaContes$LONGITUDE <- longitudeConte
querryDyspneaContes$NBPatients <- nrow(querryDyspneaContes)

querryDyspneaArson <- subset(querryDyspnea, querryDyspnea$STATION=='Nice Arson')
querryDyspneaArson$LATITUDE <- latitudeArson
querryDyspneaArson$LONGITUDE <- longitudeArson
querryDyspneaArson$NBPatients <- nrow(querryDyspneaArson)

querryDyspneaNiceOuest <- subset(querryDyspnea, querryDyspnea$STATION=='Nice Ouest Botanique')
querryDyspneaNiceOuest$LATITUDE <- latitudeNiceOuest
querryDyspneaNiceOuest$LONGITUDE <- longitudeNiceOuest
querryDyspneaNiceOuest$NBPatients <- nrow(querryDyspneaNiceOuest)

querryDyspneaProm <- subset(querryDyspnea, querryDyspnea$STATION=='Nice Promenade des Anglais')
querryDyspneaProm$LATITUDE <- latitudeProm
querryDyspneaProm$LONGITUDE <- longitudeProm
querryDyspneaProm$NbPatients <- nrow(querryDyspneaProm)

querryDyspneaPeillon <- subset(querryDyspnea, querryDyspnea$STATION=='Peillon')
querryDyspneaPeillon$LATITUDE <- latitudePeillon
querryDyspneaPeillon$LONGITUDE <- longitudePeillon
querryDyspneaPeillon$NBPatients <- nrow(querryDyspneaPeillon)

Name7 <- c('Aeroport', 'Contes', 'Arson', 'Nice Ouest', 'Promenade', 'Peillon')
longitude8 <- c(longitudeAeroport, longitudeConte, longitudeArson, longitudeNiceOuest, longitudeProm,longitudePeillon)
latitude8 <- c(latitudeAeroport, latitudeContes, latitudeArson, latitudeNiceOuest, latitudeProm, latitudePeillon)
NbPatient <- c(55, 293, 918, 2013, 922, 227)

newQuerryPatients <- data.frame(Name7, latitude8, longitude8, NbPatient)



idContes <- c(1:1096)
querryNoContes$ID<-idContes
dateNoContes1 <- subset(querryNoContes, querryNoContes$ID < 363)
dateNoContes2 <- subset(querryNoContes, querryNoContes$ID < 728)
dateNoContes3 <- subset(querryNoContes, querryNoContes$ID > 727)
dateNoContes1$AVGNOCONTES <- mean(dateNoContes1$VALUE_POL)
dateNoContes2$AVGNOCONTES <- mean(dateNoContes2$VALUE_POL)
dateNoContes3$AVGNOCONTES <- mean(dateNoContes3$VALUE_POL)

idAeroport <- c(1:1096)
querryNoAeroport$ID <- idAeroport
dateNoAero1 <- subset(querryNoAeroport, querryNoAeroport$ID < 366)
dateNoAero2 <- subset(querryNoAeroport, querryNoAeroport$ID < 731)
dateNoAero3 <- subset(querryNoAeroport, querryNoAeroport$ID > 730)
dateNoAero1$AVGNOAERO <- mean(dateNoAero1$VALUE_POL)
dateNoAero2$AVGNOAERO <- mean(dateNoAero2$VALUE_POL)
dateNoAero3$AVGNOAERO <- mean(dateNoAero3$VALUE_POL)

idProm <- c(1:1096)
querryNoProm$ID <- idProm
dateNoProm1 <- subset(querryNoProm, querryNoProm$ID < 366)
dateNoProm2 <- subset(querryNoProm, querryNoProm$ID < 731)
dateNoProm3 <- subset(querryNoProm, querryNoProm$ID > 730)
dateNoProm1$AVGNOPROM <- mean(dateNoProm1$VALUE_POL)
dateNoProm2$AVGNOPROM <- mean(dateNoProm2$VALUE_POL)
dateNoProm3$AVGNOPROM <- mean(dateNoProm3$VALUE_POL)

idArson <- c(1:1096)
querryNoArson$ID <- idArson
dateNoArson1 <- subset(querryNoArson, querryNoArson$ID < 366)
dateNoArson2 <- subset(querryNoArson, querryNoArson$ID < 731)
dateNoArson3 <- subset(querryNoArson, querryNoArson$ID > 730)
dateNoArson1$AVGNOARSON <- mean(dateNoArson1$VALUE_POL)
dateNoArson2$AVGNOARSON <- mean(dateNoArson2$VALUE_POL)
dateNoArson3$AVGNOARSON <- mean(dateNoArson3$VALUE_POL)

querryNo2Aeroport$ID <- idAeroport
dateNo2Aero1 <- subset(querryNo2Aeroport,querryNo2Aeroport$ID < 366)
dateNo2Aero2 <- subset(querryNo2Aeroport, querryNo2Aeroport$ID < 731)
dateNo2Aero3 <- subset(querryNo2Aeroport, querryNo2Aeroport$ID > 730)
dateNo2Aero1$AVGNO2AERO <- mean(dateNo2Aero1$VALUE_POL)
dateNo2Aero2$AVGNO2AERO <- mean(dateNo2Aero2$VALUE_POL)
dateNo2Aero3$AVGNO2AERO <- mean(dateNo2Aero3$VALUE_POL)

querryNo2Arson$ID <- idArson
dateNo2Arson1 <- c
dateNo2Arson2 <- subset(querryNo2Arson, querryNo2Arson$ID < 731)
dateNo2Arson3 <- subset(querryNo2Arson, querryNo2Arson$ID > 730)
dateNo2Arson1$AVGNO2ARSON <- mean(dateNo2Arson1$VALUE_POL)
dateNo2Arson2$AVGNO2ARSON <- mean(dateNo2Arson2$VALUE_POL)
dateNo2Arson3$AVGNO2ARSON <- mean(dateNo2Arson3$VALUE_POL)

querryNo2Prom$ID <- idProm
dateNo2Prom1 <- subset(querryNo2Prom, querryNo2Prom$ID < 366)
dateNo2Prom2 <- subset(querryNo2Prom, querryNo2Prom$ID < 731)
dateNo2Prom3 <- subset(querryNo2Prom, querryNo2Prom$ID > 730)
dateNo2Prom1$AVGNO2PROM <- mean(dateNo2Prom1$VALUE_POL)
dateNo2Prom2$AVGNO2PROM <- mean(dateNo2Prom2$VALUE_POL)
dateNo2Prom3$AVGNO2PROM <- mean(dateNo2Prom3$VALUE_POL)


querryNOXAeroport$ID <- idAeroport
dateNoxAero1 <- subset(querryNOXAeroport, querryNOXAeroport$ID < 366)
dateNoxAero2 <- subset(querryNOXAeroport, querryNOXAeroport$ID < 731)
dateNoxAero3 <- subset(querryNOXAeroport, querryNOXAeroport$ID > 730)
dateNoxAero1$AVGNOXAEROPORT<- mean(dateNoxAero1$VALUE_POL)
dateNoxAero2$AVGNOXAEROPORT <- mean(dateNoxAero2$VALUE_POL)
dateNoxAero3$AVGNOXAEROPORT <- mean(dateNoxAero3$VALUE_POL)


querryNOXArson$ID <- idArson
dateNoxArson1 <- subset(querryNOXArson, querryNOXArson$ID < 366)
dateNoxArson2 <- subset(querryNOXArson, querryNOXArson$ID < 731)
dateNoxArson3 <- subset(querryNOXArson, querryNOXArson$ID > 730)
dateNoxArson1$AVGNOXARSON <- mean(dateNoxArson1$VALUE_POL)
dateNoxArson2$AVGNOXARSON <- mean(dateNoxArson2$VALUE_POL)
dateNoxArson3$AVGNOXARSON <- mean(dateNoxArson3$VALUE_POL)

querryNOXContes$ID <- idContes
dateNoxContes1 <- subset(querryNOXContes, querryNOXContes$ID < 366)
dateNoxContes2 <- subset(querryNOXContes, querryNOXContes$ID < 731)
dateNoxContes3 <- subset(querryNOXContes, querryNOXContes$ID > 730)
dateNoxContes1$AVGNOXCONTES <- mean(dateNoxContes1$VALUE_POL)
dateNoxContes2$AVGNOXCONTES <- mean(dateNoxContes2$VALUE_POL)
dateNoxContes3$AVGNOXCONTES <- mean(dateNoxContes3$VALUE_POL)

querryNOXPromenade$ID <- idProm
dateNoxProm1 <- subset(querryNOXPromenade, querryNOXPromenade$ID < 366)
dateNoxProm2 <- subset(querryNOXPromenade, querryNOXPromenade$ID < 731)
dateNoxProm3 <- subset(querryNOXPromenade, querryNOXPromenade$ID > 730)
dateNoxProm1$AVGNOXPROM <- mean(dateNoxProm1$VALUE_POL)
dateNoxProm2$AVGNOXPROM <- mean(dateNoxProm2$VALUE_POL)
dateNoxProm3$AVGNOXPROM <- mean(dateNoxProm3$VALUE_POL)

querryO3Aeroport$ID <- idProm
dateO3Aero1 <- subset(querryO3Aeroport, querryO3Aeroport$ID < 366)
dateO3Aero2 <- subset(querryO3Aeroport, querryO3Aeroport$ID < 731)
dateO3Aero3 <- subset(querryO3Aeroport, querryO3Aeroport$ID > 730)
dateO3Aero1$AVGO3Aero <- mean(dateO3Aero1$VALUE_POL)
dateO3Aero2$AVGO3Aero <- mean(dateO3Aero2$VALUE_POL)
dateO3Aero3$AVGO3Aero <- mean(dateO3Aero3$VALUE_POL)


querryO3Arson$ID <- idProm
dateO3Arson1 <- subset(querryO3Arson, querryO3Arson$ID < 366)
dateO3Arson2 <- subset(querryO3Arson, querryO3Arson$ID < 731)
dateO3Arson3 <- subset(querryO3Arson, querryO3Arson$ID > 730)
dateO3Arson1$AVGO3Arson <- mean(dateO3Arson1$VALUE_POL)
dateO3Arson2$AVGO3Arson <- mean(dateO3Arson2$VALUE_POL)
dateO3Arson3$AVGO3Arson <- mean(dateO3Arson3$VALUE_POL)

querryO3NiceOuest$ID <- idProm
dateO3NiceOuest1 <- subset(querryO3NiceOuest, querryO3NiceOuest$ID < 366)
dateO3NiceOuest2 <- subset(querryO3NiceOuest, querryO3NiceOuest$ID < 731)
dateO3NiceOuest3 <- subset(querryO3NiceOuest, querryO3NiceOuest$ID > 730)
dateO3NiceOuest1$AVGNiceOuest <- mean(dateO3NiceOuest1$VALUE_POL)
dateO3NiceOuest2$AVGNiceOuest <- mean(dateO3NiceOuest2$VALUE_POL)
dateO3NiceOuest3$AVGNiceOuest <- mean(dateO3NiceOuest3$VALUE_POL)

querryPM10Aeroport$ID <- idProm
datePM10Aero1 <- subset(querryPM10Aeroport, querryPM10Aeroport$ID < 366)
datePM10Aero2 <- subset(querryPM10Aeroport, querryPM10Aeroport$ID < 731)
datePM10Aero3 <- subset(querryPM10Aeroport, querryPM10Aeroport$ID > 730)
datePM10Aero1$AVGPM10Aero <- mean(datePM10Aero1$VALUE_POL)
datePM10Aero2$AVGPM10Aero <- mean(datePM10Aero2$VALUE_POL)
datePM10Aero3$AVGPM10Aero <- mean(datePM10Aero3$VALUE_POL)

querryPM10Arson$ID <- idProm
datePM10Arson1 <- subset(querryPM10Arson, querryPM10Arson$ID < 366)
datePM10Arson2 <- subset(querryPM10Arson, querryPM10Arson$ID < 731)
datePM10Arson3 <- subset(querryPM10Arson, querryPM10Arson$ID > 730)
datePM10Arson1$AVGPM10Arson <- mean(datePM10Arson1$VALUE_POL)
datePM10Arson2$AVGPM10Arson <- mean(datePM10Arson2$VALUE_POL)
datePM10Arson3$AVGPM10Arson <- mean(datePM10Arson3$VALUE_POL)

querryPM10Contes$ID <- idProm
datePM10Contes1 <- subset(querryPM10Contes, querryPM10Contes$ID < 366)
datePM10Contes2 <- subset(querryPM10Contes, querryPM10Contes$ID < 731)
datePM10Contes3 <- subset(querryPM10Contes, querryPM10Contes$ID > 730)
datePM10Contes1$AVGPM10Contes <- mean(datePM10Contes1$VALUE_POL)
datePM10Contes2$AVGPM10Contes <- mean(datePM10Contes2$VALUE_POL)
datePM10Contes3$AVGPM10Contes <- mean(datePM10Contes3$VALUE_POL)


querryPM10Peillon$ID <- idProm
datePM10Peillon1 <- subset(querryPM10Peillon, querryPM10Peillon$ID < 366)
datePM10Peillon2 <- subset(querryPM10Peillon, querryPM10Peillon$ID < 731)
datePM10Peillon3 <- subset(querryPM10Peillon, querryPM10Peillon$ID > 730)
datePM10Peillon1$AVGPM10Peillon <- mean(datePM10Peillon1$VALUE_POL)
datePM10Peillon2$AVGPM10Peillon <- mean(datePM10Peillon2$VALUE_POL)
datePM10Peillon3$AVGPM10Peillon <- mean(datePM10Peillon3$VALUE_POL)

querryPM10Prom$ID <- idProm
datePM10Prom1 <- subset(querryPM10Prom, querryPM10Prom$ID < 366)
datePM10Prom2 <- subset(querryPM10Prom, querryPM10Prom$ID < 731)
datePM10Prom3 <- subset(querryPM10Prom, querryPM10Prom$ID > 730)
datePM10Prom1$AVGPMProm <- mean(datePM10Prom1$VALUE_POL)
datePM10Prom2$AVGPMProm <- mean(datePM10Prom2$VALUE_POL)
datePM10Prom3$AVGPMProm <- mean(datePM10Prom3$VALUE_POL)


querryPM25Arson$ID <- idArson
datePM25Arson1 <- subset(querryPM25Arson, querryPM25Arson$ID < 366)
datePM25Arson2 <- subset(querryPM25Arson, querryPM25Arson$ID < 731)
datePM25Arson3 <- subset(querryPM25Arson, querryPM25Arson$ID > 730)
datePM25Arson1$AVGPM25Arson <- mean(datePM25Arson1$VALUE_POL)
datePM25Arson2$AVGPM25Arson <- mean(datePM25Arson2$VALUE_POL)
datePM25Arson3$AVGPM25Arson <- mean(datePM25Arson3$VALUE_POL)

querryPM25Prom$ID <- idProm
datePM25Prom1 <- subset(querryPM25Prom, querryPM25Prom$ID < 366)
datePM25Prom2 <- subset(querryPM25Prom, querryPM25Prom$ID < 731)
datePM25Prom3 <- subset(querryPM25Prom, querryPM25Prom$ID > 730)
datePM25Prom1$AVGPM25Prom <- mean(datePM25Prom1$VALUE_POL)
datePM25Prom2$AVGPM25Prom <- mean(datePM25Prom2$VALUE_POL)
datePM25Prom3$AVGPM25Prom <- mean(datePM25Prom3$VALUE_POL)

annee1NO <- c('Contes', 'Aeroport', 'Promenade', 'Arson')
longitudeannee1NO <- c(longitudeConte, longitudeAeroport, longitudeProm, longitudeArson)
latitudeannee1NO <- c(latitudeContes, latitudeAeroport, latitudeProm, latitudeArson)
AVGAnnee1No <- c(11.60497, 5.882192, 27.0411, 13.26027)
querryannee1No <- data.frame(annee1NO,latitudeannee1NO,longitudeannee1NO,AVGAnnee1No)
                 
annee2NO <- c('Contes', 'Aeroport', 'Promenade', 'Arson')
longitudeannee2NO <- c(longitudeConte, longitudeAeroport, longitudeProm, longitudeArson)
latitudeannee2NO <- c(latitudeContes, latitudeAeroport, latitudeProm, latitudeArson)
AVGAnnee2No <- c(9.735901, 6.305479, 27.75205, 13.60411)
querryannee2No <- data.frame(annee2NO,latitudeannee2NO,longitudeannee2NO,AVGAnnee2No)

annee3NO <- c('Contes', 'Aeroport', 'Promenade', 'Arson')
longitudeannee3NO <- c(longitudeConte, longitudeAeroport, longitudeProm, longitudeArson)
latitudeannee3NO <- c(latitudeContes, latitudeAeroport, latitudeProm, latitudeArson)
AVGAnnee3No <- c(10.05464, 5.02459, 28.26503, 13.31694)
querryannee3No <- data.frame(annee3NO,latitudeannee3NO,longitudeannee3NO,AVGAnnee3No)

annee1NO2 <- c('Aeroport', 'Promenade', 'Arson')
longitudeannee1NO2 <- c(longitudeAeroport, longitudeProm, longitudeArson)
latitudeannee1NO2 <- c(latitudeAeroport, latitudeProm, latitudeArson)
AVGAnnee1No2 <- c(19.4274, 44.3726, 33.05479)
querryannee1No2 <- data.frame(annee1NO2,latitudeannee1NO2,longitudeannee1NO2,AVGAnnee1No2)

annee2NO2 <- c('Aeroport', 'Promenade', 'Arson')
longitudeannee2NO2 <- c(longitudeAeroport, longitudeProm, longitudeArson)
latitudeannee2NO2 <- c(latitudeAeroport, latitudeProm, latitudeArson)
AVGAnnee2No2 <- c(20.95205, 46.26712, 35.45342)
querryannee2No2 <- data.frame(annee2NO2,latitudeannee2NO2,longitudeannee2NO2,AVGAnnee2No2)

annee3NO2 <- c('Aeroport', 'Promenade', 'Arson')
longitudeannee3NO2 <- c(longitudeAeroport, longitudeProm, longitudeArson)
latitudeannee3NO2 <- c(latitudeAeroport, latitudeProm, latitudeArson)
AVGAnnee3No2 <- c(18.12295, 46.28142, 34.88525)
querryannee3No2 <- data.frame(annee3NO2,latitudeannee3NO2,longitudeannee3NO2,AVGAnnee3No2)

annee1NOX <- c('Contes', 'Aeroport', 'Promenade', 'Arson')
longitudeannee1NOX <- c(longitudeConte, longitudeAeroport, longitudeProm, longitudeArson)
latitudeannee1NOX <- c(latitudeContes, latitudeAeroport, latitudeProm, latitudeArson)
AVGAnnee1NoX <- c(40.90959, 28.59726, 85.77808, 53.34521)
querryannee1NoX <- data.frame(annee1NOX,latitudeannee1NOX,longitudeannee1NOX,AVGAnnee1NoX)

annee2NOX <- c('Contes', 'Aeroport', 'Promenade', 'Arson')
longitudeannee2NOX <- c(longitudeConte, longitudeAeroport, longitudeProm, longitudeArson)
latitudeannee2NOX <- c(latitudeContes, latitudeAeroport, latitudeProm, latitudeArson)
AVGAnnee2NoX <- c(35.83014, 30.99726, 88.71781, 56.26712)
querryannee2NoX <- data.frame(annee2NOX,latitudeannee2NOX,longitudeannee2NOX,AVGAnnee2NoX)

annee3NOX <- c('Contes', 'Aeroport', 'Promenade', 'Arson')
longitudeannee3NOX <- c(longitudeConte, longitudeAeroport, longitudeProm, longitudeArson)
latitudeannee3NOX <- c(latitudeContes, latitudeAeroport, latitudeProm, latitudeArson)
AVGAnnee3NoX <- c(31.19672, 26.37705, 89.5082, 55.30055)
querryannee3NoX <- data.frame(annee3NOX,latitudeannee3NOX,longitudeannee3NOX,AVGAnnee3NoX)

annee1O3 <- c('Aeroport', 'Nice ouest', 'Arson')
longitudeannee1O3 <- c(longitudeAeroport, longitudeNiceOuest, longitudeArson)
latitudeannee1O3 <- c(latitudeAeroport, latitudeNiceOuest, latitudeArson)
AVGAnnee1O3 <- c(53.58356, 64.88219, 41.19726)
querryannee1O3 <- data.frame(annee1O3,latitudeannee1O3,longitudeannee1O3,AVGAnnee1O3)

annee2O3 <- c('Aeroport', 'Nice ouest', 'Arson')
longitudeannee2O3 <- c(longitudeAeroport, longitudeNiceOuest, longitudeArson)
latitudeannee2O3 <- c(latitudeAeroport, latitudeNiceOuest, latitudeArson)
AVGAnnee2O3 <- c(53.8726, 64.98219, 43.43425)
querryannee2O3 <- data.frame(annee2O3,latitudeannee2O3,longitudeannee2O3,AVGAnnee2O3)

annee3O3 <- c('Aeroport', 'Nice ouest', 'Arson')
longitudeannee3O3 <- c(longitudeAeroport, longitudeNiceOuest, longitudeArson)
latitudeannee3O3 <- c(latitudeAeroport, latitudeNiceOuest, latitudeArson)
AVGAnnee3O3 <- c(45.34153, 62.93169, 41.64481)
querryannee3O3 <- data.frame(annee3O3,latitudeannee3O3,longitudeannee3O3,AVGAnnee3O3)

annee1PM10 <- c('Aeroport', 'Arson', 'Contes', 'Peillon', 'Promenade')
longitudeannee1PM10 <- c(longitudeAeroport, longitudeArson, longitudeConte, longitudePeillon, longitudeProm)
latitudeannee1PM10 <- c(latitudeAeroport, latitudeArson, latitudeContes, latitudePeillon, latitudeProm)
AVGAnnee1PM10 <- c(20.87671, 25.60274, 25.65479, 21.13973, 29.52329)
querryannee1PM10 <- data.frame(annee1PM10,longitudeannee1PM10,latitudeannee1PM10,AVGAnnee1PM10)

annee2PM10 <- c('Aeroport', 'Arson', 'Contes', 'Peillon', 'Promenade')
longitudeannee2PM10 <- c(longitudeAeroport, longitudeArson, longitudeConte, longitudePeillon, longitudeProm)
latitudeannee2PM10 <- c(latitudeAeroport, latitudeArson, latitudeContes, latitudePeillon, latitudeProm)
AVGAnnee2PM10 <- c(21.32329, 25.16712, 22.09452, 23.66301, 29.21507)
querryannee2PM10 <- data.frame(annee2PM10,longitudeannee2PM10,latitudeannee2PM10,AVGAnnee2PM10)

annee3PM10 <- c('Aeroport', 'Arson', 'Contes', 'Peillon', 'Promenade')
longitudeannee3PM10 <- c(longitudeAeroport, longitudeArson, longitudeConte, longitudePeillon, longitudeProm)
latitudeannee3PM10 <- c(latitudeAeroport, latitudeArson, latitudeContes, latitudePeillon, latitudeProm)
AVGAnnee3PM10 <- c(17.23497, 24.28962, 23.98361, 22.13115, 27.85792)
querryannee3PM10 <- data.frame(annee3PM10,longitudeannee3PM10,latitudeannee3PM10,AVGAnnee3PM10)

annee1PM25 <- c('Arson','Promenade')
longitudeannee1PM25 <- c(longitudeArson, longitudeProm)
latitudeannee1PM25 <- c(latitudeArson, latitudeProm)
AVGAnnee1PM25 <- c(12.3589,14.13151)
querryannee1PM25 <- data.frame(annee1PM25,longitudeannee1PM25,latitudeannee1PM25,AVGAnnee1PM25)

annee2PM25 <- c('Arson','Promenade')
longitudeannee2PM25 <- c(longitudeArson, longitudeProm)
latitudeannee2PM25 <- c(latitudeArson, latitudeProm)
AVGAnnee2PM25 <- c(13.0726,14.75342)
querryannee2PM25 <- data.frame(annee2PM25,longitudeannee2PM25,latitudeannee2PM25,AVGAnnee2PM25)

annee3PM25 <- c('Arson','Promenade')
longitudeannee3PM25 <- c(longitudeArson, longitudeProm)
latitudeannee3PM25 <- c(latitudeArson, latitudeProm)
AVGAnnee3PM25 <- c(13.16667,12.62568)
querryannee3PM25 <- data.frame(annee3PM25,longitudeannee3PM25,latitudeannee3PM25,AVGAnnee3PM25)

id1 <- c(1:55)
id2 <- c(1:918)
id3 <- c(1:293)
id4 <- c(1:2013)
id5 <- c(1:227)
id6 <- c(1:922)
querryDyspneaAeroport$ID <- id1
querryDyspneaArson$ID <- id2
querryDyspneaContes$ID <- id3
querryDyspneaNiceOuest$ID <- id4
querryDyspneaPeillon$ID <- id5
querryDyspneaProm$ID <- id6

dateDyspneaAero1 <- subset(querryDyspneaAeroport, querryDyspneaAeroport$ID < 15)
dateDyspneaAero2 <- subset(querryDyspneaAeroport, querryDyspneaAeroport$ID < 25)
dateDyspneaAero3 <- subset(querryDyspneaAeroport, querryDyspneaAeroport$ID > 24)
dateDyspneaAero1$NBPatients <- nrow(dateDyspneaAero1)
dateDyspneaAero2$NBPatients <- nrow(dateDyspneaAero2)
dateDyspneaAero3$NBPatients <- nrow(dateDyspneaAero3)

dateDyspneArson1 <- subset(querryDyspneaArson, querryDyspneaArson$ID < 263)
dateDyspneArson2 <- subset(querryDyspneaArson, querryDyspneaArson$ID < 470)
dateDyspneArson3 <- subset(querryDyspneaArson, querryDyspneaArson$ID > 469)
dateDyspneArson1$NBPatients <- nrow(dateDyspneArson1)
dateDyspneArson2$NBPatients <- nrow(dateDyspneArson2)
dateDyspneaAero3$NBPatients <- nrow(dateDyspneArson3)

dateDyspneaContes1 <- subset(querryDyspneaContes, querryDyspneaContes$ID < 86)
dateDyspneaContes2 <- subset(querryDyspneaContes, querryDyspneaContes$ID < 141)
dateDyspneaContes3 <- subset(querryDyspneaContes, querryDyspneaContes$ID > 140)
dateDyspneaContes1$NBPatients <- nrow(dateDyspneaContes1)
dateDyspneaContes2$NBPatients <- nrow(dateDyspneaContes2)
dateDyspneaContes3$NBPatients <- nrow(dateDyspneaContes3)

dateDyspneaNiceOuest1 <- subset(querryDyspneaNiceOuest, querryDyspneaNiceOuest$ID < 578)
dateDyspneaNiceOuest2 <- subset(querryDyspneaNiceOuest, querryDyspneaNiceOuest$ID < 1105)
dateDyspneaNiceOuest3 <- subset(querryDyspneaNiceOuest, querryDyspneaNiceOuest$ID > 1104)
dateDyspneaNiceOuest1$NBPatients <- nrow(dateDyspneaNiceOuest1)
dateDyspneaNiceOuest2$NBPatients <- nrow(dateDyspneaNiceOuest2)
dateDyspneaNiceOuest3$NBPatients <- nrow(dateDyspneaNiceOuest3)

dateDyspneaPeillon1 <- subset(querryDyspneaPeillon, querryDyspneaPeillon$ID < 72)
dateDyspneaPeillon2 <- subset(querryDyspneaPeillon, querryDyspneaPeillon$ID < 117)
dateDyspneaPeillon3 <- subset(querryDyspneaPeillon, querryDyspneaPeillon$ID > 116)
dateDyspneaPeillon1$NBPatients <- nrow(dateDyspneaPeillon1)
dateDyspneaPeillon2$NBPatients <- nrow(dateDyspneaPeillon2)
dateDyspneaPeillon3$NBPatients <- nrow(dateDyspneaPeillon3)

dateDyspneaProm1 <- subset(querryDyspneaProm, querryDyspneaProm$ID < 281)
dateDyspneaProm2 <- subset(querryDyspneaProm, querryDyspneaProm$ID < 509)
dateDyspneaProm3 <- subset(querryDyspneaProm, querryDyspneaProm$ID > 508)
dateDyspneaProm1$NbPatients <- nrow(dateDyspneaProm1)
dateDyspneaProm2$NbPatients <- nrow(dateDyspneaProm2)
dateDyspneaProm3$NbPatients <- nrow(dateDyspneaProm3)

querryDyspnea <- c('Aeroport', 'Contes', 'Nice Ouest', 'Peillon', 'Promenade', 'Arson')
lattiudeDyspnea <- c(latitudeAeroport, latitudeContes, latitudeNiceOuest, latitudePeillon, latitudeProm, latitudeArson)
longitudeDyspnea <- c(longitudeAeroport, longitudeConte, longitudeNiceOuest, longitudePeillon, longitudeProm, longitudeArson)
AVG1 <- c(14, 85,577, 71, 280, 262)
AVG2 <- c(24, 140, 1104, 116, 508, 469)
AVG3 <- c(449, 153, 909, 111, 414, 918)


querryDyspnea1 <- data.frame(querryDyspnea, lattiudeDyspnea, longitudeDyspnea, AVG1)

querryDyspnea2 <- data.frame(querryDyspnea, lattiudeDyspnea, longitudeDyspnea, AVG2)

querryDyspnea3 <- data.frame(querryDyspnea, lattiudeDyspnea, longitudeDyspnea, AVG3)

MakeMap(querryannee1No$latitudeannee1NO, querryannee1No$longitudeannee1NO,f, scaleby = querryannee1No$AVGAnnee1No)
MakeMap(querryannee1No2$latitudeannee1NO2, querryannee1No2$longitudeannee1NO2, f, scaleby = querryannee1No2$AVGAnnee1No2, col = "coral", add = TRUE)
MakeMap(querryannee1NoX$latitudeannee1NOX, querryannee1NoX$longitudeannee1NOX, f, scaleby = querryannee1NoX$AVGAnnee1NoX, col = "gold", add = TRUE)
MakeMap(querryannee1O3$latitudeannee1O3, querryannee1O3$longitudeannee1O3, f, scaleby = querryannee1O3$AVGAnnee1O3, col="cyan", add = TRUE)
MakeMap(querryannee1PM10$latitudeannee1PM10, querryannee1PM10$longitudeannee1PM10, f, scaleby = querryannee1PM10$AVGAnnee1PM10, col = "green", add = TRUE)
MakeMap(querryannee1PM25$latitudeannee1PM25, querryannee1PM25$longitudeannee1PM25, f, scaleby =  querryannee1PM25$AVGAnnee1PM25, col = "orangered", add = TRUE)
MakeMap(querryDyspnea1$lattiudeDyspnea, querryDyspnea1$longitudeDyspnea, f, scaleby = querryDyspnea1$AVG1, col = "magenta", add = TRUE)

MakeMap(querryannee2No$latitudeannee2NO, querryannee2No$longitudeannee2NO,f, scaleby = querryannee2No$AVGAnnee2No)
MakeMap(querryannee2No2$latitudeannee2NO2, querryannee2No2$longitudeannee2NO2, f, scaleby = querryannee2No2$AVGAnnee2No2, col = "coral", add = TRUE)
MakeMap(querryannee2NoX$latitudeannee2NOX, querryannee2NoX$longitudeannee2NOX, f, scaleby = querryannee2NoX$AVGAnnee2NoX, col = "gold", add = TRUE)
MakeMap(querryannee2O3$latitudeannee2O3, querryannee2O3$longitudeannee2O3, f, scaleby = querryannee2O3$AVGAnnee2O3, col="cyan", add = TRUE)
MakeMap(querryannee2PM10$latitudeannee2PM10, querryannee2PM10$longitudeannee2PM10, f, scaleby = querryannee2PM10$AVGAnnee2PM10, col = "green", add = TRUE)
MakeMap(querryannee2PM25$latitudeannee2PM25, querryannee2PM25$longitudeannee2PM25, f, scaleby =  querryannee2PM25$AVGAnnee2PM25, col = "orangered", add = TRUE)
MakeMap(querryDyspnea2$lattiudeDyspnea, querryDyspnea2$longitudeDyspnea, f, scaleby = querryDyspnea2$AVG2, col = "magenta", add = TRUE)

MakeMap(querryannee3No$latitudeannee3NO, querryannee3No$longitudeannee3NO,f, scaleby = querryannee3No$AVGAnnee3No)
MakeMap(querryannee3No2$latitudeannee3NO2, querryannee3No2$longitudeannee3NO2, f, scaleby = querryannee3No2$AVGAnnee3No2, col = "coral", add = TRUE)
MakeMap(querryannee3NoX$latitudeannee3NOX, querryannee3NoX$longitudeannee3NOX, f, scaleby = querryannee3NoX$AVGAnnee3NoX, col = "gold", add = TRUE)
MakeMap(querryannee3O3$latitudeannee3O3, querryannee3O3$longitudeannee3O3, f, scaleby = querryannee3O3$AVGAnnee3O3, col="cyan", add = TRUE)
MakeMap(querryannee3PM10$latitudeannee3PM10, querryannee3PM10$longitudeannee3PM10, f, scaleby = querryannee3PM10$AVGAnnee3PM10, col = "green", add = TRUE)
MakeMap(querryannee3PM25$latitudeannee3PM25, querryannee3PM25$longitudeannee3PM25, f, scaleby =  querryannee3PM25$AVGAnnee3PM25, col = "orangered", add = TRUE)
MakeMap(querryDyspnea3$lattiudeDyspnea, querryDyspnea3$longitudeDyspnea, f, scaleby = querryDyspnea3$AVG3, col = "magenta", add = TRUE)
## CLUSTURING

matrixDyspnea <- as.matrix(newQuerryDyspnea)
matrixDyspnea <- as.numeric(matrixDyspnea)
my_data <- matrixDyspnea
matrixDyspnea <- na.omit(matrixDyspnea)

my_data <- na.omit(matrixDyspnea)
# Scale variables
my_data <- scale(my_data)
# View the firt 3 rows
head(my_data, n = 3)
require(graphics)
library("cluster")
library("factoextra")
res.dist <- get_dist(matrixDyspnea, stand = TRUE, method = "pearson")
fviz_dist(res.dist, 
          gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
#optimal number of clusters
fviz_nbclust(my_data, kmeans, method = "gap_stat") 
km.res <- kmeans(my_data, 4, nstart = 25)
fviz_cluster(km.res, data = my_data, frame.type = "convex")+
  theme_minimal()
my_data <- my_data[,sapply(my_data, function(v) var(v, na.rm=TRUE)!=0)]

pam.res <- pam(my_data, 4)
fviz_cluster(pam.res)

#hierarchical clusturing 

newQuerryDyspnea <- querryDyspnea
newQuerryDyspnea <- newQuerryDyspnea[,-4]
newQuerryDyspnea$GENDER[newQuerryDyspnea$GENDER=='F']<-0
newQuerryDyspnea$GENDER[newQuerryDyspnea$GENDER=='M']<-1
newQuerryDyspnea$TYPEDESORTIE[newQuerryDyspnea$TYPEDESORTIE=='H']<-0.1
newQuerryDyspnea$TYPEDESORTIE[newQuerryDyspnea$TYPEDESORTIE=='T']<-0.2
newQuerryDyspnea$TYPEDESORTIE[newQuerryDyspnea$TYPEDESORTIE=='E']<-0.3
newQuerryDyspnea$TYPEDESORTIE[newQuerryDyspnea$TYPEDESORTIE=='F']<-0.4
newQuerryDyspnea$TYPEDESORTIE[newQuerryDyspnea$TYPEDESORTIE=='D']<-0.5
newQuerryDyspnea$STATION[newQuerryDyspnea$STATION=='Aeroport de Nice']<-001
newQuerryDyspnea$STATION[newQuerryDyspnea$STATION=='Contes 2']<-002
newQuerryDyspnea$STATION[newQuerryDyspnea$STATION=='Nice Arson']<-003
newQuerryDyspnea$STATION[newQuerryDyspnea$STATION=='Nice Ouest Botanique']<-004
newQuerryDyspnea$STATION[newQuerryDyspnea$STATION=='Nice Promenade des Anglais']<-005
newQuerryDyspnea$STATION[newQuerryDyspnea$STATION=='Peillon']<-006
newQuerryDyspnea$LIBELLEGRAVITE[newQuerryDyspnea$LIBELLEGRAVITE=='3*']<-3

dys <- newQuerryDyspnea
id <- c(1:51)
dys$ID <- id

# 1. Loading and preparing data
hcut <- function(x, k = 2, isdiss = inherits(x, "dist"), 
                 hc_func = c("hclust", "agnes", "diana"),
                 hc_method = "ward.D2", hc_metric = "euclidean",
                 stand = FALSE, graph = FALSE, ...){
  
  if(!inherits(x, c("matrix", "data.frame", "dist")))
    stop("The data must be of class matrix, data.frame, or dist")
  if(stand) x <- scale(x)
  data <- x
  
  hc_func <- match.arg(hc_func)
  hc_func <- hc_func[1]
  
  if(!isdiss) x <- get.dist(x)
  
  
  if(hc_func == "hclust") hc <- stats::hclust(x, method = hc_method)
  else if(hc_func == "agnes") {
    if(hc_method %in%c("ward.D", "ward.D2")) hc_method = "ward"
    hc <- cluster::agnes(x, method = hc_method)
  }
  else if(hc_func == "diana") hc <- cluster::diana(x)
  else stop("Don't support the function ", hc_func)
  hc.cut <- stats::cutree(hc, k = k)
  hc$cluster = hc.cut
  hc$nbclust <- k
  if(k > 1)  hc$silinfo <- .get_silinfo(hc.cut, x)
  hc$size <- as.vector(table(hc.cut))
  hc$data <- data
  class(hc) <- c(class(hc), "hcut")
  if(graph) fviz_dend(hc)
  hc
}
get.dist <- function(x, input = FALSE, output = "list", matrix.res = "TK25"){
  
  
  ##checkpoint internet connection
  testCon <- function(url = "http://www.google.com") {
    
    # test the http capabilities of the current R build
    http <- as.logical(capabilities(what = "http/ftp"))
    if (!http) return(FALSE)
    
    # test connection by trying to read first line at url
    test <- try(suppressWarnings(readLines(url, n = 1)), silent = TRUE)  # silent errors
    
    # return FALSE if test is class 'try-error'
    ifelse(inherits(test, "try-error"), FALSE, TRUE)
  }
  con <- testCon()
  if (con==FALSE){
    stop("You have no working internet connection.")
  }
  
  conFloraWeb <- testCon("http://floraweb.de/pflanzenarten/download_tkq.xsql?suchnr=1")
  if (conFloraWeb==FALSE){
    stop("No respond from the Server of FloraWeb, try again later.")
  }
  #rm(c("con","conFloraWeb","testCon")
  ##checkpoint data input
  if (is.logical(input)==F){
    stop ("Value for input must be logical.")
  }
  if (input==F){
    if(length(grep(pattern="_",as.character(x[,1]),ignore.case=T))<length(x[,1])){
      stop("All taxon names must be seperated into genus and epithet by \"_\".")
    }
    if ((length(unlist(strsplit(as.character(x[1:nrow(x),1]),split="_",fixed=T)))==
         length(x[,1])*2)==FALSE){
      stop("All taxon names must include genus and epithet seperatet by \"_\".
           Hint: Sometimes species like Capsella_bursa-pastoris are written as
           Capsella_bursa_pastoris. This pattern can cause this error.")
    }
    }
  
  ##checkpoint "output" value
  if (output!="list"&output!="matrix"){
    stop("improper value for output")
  }
  ##checkpoint "matrix.res" value
  if (matrix.res!="TK25" & matrix.res!= "quarterTK"){
    stop("Value for matrix.res must be either \"TK25\" or \"quarterTK\" ")
  }
  ##check_species
  if (input == F){
    matches <- suppressMessages(check_species(x,level="species"))
  }else{
    matches <- x
  }
  if (length(attributes(matches)$mismatches)!=0){
    message(length(attributes(matches)$mismatches)," ", "input entries without matching data:")
    message(attributes(matches)$mismatches)
  }
  ##Liste
  maps <- as.list(rep(NA,length(matches$NAMNR)))
  if (output=="list"){
    for (i in 1:nrow(matches)){
      url <- url(paste0("http://floraweb.de/pflanzenarten/download_tkq.xsql?suchnr=",
                        matches$NAMNR[i]))
      a <- suppressWarnings(utils::read.table(url, skip=43,sep=","))
      names(a) <- c("ID","NAMNR","TAXONNAME","TK","LAT","LON","FLAECHE",
                    "UNSCHAERFERADIUS","STATUSCODE","STATUS","ZEITRAUM","ZEITRAUM_TEXT")
      maps[[i]] <- data.frame(a)
      names(maps)[i] <- as.character(unique(a$TAXONNAME))
      closeAllConnections()
      message(paste0("  Downloaded  ", paste(i), "/",nrow(matches)))
    }
    return(maps)
  }
  
  ##matrix TK25-Plots
  if (output == "matrix" & matrix.res == "TK25"){
    rowsmatrixTK25 <- data.frame(unique(round(rowsmatrix$TK,-1)))
    names(rowsmatrixTK25) <- "TK"
    distmatrix <- matrix(NA,nrow=length(rowsmatrixTK25$TK),ncol=length(matches$NAMNR),
                         dimnames=list(rowsmatrixTK25$TK,matches$species))
    for (i in 1:nrow(matches)){
      url <- url(paste0("http://floraweb.de/pflanzenarten/download_tkq.xsql?suchnr=",
                        matches$NAMNR[i]))
      a <- suppressWarnings(utils::read.table(url, skip=43,sep=",")[,c(3,4)])
      names(a) <-c("TAXONNAME", "TK")
      #if(length(which((a$TK-round(a$TK,-1))==0)) != 0){
      #   a <- a[-which((a$TK-round(a$TK,-1))==0),]
      #}
      distmatrix[,i] <- ifelse(row.names(distmatrix)%in%as.character(round(a$TK,-1)),1,0)
      closeAllConnections()
      message(paste0("  Downloaded  ", paste(i), "/",nrow(matches)))
    }
    return(distmatrix)
  }
  
  
  if (output =="matrix" & matrix.res == "quarterTK"){
    
    distmatrix <- matrix(NA,nrow=length(rowsmatrix$TK),ncol=length(matches$NAMNR),
                         dimnames=list(rowsmatrix$TK,matches$species))
    for (i in 1:nrow(matches)){
      url <- url(paste0("http://floraweb.de/pflanzenarten/download_tkq.xsql?suchnr=",matches$NAMNR[i]))
      a <- suppressWarnings(utils::read.table(url, skip=43,sep=",")[,c(3,4)])
      names(a) <-c("TAXONNAME", "TK")
      distmatrix[,i] <- ifelse(row.names(distmatrix)%in%as.character(a$TK),1,0)
      closeAllConnections()
      message(paste0("  Downloaded  ", paste(i), "/",nrow(matches)))
    }
    return(distmatrix)
  }
    }

newQuerryDyspnea <- na.omit(newQuerryDyspnea)
id <- c(1:4264)
newQuerryDyspnea$ID<-id
dataDyspnea <- subset(newQuerryDyspnea,newQuerryDyspnea$ID<4264)
memory.limit(size=56000)
data("matrixDyspnea")
my_data <- scale(matrixDyspnea)
# 2. Compute dissimilarity matrix
d <- dist(my_data, method = "euclidean")
# Hierarchical clustering using Ward's method
res.hc <- hclust(d, method = "ward.D2" )
# Cut tree into 4 groups
grp <- cutree(res.hc, k = 4)
# Visualize
plot(res.hc, cex = 0.6) # plot tree
rect.hclust(res.hc, k = 4, border = 2:5) # add rectangle
res <- hcut(my_data, k = 4, stand = TRUE)
library(prabclus)
library(DEoptimR)
library(trimcluster)
library(agricolae)
# Visualize
fviz_dend(res, rect = TRUE, cex = 0.5,
          k_colors = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"))
get_clust_tendency(my_data, n = 50,
                   gradient = list(low = "steelblue",  high = "white"))
res.hc <- eclust(my_data, "hclust", k = 3, graph = FALSE)
fviz_silhouette(res.hc)


##nombre optimal
set.seed(123)
k.max <- 15 # Nombre max de clusters
data <- newPatientsDataPM25
wss <- sapply(1:k.max, 
              function(k){kmeans(data, k, nstart=10 )$tot.withinss})
plot(1:k.max, wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")
abline(v = 3, lty =2)

# Ward Hierarchical Clustering

mydata <- newPatientsDataNo2
d <- dist(mydata, method = "euclidean") # distance matrix
fit <- hclust(d, method="ward.D2") 
plot(fit, main="Cluster Dendogram Patients + NO2") # display dendogram
groups <- cutree(fit, k=3) # on coupe en 4 clusters
# dendogram avec rectangles 
rect.hclust(fit, k=3, border="red")


# K-Means Clustering with 4 clusters
fit <- kmeans(mydata, 3)
fit$cluster

# vary parameters for most readable graph
library(cluster) 
clusplot(mydata, fit$cluster, color=TRUE, shade=TRUE, 
         labels=2, lines=0, main="Clusplot (Dyspnee + PM25)")

id <- c(1:51)
newPatientsDataNo$ID <- id
newPatientsDataNo2$ID <- id
newPatientsDataNox$ID <- id 
newPatientsDataO3$ID <- id
newPatientsDataPM10$ID <- id
newPatientsDataPM25$ID <- id 

viewQuerryNo <- subset(newPatientsDataNo, newPatientsDataNo$ID == 7 | newPatientsDataNo$ID == 8 | newPatientsDataNo$ID ==32| newPatientsDataNo$ID ==9 | newPatientsDataNo$ID ==44 | newPatientsDataNo$ID ==10 | newPatientsDataNo$ID ==21 | newPatientsDataNo$ID ==3 | newPatientsDataNo$ID ==27 | newPatientsDataNo$ID ==39 | newPatientsDataNo$ID ==6 | newPatientsDataNo$ID ==48 | newPatientsDataNo$ID ==31 | newPatientsDataNo$ID ==13 | newPatientsDataNo$ID ==2 | newPatientsDataNo$ID ==35 | newPatientsDataNo$ID ==43 | newPatientsDataNo$ID ==46)
viewQuerryNoc2 <- subset (newPatientsDataNo, newPatientsDataNo$ID == 15 | newPatientsDataNo$ID == 22| newPatientsDataNo$ID ==51| newPatientsDataNo$ID ==17| newPatientsDataNo$ID ==30| newPatientsDataNo$ID ==14| newPatientsDataNo$ID ==11| newPatientsDataNo$ID ==25| newPatientsDataNo$ID ==28| newPatientsDataNo$ID ==45| newPatientsDataNo$ID ==12| newPatientsDataNo$ID ==42| newPatientsDataNo$ID ==34)
viewQuerryNoc3 <- subset(newPatientsDataNo, newPatientsDataNo$ID ==23| newPatientsDataNo$ID ==38| newPatientsDataNo$ID ==37| newPatientsDataNo$ID ==24| newPatientsDataNo$ID ==36| newPatientsDataNo$ID ==47| newPatientsDataNo$ID ==4| newPatientsDataNo$ID ==5| newPatientsDataNo$ID ==19)
viewQuerryNoc4 <- subset(newPatientsDataNo, newPatientsDataNo$ID==20| newPatientsDataNo$ID ==37| newPatientsDataNo$ID ==29| newPatientsDataNo$ID ==40| newPatientsDataNo$ID ==49| newPatientsDataNo$ID ==50| newPatientsDataNo$ID ==11| newPatientsDataNo$ID ==1| newPatientsDataNo$ID ==28| newPatientsDataNo$ID ==18| newPatientsDataNo$ID ==33)

viewQuerryNo2 <- subset(newPatientsDataNo2, newPatientsDataNo2$ID == 37 | newPatientsDataNo2$ID == 24| newPatientsDataNo2$ID ==36| newPatientsDataNo2$ID ==23| newPatientsDataNo2$ID ==38| newPatientsDataNo2$ID ==19| newPatientsDataNo2$ID ==4| newPatientsDataNo2$ID ==5| newPatientsDataNo2$ID ==47)
viewQuerryNo2c2 <- subset(newPatientsDataNo2, newPatientsDataNo2$ID == 6| newPatientsDataNo2$ID ==48| newPatientsDataNo2$ID ==26| newPatientsDataNo2$ID ==1| newPatientsDataNo2$ID ==3| newPatientsDataNo2$ID ==46| newPatientsDataNo2$ID ==2| newPatientsDataNo2$ID ==43| newPatientsDataNo2$ID ==31| newPatientsDataNo2$ID ==27| newPatientsDataNo2$ID ==35| newPatientsDataNo2$ID ==7| newPatientsDataNo2$ID ==29| newPatientsDataNo2$ID ==39| newPatientsDataNo2$ID ==21| newPatientsDataNo2$ID ==44| newPatientsDataNo2$ID ==20| newPatientsDataNo2$ID ==9| newPatientsDataNo2$ID ==32| newPatientsDataNo2$ID ==13| newPatientsDataNo2$ID ==11| newPatientsDataNo2$ID ==33| newPatientsDataNo2$ID ==18| newPatientsDataNo2$ID ==49| newPatientsDataNo2$ID ==50)
viewQuerryNo2c3 <- subset(newPatientsDataNo2, newPatientsDataNo2$ID ==10| newPatientsDataNo2$ID ==8| newPatientsDataNo2$ID ==40| newPatientsDataNo2$ID ==22| newPatientsDataNo2$ID ==45| newPatientsDataNo2$ID ==25| newPatientsDataNo2$ID ==28| newPatientsDataNo2$ID ==30| newPatientsDataNo2$ID ==41| newPatientsDataNo2$ID ==17| newPatientsDataNo2$ID ==15| newPatientsDataNo2$ID ==51| newPatientsDataNo2$ID ==12| newPatientsDataNo2$ID ==42| newPatientsDataNo2$ID ==14| newPatientsDataNo2$ID ==34)

viewQuerryNox <- subset(newPatientsDataNox, newPatientsDataNox$ID == 23 | newPatientsDataNox$ID == 38| newPatientsDataNox$ID ==24| newPatientsDataNox$ID ==36| newPatientsDataNox$ID ==37| newPatientsDataNox$ID ==19| newPatientsDataNox$ID ==16| newPatientsDataNox$ID ==5| newPatientsDataNox$ID ==4| newPatientsDataNox$ID ==47)
viewQuerryNoxc2 <- subset(newPatientsDataNox, newPatientsDataNox$ID == 11| newPatientsDataNox$ID ==33| newPatientsDataNox$ID ==50| newPatientsDataNox$ID ==18| newPatientsDataNox$ID ==49| newPatientsDataNox$ID ==1| newPatientsDataNox$ID ==26| newPatientsDataNox$ID ==6| newPatientsDataNox$ID ==48| newPatientsDataNox$ID ==31| newPatientsDataNox$ID ==35| newPatientsDataNox$ID ==13| newPatientsDataNox$ID ==46| newPatientsDataNox$ID ==3| newPatientsDataNox$ID ==27| newPatientsDataNox$ID ==2| newPatientsDataNox$ID ==43| newPatientsDataNox$ID ==7| newPatientsDataNox$ID ==20| newPatientsDataNox$ID ==9| newPatientsDataNox$ID ==29| newPatientsDataNox$ID ==32| newPatientsDataNox$ID ==44| newPatientsDataNox$ID ==21| newPatientsDataNox$ID ==39)
viewQuerryNoxc3 <- subset(newPatientsDataNox, newPatientsDataNox$ID == 8| newPatientsDataNox$ID ==10| newPatientsDataNox$ID ==45| newPatientsDataNox$ID ==22| newPatientsDataNox$ID ==40| newPatientsDataNox$ID ==30| newPatientsDataNox$ID ==41| newPatientsDataNox$ID ==25| newPatientsDataNox$ID ==28| newPatientsDataNox$ID ==17| newPatientsDataNox$ID ==15| newPatientsDataNox$ID ==51| newPatientsDataNox$ID ==14| newPatientsDataNox$ID ==34| newPatientsDataNox$ID ==12| newPatientsDataNox$ID ==42)

viewQuerryO3 <- subset(newPatientsDataO3, newPatientsDataO3$ID == 16 | newPatientsDataO3$ID == 5 | newPatientsDataO3$ID ==4| newPatientsDataO3$ID ==47| newPatientsDataO3$ID ==23| newPatientsDataO3$ID ==38| newPatientsDataO3$ID ==19| newPatientsDataO3$ID ==37| newPatientsDataO3$ID ==24| newPatientsDataO3$ID ==36)
viewQuerryO3c2 <- subset(newPatientsDataO3, newPatientsDataO3$ID == 6| newPatientsDataO3$ID ==48| newPatientsDataO3$ID ==26| newPatientsDataO3$ID ==27| newPatientsDataO3$ID ==31| newPatientsDataO3$ID ==43| newPatientsDataO3$ID ==3| newPatientsDataO3$ID ==2| newPatientsDataO3$ID ==1| newPatientsDataO3$ID ==35| newPatientsDataO3$ID ==7| newPatientsDataO3$ID ==21| newPatientsDataO3$ID ==50| newPatientsDataO3$ID ==9| newPatientsDataO3$ID ==20| newPatientsDataO3$ID ==29| newPatientsDataO3$ID ==32| newPatientsDataO3$ID ==44| newPatientsDataO3$ID ==11| newPatientsDataO3$ID ==33| newPatientsDataO3$ID ==18| newPatientsDataO3$ID ==39| newPatientsDataO3$ID ==49| newPatientsDataO3$ID ==13| newPatientsDataO3$ID ==46)
viewQuerryO3c3 <- subset(newPatientsDataO3, newPatientsDataO3$ID == 8 | newPatientsDataO3$ID ==10| newPatientsDataO3$ID ==30| newPatientsDataO3$ID ==41| newPatientsDataO3$ID ==40| newPatientsDataO3$ID ==45| newPatientsDataO3$ID ==25| newPatientsDataO3$ID ==28| newPatientsDataO3$ID ==12| newPatientsDataO3$ID ==42| newPatientsDataO3$ID ==14| newPatientsDataO3$ID ==34| newPatientsDataO3$ID ==22| newPatientsDataO3$ID ==51| newPatientsDataO3$ID ==15| newPatientsDataO3$ID ==17)

viewQuerryPM10 <- subset(newPatientsDataPM10, newPatientsDataPM10$ID == 47 | newPatientsDataPM10$ID == 4| newPatientsDataPM10$ID == 24| newPatientsDataPM10$ID == 5| newPatientsDataPM10$ID == 16| newPatientsDataPM10$ID == 23| newPatientsDataPM10$ID == 38| newPatientsDataPM10$ID == 19| newPatientsDataPM10$ID == 36| newPatientsDataPM10$ID == 37)
viewQuerryPM10c2 <- subset(newPatientsDataPM10, newPatientsDataPM10$ID == 8 | newPatientsDataPM10$ID == 10| newPatientsDataPM10$ID == 40| newPatientsDataPM10$ID == 28| newPatientsDataPM10$ID == 25| newPatientsDataPM10$ID == 45| newPatientsDataPM10$ID == 22| newPatientsDataPM10$ID == 30| newPatientsDataPM10$ID == 41| newPatientsDataPM10$ID == 14| newPatientsDataPM10$ID == 12| newPatientsDataPM10$ID == 34| newPatientsDataPM10$ID == 42| newPatientsDataPM10$ID == 17| newPatientsDataPM10$ID == 15| newPatientsDataPM10$ID == 51)
viewQuerryPM10c3 <- subset(newPatientsDataPM10, newPatientsDataPM10$ID == 6| newPatientsDataPM10$ID == 48| newPatientsDataPM10$ID == 1| newPatientsDataPM10$ID == 3| newPatientsDataPM10$ID == 21| newPatientsDataPM10$ID == 2| newPatientsDataPM10$ID == 35| newPatientsDataPM10$ID == 46| newPatientsDataPM10$ID == 43| newPatientsDataPM10$ID == 26| newPatientsDataPM10$ID == 27| newPatientsDataPM10$ID == 7| newPatientsDataPM10$ID == 9| newPatientsDataPM10$ID == 44| newPatientsDataPM10$ID == 13| newPatientsDataPM10$ID == 49| newPatientsDataPM10$ID == 20| newPatientsDataPM10$ID == 29| newPatientsDataPM10$ID == 32| newPatientsDataPM10$ID == 18| newPatientsDataPM10$ID == 33| newPatientsDataPM10$ID == 39| newPatientsDataPM10$ID == 11| newPatientsDataPM10$ID == 21)

viewQuerryPM25 <- subset(newPatientsDataPM25, newPatientsDataPM25$ID == 47| newPatientsDataPM25$ID == 16| newPatientsDataPM25$ID ==4| newPatientsDataPM25$ID ==5| newPatientsDataPM25$ID ==23| newPatientsDataPM25$ID ==19| newPatientsDataPM25$ID ==38| newPatientsDataPM25$ID ==36| newPatientsDataPM25$ID ==24| newPatientsDataPM25$ID ==37)
viewQuerryPM25c2 <- subset(newPatientsDataPM25, newPatientsDataPM25$ID == 2| newPatientsDataPM25$ID ==43| newPatientsDataPM25$ID ==31| newPatientsDataPM25$ID ==35| newPatientsDataPM25$ID ==6| newPatientsDataPM25$ID ==48| newPatientsDataPM25$ID ==1| newPatientsDataPM25$ID ==3| newPatientsDataPM25$ID ==26| newPatientsDataPM25$ID ==27| newPatientsDataPM25$ID ==20| newPatientsDataPM25$ID ==16| newPatientsDataPM25$ID ==33| newPatientsDataPM25$ID ==39| newPatientsDataPM25$ID ==46| newPatientsDataPM25$ID ==13| newPatientsDataPM25$ID ==11| newPatientsDataPM25$ID ==49| newPatientsDataPM25$ID ==7| newPatientsDataPM25$ID ==50| newPatientsDataPM25$ID ==21| newPatientsDataPM25$ID ==44| newPatientsDataPM25$ID ==9| newPatientsDataPM25$ID ==29| newPatientsDataPM25$ID ==32)
viewQuerryPM25c3 <- subset(newPatientsDataPM25, newPatientsDataPM25$ID == 8| newPatientsDataPM25$ID ==40| newPatientsDataPM25$ID ==10| newPatientsDataPM25$ID ==45| newPatientsDataPM25$ID ==25| newPatientsDataPM25$ID ==28| newPatientsDataPM25$ID ==22| newPatientsDataPM25$ID ==30| newPatientsDataPM25$ID ==41| newPatientsDataPM25$ID ==51| newPatientsDataPM25$ID ==15| newPatientsDataPM25$ID ==17| newPatientsDataPM25$ID ==14| newPatientsDataPM25$ID ==12| newPatientsDataPM25$ID ==34| newPatientsDataPM25$ID ==42)



patientsDataNo2 <- patientsDataNo2[1:51,]
patientsDataNox <- patientsDataNox[1:51,]
patientsDataO3 <- patientsDataO3[1:51,]
patientsDataPM10 <- patientsDataPM10[1:51,]
patientsDataPM25 <- patientsDataPM25[1:51,]
patientsDataNo2 <- patientsDataNo2[,-1]
patientsDataNox <- patientsDataNox[,-1]
patientsDataO3 <- patientsDataO3[,-1]
patientsDataPM10 <- patientsDataPM10[,-1]
patientsDataPM25 <- patientsDataPM25[,-1]




## divers clusturing
k.means.fit <- kmeans(newPatientsDataNo, 5)
attributes(k.means.fit)
k.means.fit$centers
k.means.fit$cluster
k.means.fit$size

wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")}

wssplot(newPatientsDataNo, nc=6)

library(cluster)

clusplot(newPatientsDataNo, k.means.fit$cluster, main='2D representation of the Cluster solution', color=TRUE, shade=TRUE, labels=2, lines=0)

newPatientsDataNo <- merge(x=dys , y= patientsDataNo, by= 'ID')
newPatientsDataNo2 <- merge(x=dys, y=patientsDataNo2, by= 'ID')
newPatientsDataNox <- merge(x=dys, y=patientsDataNox, by= 'ID')
newPatientsDataO3 <- merge(x=dys, y=patientsDataO3, by= 'ID')
newPatientsDataPM10 <- merge(x=dys, y=patientsDataPM10, by= 'ID')
newPatientsDataPM25 <- merge(x=dys, y=patientsDataPM25, by= 'ID')


### some sample data
library(vegan3d)
data(newPatientsDataNo)

# kmeans
kclus <- kmeans(newPatientsDataNo,centers= 6)

# distance matrix
dune_dist <- dist(newPatientsDataNo)

# Multidimensional scaling
cmd <- cmdscale(dune_dist)

# plot MDS, with colors by groups from kmeans
groups <- levels(factor(kclus$cluster))
ordiplot(cmd, type = "n")
cols <- c("steelblue", "darkred", "darkgreen", "pink")
for(i in seq_along(groups)){
  points(cmd[factor(kclus$cluster) == groups[i], ], col = cols[i], pch = 16)
}

# add spider and hull
ordispider(cmd, factor(kclus$cluster), label = TRUE)
ordihull(cmd, factor(kclus$cluster), lty = "dotted")

library(devtools)
install_github("pablo14/clusplus")
library(clusplus)

## Create k-means model with 3 clusters
fit_mtcars=kmeans(newPatientsDataNo,6)

## Call the function
plot_clus_coord(fit_mtcars, mtcars)



############## CARTE DYNAMIQUE
library(rgdal)
library(memoise)
i <- 1
for(i in 1:3){
  MakeMap(querryannee1No$latitudeannee1NO, querryannee1No$longitudeannee1NO,f, scaleby = querryannee1No$AVGAnnee1No)
  MakeMap(querryannee1No2$latitudeannee1NO2, querryannee1No2$longitudeannee1NO2, f, scaleby = querryannee1No2$AVGAnnee1No2, col = "coral", add = TRUE)
  MakeMap(querryannee1NoX$latitudeannee1NOX, querryannee1NoX$longitudeannee1NOX, f, scaleby = querryannee1NoX$AVGAnnee1NoX, col = "gold", add = TRUE)
  MakeMap(querryannee1O3$latitudeannee1O3, querryannee1O3$longitudeannee1O3, f, scaleby = querryannee1O3$AVGAnnee1O3, col="cyan", add = TRUE)
  MakeMap(querryannee1PM10$latitudeannee1PM10, querryannee1PM10$longitudeannee1PM10, f, scaleby = querryannee1PM10$AVGAnnee1PM10, col = "green", add = TRUE)
  MakeMap(querryannee1PM25$latitudeannee1PM25, querryannee1PM25$longitudeannee1PM25, f, scaleby =  querryannee1PM25$AVGAnnee1PM25, col = "orangered", add = TRUE)
  MakeMap(querryDyspnea1$lattiudeDyspnea, querryDyspnea1$longitudeDyspnea, f, scaleby = querryDyspnea1$AVG1, col = "magenta", add = TRUE)
  timeout(3, current = as.numeric(Sys.time()))
  i <- 2
  MakeMap(querryannee2No$latitudeannee2NO, querryannee2No$longitudeannee2NO,f, scaleby = querryannee2No$AVGAnnee2No)
  MakeMap(querryannee2No2$latitudeannee2NO2, querryannee2No2$longitudeannee2NO2, f, scaleby = querryannee2No2$AVGAnnee2No2, col = "coral", add = TRUE)
  MakeMap(querryannee2NoX$latitudeannee2NOX, querryannee2NoX$longitudeannee2NOX, f, scaleby = querryannee2NoX$AVGAnnee2NoX, col = "gold", add = TRUE)
  MakeMap(querryannee2O3$latitudeannee2O3, querryannee2O3$longitudeannee2O3, f, scaleby = querryannee2O3$AVGAnnee2O3, col="cyan", add = TRUE)
  MakeMap(querryannee2PM10$latitudeannee2PM10, querryannee2PM10$longitudeannee2PM10, f, scaleby = querryannee2PM10$AVGAnnee2PM10, col = "green", add = TRUE)
  MakeMap(querryannee2PM25$latitudeannee2PM25, querryannee2PM25$longitudeannee2PM25, f, scaleby =  querryannee2PM25$AVGAnnee2PM25, col = "orangered", add = TRUE)
  MakeMap(querryDyspnea2$lattiudeDyspnea, querryDyspnea2$longitudeDyspnea, f, scaleby = querryDyspnea2$AVG2, col = "magenta", add = TRUE)
  timeout(3, current = as.numeric(Sys.time()))
  i <- 3
  MakeMap(querryannee3No$latitudeannee3NO, querryannee3No$longitudeannee3NO,f, scaleby = querryannee3No$AVGAnnee3No)
  MakeMap(querryannee3No2$latitudeannee3NO2, querryannee3No2$longitudeannee3NO2, f, scaleby = querryannee3No2$AVGAnnee3No2, col = "coral", add = TRUE)
  MakeMap(querryannee3NoX$latitudeannee3NOX, querryannee3NoX$longitudeannee3NOX, f, scaleby = querryannee3NoX$AVGAnnee3NoX, col = "gold", add = TRUE)
  MakeMap(querryannee3O3$latitudeannee3O3, querryannee3O3$longitudeannee3O3, f, scaleby = querryannee3O3$AVGAnnee3O3, col="cyan", add = TRUE)
  MakeMap(querryannee3PM10$latitudeannee3PM10, querryannee3PM10$longitudeannee3PM10, f, scaleby = querryannee3PM10$AVGAnnee3PM10, col = "green", add = TRUE)
  MakeMap(querryannee3PM25$latitudeannee3PM25, querryannee3PM25$longitudeannee3PM25, f, scaleby =  querryannee3PM25$AVGAnnee3PM25, col = "orangered", add = TRUE)
  MakeMap(querryDyspnea3$lattiudeDyspnea, querryDyspnea3$longitudeDyspnea, f, scaleby = querryDyspnea3$AVG3, col = "magenta", add = TRUE)
}




timeout(1, current = as.numeric(Sys.time()))



###PREDICTIF



library(rpart)
library(e1071)
library(rpart.plot)
library(caret)
library(Metrics)

dataset <- newPatientsDataPM25[,-1]
#setting the tree control parameters
fitControl <- trainControl(method = "cv", number = 5)
cartGrid <- expand.grid(.cp=(1:50)*0.01)

#decision tree
tree_model <- train(NUMBEROFPATIENTS ~ ., data = dataset, method = "rpart", trControl = fitControl, tuneGrid = cartGrid)
print(tree_model)

main_tree <- rpart(NUMBEROFPATIENTS ~ ., data = dataset, control = rpart.control(cp=0.08))
prp(main_tree)
pre_score <- predict(main_tree, type = "vector")
rmse(dataset$NUMBEROFPATIENTS, pre_score)


#load randomForest library
library(randomForest)
library(foreach)

#set tuning parameters
control <- trainControl(method = "cv", number = 5)


#random forest model
rf_model <- train(NUMBEROFPATIENTS ~ ., data = dataset, method = "parRF", trControl = control)

#check optimal parameters
print(rf_model)


forest_model <- randomForest(as.factor(NUMBEROFPATIENTS) ~ ., data = dataset, mtry = 52, ntree = 1000)
#print(forest_model)
varImpPlot(forest_model, main="forest model nombre patients")


#decision tree
tree_model <- train(SR_ZNACH ~ ., data = dataset, method = "rpart", trControl = fitControl, tuneGrid = cartGrid)
print(tree_model)

main_tree <- rpart(SR_ZNACH ~ ., data = dataset, control = rpart.control(cp=0.15))
prp(main_tree)
pre_score <- predict(main_tree, type = "vector")
rmse(dataset$SR_ZNACH, pre_score)



#load randomForest library
library(randomForest)
library(foreach)

#set tuning parameters
control <- trainControl(method = "cv", number = 5)


#random forest model
rf_model <- train(SR_ZNACH ~ ., data = dataset, method = "parRF", trControl = control)

#check optimal parameters
print(rf_model)


forest_model <- randomForest(as.factor(SR_ZNACH) ~ ., data = dataset, mtry = 52, ntree = 1000)
#print(forest_model)
varImpPlot(forest_model, main="forest model pollution")




