
boxstats <- boxplot(iris$Sepal.Width, horizontal=TRUE)
text(boxstats$out, rep(1, NROW(boxstats$out)), labels=boxstats$out, pos=c(1,1,3,1))

hist(iris$Sepal.Width, freq=FALSE)
lines(density(iris$Sepal.Width))
rug(jitter(iris$Sepal.Width))

barplot(tapply(iris$Sepal.Width, iris$Species, mean))

pie(table(cut(iris$Sepal.Width, breaks=10)))

mosaicplot(~ Class + Survived, data=Titanic, color=TRUE, cex=1.2)

library(mvtnorm)
x <- seq(-3, 3, .1)
y <- x
f <- function(x, y) { dmvnorm(cbind(x, y))}
persp(x, y, outer(x, y, f), theta=30, phi=30)

contour(x, y, outer(x, y, f))


dpois(3, 1)
(1^3 * exp(-1)) / (factorial(3))
pnorm(0)
qnorm(0.5)

mean(1:5)
var(1:5)
sum((1:5-mean(1:5))^2)/(5-1)
sd(1:5)


library(sampling)
strata(c("Species"), size=c(3, 1, 1), method="srswr", data=iris)

d <- data.frame(x=c("1", "2", "2", "1"),
                y=c("A", "B", "A", "B"),
                num=c(3, 5, 8, 7))
xt <- (xtabs(num ~ x + y, data=d))
margin.table(xt, 1)
margin.table(xt, 2)
margin.table(xt)

prop.table(xt, 1)
prop.table(xt, 2)
prop.table(xt)


library(MASS)
data(survey)
head(survey[c("Sex", "Exer")])
chisq.test(xtabs(~ Sex + Exer, data=survey))

x <- xtabs(~W.Hnd + Clap, data=survey)
chisq.test(x)
fisher.test(x)
help(menemar.test)
?menemar.test

Performance <- matrix(c(794, 86, 150, 570),
                        nrow = 2,
                        dimnames = list(
                          "1st Survey" = c("Approve", "Disapprove"),
                          "2nd Survey" = c("Approve", "Disapprove")))
                        
Performance
mcnemar.test(Performance)

# Chapter 7
table(survey$W.Hnd)
chisq.test(table(survey$W.Hnd), p=c(.3, .7))

shapiro.test(rnorm(1000))

ks.test(rnorm(100), runif(100))

x <- rnorm(1000, mean=10, sd=1)
qqnorm(x)
qqline(x, lty=2)

x <- runif(1000)
qqnorm(x)
qqline(x)

