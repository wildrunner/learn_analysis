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