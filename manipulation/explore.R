# summary
setwd("D:/dev/workspace/learn_analysis/manipulation")

custdata <- read.table('custdata.tsv', header=T, sep='\t')
summary(custdata)

# find "is.employed" which have NA
ind <- which(is.na(custdata$is.employed))
custdata[ind,]

# histogram
library(ggplot2)
ggplot(custdata) + geom_histogram(aes(x=age), binwidth=5, fill="gray")

# density plot
library(scales)
ggplot(custdata) + geom_density(aes(x=income)) + scale_x_continuous(labels=dollar)

# log-scaled density plot
ggplot(custdata) + geom_density(aes(x=income)) + scale_x_log10(breaks=c(100,1000,10000,100000), labels=dollar) + annotation_logticks(sides="bt")

# bar chart
ggplot(custdata) + geom_bar(aes(x=marital.stat), fill="gray")

# horizontal bar chart
ggplot(custdata) + geom_bar(aes(x=state.of.res), fill="gray") + coord_flip() + theme(axis.text.y=element_text(size=(rel(0.8))))

# bar chart with sorted categories
statesums <- table(custdata$state.of.res)
statef <- as.data.frame(statesums)
colnames(statef) <- c("state.of.res", "count")
summary(statef)
statef <- transform(statef, state.of.res=reorder(state.of.res, count))
ggplot(statef) + geom_bar(aes(x=state.of.res, y=count), stat="identity", fill="gray") + coord_flip() + theme(axis.text.y=element_text(size=(rel(0.8))))

