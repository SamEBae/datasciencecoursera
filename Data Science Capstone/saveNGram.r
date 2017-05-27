library(tm)
library(RWeka)
library(SnowballC)
setwd("C:/Users/Sam.E/Desktop/datasciencecoursera/Data Science Capstone")

# randomizaation seed
set.seed(7)

textDataBlogs   <- readLines("dataset/en_US/en_US.blogs.txt", encoding = "UTF-8", skipNul=TRUE)
textDataTwitter <- readLines("dataset/en_US/en_US.twitter.txt", encoding = "UTF-8", skipNul=TRUE)
textDataNews    <- readLines("dataset/en_US/en_US.news.txt", encoding = "UTF-8", skipNul=TRUE)

# sample half
sampleSize      <- min(c(length(textDataTwitter),length(textDataNews),length(textDataBlogs)))

sampleTwitter   <- textDataTwitter[sample(1:length(textDataTwitter),sampleSize)]
sampleNews      <- textDataNews[sample(1:length(textDataNews),sampleSize)]
sampleBlogs     <- textDataBlogs[sample(1:length(textDataBlogs),sampleSize)]
sampleTextVector<- c(sampleTwitter,sampleNews,sampleBlogs)

writeLines(sampleTextVector, "sample/sample.txt")


# get the text
cname <- file.path(".", "sample")
docs  <- Corpus(DirSource(cname))

# convert to lowercase
docs <- tm_map(docs, content_transformer(tolower))

# remove more transforms
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/|@|\\|")
# remove punctuation
docs <- tm_map(docs, removePunctuation)
# remove numbers
docs <- tm_map(docs, removeNumbers)
# strip whitespace
docs <- tm_map(docs, stripWhitespace)

docs <- tm_map(docs, removeWords, stopwords("english"))

docs <- tm_map(docs, stemDocument)


# 1 word frequencies
onewordTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
onewordtm        <- DocumentTermMatrix(docs, control = list(tokenize = onewordTokenizer))

# 2 words frequencies
twowordTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
twowordtm        <- DocumentTermMatrix(docs, control = list(tokenize = twowordTokenizer))

# 3 words frequencies
threewordTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
threewordtm <- DocumentTermMatrix(docs, control = list(tokenize = threewordTokenizer))

# 4 words frequencies
fourwordTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
fourwordtm <- DocumentTermMatrix(docs, control = list(tokenize = fourwordTokenizer))

# 5 words frequencies
fivewordTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 5, max = 5))
fivewordtm <- DocumentTermMatrix(docs, control = list(tokenize = fivewordTokenizer))

onewordtmfreq <- sort(colSums(as.matrix(onewordtm)), decreasing=TRUE)
onewordfreq <- data.frame(word=names(onewordtmfreq), freq=onewordtmfreq)

twowordtmfreq <- sort(colSums(as.matrix(twowordtm)), decreasing=TRUE)
twowordfreq <- data.frame(word=names(twowordtmfreq), freq=twowordtmfreq)

threewordtmfreq <- sort(colSums(as.matrix(threewordtm)), decreasing=TRUE)
threewordfreq <- data.frame(word=names(threewordtmfreq), freq=threewordtmfreq)

fourwordtmfreq <- sort(colSums(as.matrix(fourwordtm)), decreasing=TRUE)
fourwordfreq <- data.frame(word=names(fourwordtmfreq), freq=fourwordtmfreq)

fivewordtmfreq <- sort(colSums(as.matrix(fivewordtm)), decreasing=TRUE)
fivewordfreq <- data.frame(word=names(fivewordtmfreq), freq=fivewordtmfreq)

saveRDS(onewordtm, "onewordtm.rds")
saveRDS(twowordtm, "twowordtm.rds")
saveRDS(threewordtm, "threewordtm.rds")
saveRDS(fourwordtm, "fourwordtm.rds")
saveRDS(fivewordtm, "fivewordtm.rds")

saveRDS(onewordfreq, "onewordfreq.rds")
saveRDS(twowordfreq, "twowordfreq.rds")
saveRDS(threewordfreq, "threewordfreq.rds")
saveRDS(fourwordfreq, "fourwordfreq.rds")
saveRDS(fivewordfreq, "fivewordfreq.rds")