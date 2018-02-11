#Deep learning on random values

dataRandom = read.csv("C:/UNICE/TPT_BIGDATASANTE/random/persons.csv",header=TRUE,sep=";")
dataDyspnee = read.csv("C:/UNICE/TPT_BIGDATASANTE/random/dyspnee.csv",header=TRUE,sep=";")
newID = c(1:1000)
dataRandom$newID <- newID
dataDyspnee$newID <- c(1:7854)

newDataDyspnee <- head(dataDyspnee, 1000)
newDataRandom <- head(dataRandom, 1000)

mergeData <- merge(newDataDyspnee, newDataRandom, by.x = "newID", by.y = "newID")


samplesize = 0.60 * nrow(mergeData)
set.seed(80)
index = sample( seq_len ( nrow ( mergeData ) ), size = samplesize )

# Create training and test set
datatrain = mergeData[ index, ]
datatest = mergeData[ -index, ]

## Scale data for neural network

max = apply(mergeData , 2 , max)
min = apply(mergeData, 2 , min)
scaled = as.data.frame(scale(as.numeric(unlist(mergeData)), center = min, scale = max - min))


