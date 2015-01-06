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
ggplot(statef) + geom_bar(aes(x=state.of.res, y=count), stat="identity", fill="gray") +
  coord_flip() + theme(axis.text.y=element_text(size=(rel(0.8))))


# producing a line plot
x <- runif(100)
y <- x^2 + 0.2*x
ggplot(data.frame(x=x, y=y), aes(x=x, y=y)) + geom_line()

# examining the correlation between age and income
custdata2 <- subset(custdata, (custdata$age > 0 & custdata$age < 100 & custdata$income > 0))
cor(custdata2$age, custdata2$income)
ggplot(custdata, aes(x=age, y=income)) + geom_point() + ylim(0, 200000)
ggplot(custdata, aes(x=age, y=income)) + geom_point() + stat_smooth(method="lm") + ylim(0, 200000)
ggplot(custdata, aes(x=age, y=income)) + geom_point() + geom_smooth() + ylim(0, 200000)

# plotting the distribution of health.ins as a function of age
ggplot(custdata2, aes(x=age, y=as.numeric(health.ins))) + geom_point(position=position_jitter(w=0.05, h=0.05)) + geom_smooth()

# producing a hexbin plot
ggplot(custdata2, aes(x=age, y=income)) + geom_hex(binwidth=c(5, 10000)) + geom_smooth(color="white", se=F) + ylim(0,200000)

# specifying different styles of bar chart
ggplot(custdata) + geom_bar(aes(x=marital.stat, fill=health.ins)) # stacked
ggplot(custdata) + geom_bar(aes(x=marital.stat, fill=health.ins), position="dodge") # side-by-side 
ggplot(custdata) + geom_bar(aes(x=marital.stat, fill=health.ins), position="fill") # normalized to one
ggplot(custdata, aes(x=marital.stat)) + geom_bar(aes(fill=health.ins), position="fill") + 
  geom_point(aes(y=-0.05), size=0.75, alpha=0.3, position=position_jitter(h=0.01)) # with a rug

ggplot(custdata2) + geom_bar(aes(x=housing.type, fill=marital.stat), position="dodge") +
  theme(axis.text.x = element_text(angle=45, hjust=1)) # side-by-side

ggplot(custdata2) + geom_bar(aes(x=marital.stat), position="dodge", fill="darkgray") +
  facet_wrap(~ housing.type, scales="free_y") +
  theme(axis.text.x = element_text(angle=45, hjust=1)) # with facets






