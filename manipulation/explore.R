# summary
setwd("D:/dev/workspace/learn_analysis/manipulation")

custdata <- read.table('custdata.tsv', header=T, sep='\t')
summary(custdata)

# find "is.employed" which have NA
ind <- which(is.na(custdata$is.employed))
custdata[ind,]

