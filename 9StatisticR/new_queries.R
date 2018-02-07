if(!exists("foo", mode="function")) 
  
source("oracleConnection.R")

.jinit() 

oracleDriver <- JDBC("oracle.jdbc.OracleDriver", classPath="driver\\ojdbc7.jar", " ")
conn_oracle <- dbConnect(oracleDriver, "jdbc:oracle:thin:@192.168.0.229:1521:cdb", "bigdata", "bigdata")


patientsData <- dbGetQuery(conn_oracle, "Select to_date(substr(admission, 0, 10),'MM/DD/YYYY') as day_,
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
                              order by to_date(substr(admission, 0, 10),'MM/DD/YYYY')
                             ")

environmentDataNO <- dbGetQuery(conn_oracle, "select to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') As day_,
avg(value_pol) as sr_znach,
                                (select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                from env_2014_2015_2016_day_kv
                                where POLLUTANT='NO'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                )) as Average,
                                
                                (((avg(value_pol) - (select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                from env_2014_2015_2016_day_kv
                                where POLLUTANT='NO'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                )))/(select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                from env_2014_2015_2016_day_kv
                                where POLLUTANT='NO'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                )))*100) as Percent_
                                
                                from env_2014_2015_2016_day_kv
                                where POLLUTANT='NO'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                ")

environmentDataNO2 <- dbGetQuery(conn_oracle, "select to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') As day_,
avg(value_pol) as sr_znach,
                                (select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                from env_2014_2015_2016_day_kv
                                where POLLUTANT='NO2'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                )) as Average,
                                
                                (((avg(value_pol) - (select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                from env_2014_2015_2016_day_kv
                                where POLLUTANT='NO2'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                )))/(select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                from env_2014_2015_2016_day_kv
                                where POLLUTANT='NO2'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                )))*100) as Percent_
                                
                                from env_2014_2015_2016_day_kv
                                where POLLUTANT='NO2'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                ")

environmentDataNOX <- dbGetQuery(conn_oracle, "select to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') As day_,
avg(value_pol) as sr_znach,
                                 (select avg(value_) from (
                                 select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                 from env_2014_2015_2016_day_kv
                                 where POLLUTANT='NOX'
                                 group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 )) as Average,
                                 
                                 (((avg(value_pol) - (select avg(value_) from (
                                 select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                 from env_2014_2015_2016_day_kv
                                 where POLLUTANT='NOX'
                                 group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 )))/(select avg(value_) from (
                                 select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                 from env_2014_2015_2016_day_kv
                                 where POLLUTANT='NOX'
                                 group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 )))*100) as Percent_
                                 
                                 from env_2014_2015_2016_day_kv
                                 where POLLUTANT='NOX'
                                 group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 ")

environmentDataO3 <- dbGetQuery(conn_oracle, "select to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') As day_,
avg(value_pol) as sr_znach,
                                 (select avg(value_) from (
                                 select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                 from env_2014_2015_2016_day_kv
                                 where POLLUTANT='O3'
                                 group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 )) as Average,
                                 
                                 (((avg(value_pol) - (select avg(value_) from (
                                 select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                 from env_2014_2015_2016_day_kv
                                 where POLLUTANT='O3'
                                 group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 )))/(select avg(value_) from (
                                 select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                 from env_2014_2015_2016_day_kv
                                 where POLLUTANT='O3'
                                 group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 )))*100) as Percent_
                                 
                                 from env_2014_2015_2016_day_kv
                                 where POLLUTANT='O3'
                                 group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                 ")

environmentDataPM10 <- dbGetQuery(conn_oracle, "select to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') As day_,
avg(value_pol) as sr_znach,
                                (select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                from env_2014_2015_2016_day_kv
                                where POLLUTANT='PM10'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                )) as Average,
                                
                                (((avg(value_pol) - (select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                from pollution
                                where POLLUTANT='PM10'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                )))/(select avg(value_) from (
                                select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                from pollution
                                where POLLUTANT='PM10'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                )))*100) as Percent_
                                
                                from pollution
                                where POLLUTANT='PM10'
                                group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                ")

environmentDataPM25 <- dbGetQuery(conn_oracle, "select to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') As day_,
avg(value_pol) as sr_znach,
                                  (select avg(value_) from (
                                  select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                  from pollution
                                  where POLLUTANT='PM2,5'
                                  group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                  order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                  )) as Average,
                                  
                                  (((avg(value_pol) - (select avg(value_) from (
                                  select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                  from pollution
                                  where POLLUTANT='PM2,5'
                                  group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                  order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                  )))/(select avg(value_) from (
                                  select  avg(value_pol) as value_, to_date(substr(date_pol, 0, 10),'DD/MM/YYYY') 
                                  from pollution
                                  where POLLUTANT='PM2,5'
                                  group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                  order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                  )))*100) as Percent_
                                  
                                  from pollution
                                  where POLLUTANT='PM2,5'
                                  group by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
                                  order by to_date(substr(date_pol, 0, 10),'DD/MM/YYYY')
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


#BEGIN OF NEW CORs

var1 <- environmentDataNO2$PERCENT_[1:966]
var2 <- patientsData2$DIFFERENCE[1:966]

cor(var1, var2, method="pearson") 
cor(var1, var2, method="spearman") 

#END OF NEW CORs

#old cors
#cor(environmentDataNO2$PERCENT_, patientsData2$DIFFERENCE, method="pearson") 
# [1] 0.1012164
#cor(environmentDataNO2$PERCENT_, patientsData2$DIFFERENCE, method="spearman") 
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
#############""creation d'un tableau coeficients de correlation patients/poluant

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
