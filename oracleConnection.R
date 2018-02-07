#install package
install.packages("RJDBC",dep=TRUE)
install.packages("rJava",dep=TRUE)

#add library
library(rJava)
library(RJDBC)

#Driver and Connection creation
oracleDriver <- JDBC("oracle.jdbc.OracleDriver", classPath="C://bigdataProject/drivers/ojdbc7.jar", " ")
conn_oracle <- dbConnect(oracleDriver, "jdbc:oracle:thin:@134.59.152.118:1521:cdb", "c##bigdata", "bigdata")
