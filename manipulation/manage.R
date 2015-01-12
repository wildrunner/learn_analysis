setwd("D:/dev/workspace/learn_analysis/manipulation")

custdata <- read.table('custdata.tsv', header=T, sep='\t')

# checking locations of missing data
summary(custdata[is.na(custdata$housing.type), c("recent.move", "num.vehicles", "is.employed")])
summary(custdata)

# remapping NA to a level
custdata$is.employed.fix <- ifelse(is.na(custdata$is.employed), "missing",
                                   ifelse(custdata$is.employed == T, "employed", "not employed"))
summary(as.factor(custdata$is.employed.fix))

# converting missing numeric data to a level
breaks <- c(0, 10000, 50000, 100000, 250000, 1000000)
Income.groups <- cut(custdata$income, breaks=breaks, include.lowest=T)
summary(Income.groups)
Income.groups <- as.character(Income.groups)
Income.groups <- ifelse(is.na(Income.groups), "no income", Income.groups)
summary(as.factor(Income.groups))

# tracking original NAs with an extra categorical variable
missingIncome <- is.na(custdata$income)
Income.fix <- ifelse(is.na(custdata$income), 0, custdata$income)

# converting age into ranges
brks <- c(0, 25, 65, Inf)
custdata$age.range <- cut(custdata$age, breaks=brks, include.lowest=T)
summary(custdata$age.range)

# centering on mean age
summary(custdata$age)
meanage <- mean(custdata$age)
custdata$age.normalized <- custdata$age/meanage
summary(custdata$age.normalized)
ggplot(custdata) + geom_density(aes(x=custdata$age.n))

# summarizing age
stdage <- sd(custdata$age)
custdata$age.normalized <- (custdata$age - meanage)/stdage
summary(custdata$age.normalized)

# splitting into test and training using a random group mark
custdata$gp <- runif(dim(custdata)[1])
testSet <- subset(custdata, custdata$gp <= 0.1)
trainingSet <- subset(custdata, custdata$gp > 0.1)

# ensuring test/train split doesn't split inside a household
hh <- unique(hhdata$household_id)
households <- data.frame(household_id=hh, gp=runif(length(hh)))
hhdata <- merge(hhdata, households, by="household_id")


















