# Identify loan applicants who are likely to default

library(rpart)
library(partykit)
load('GCDData.RData')
model <- rpart(Good.Loan ~ 
                 Duration.in.month + 
                 Installment.rate.in.percentage.of.disposable.income +
                 Credit.amount +
                 Other.installment.plans,
                 data=d,
                 control=rpart.control(maxdepth=4),
                 method="class")
model.party <- as.party(model)
plot(model.party)

resultframe <- data.frame(Good.Loan=creditdata$Good.Loan, pred=predict(model, type="class"))
rtab <- table(resultframe)
rtab

# accurary
sum(diag(rtab))/sum(rtab)

# precision
sum(rtab[1,1])/sum(rtab[,1])

# detection (recall)
sum(rtab[1,1])/sum(rtab[1,])


