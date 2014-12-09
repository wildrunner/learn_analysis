library(twitteR)
library(ROAuth)
library(RCurl)
library(tm)
library(wordcloud)
library(RColorBrewer)

# twitter auth info
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "Jmb1UaGDIaShVcLVzIBt6Zxfy"
consumerSecret <- "9Yg0sDjbNUy1cIN1dbem06RpQrBwla5V8CAqRpqfGueaskdvnY"

twitCred <- OAuthFactory$new(consumerKey=consumerKey,consumerSecret = consumerSecret, requestURL = reqURL, accessURL = accessURL, authURL = authURL)
download.file(url = "http://curl.haxx.se/ca/cacert.pem", destfile = "cacert.pem")
twitCred$handshake(cainfo = "cacert.pem")

# save twitCred as twitter credentials
save(list='twitCred',file="twitteR_credentials")

registerTwitterOAuth(twitCred)

# search twitter
tweets <- searchTwitter('interior', lang="ko", n=100, cainfo='cacert.pem')
tweets

