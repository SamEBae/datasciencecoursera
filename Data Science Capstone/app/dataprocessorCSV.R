library(wordcloud)
# init
  setwd("C:/Users/Sam.E/Desktop/datasciencecoursera/Data Science Capstone/app/data")
  
# Load in ngrams
  if (!exists("n5")) {
    n5 <- read.csv("n5.csv", stringsAsFactors=FALSE)
  }
  if (!exists("n4")) {
    n4 <- read.csv("n4.csv", stringsAsFactors=FALSE)
  }
  if (!exists("n3")) {
    n3 <- read.csv("n3.csv", stringsAsFactors=FALSE)
  }
  if (!exists("n2")) {
    n2 <- read.csv("n2.csv", stringsAsFactors=FALSE)
  }
  
# helper functions
  cleanphrase <- function(x) {
    # convert to lowercase
    x <- tolower(x)
    # remove numbers
    x <- gsub("\\S*[0-9]+\\S*", " ", x)
    # change common hyphenated words to non
    x <- gsub("e-mail","email", x)
    # remove any brackets at the ends
    x <- gsub("^[(]|[)]$", " ", x)
    # remove any bracketed parts in the middle
    x <- gsub("[(].*?[)]", " ", x)
    # remove punctuation, except intra-word apostrophe and dash
    x <- gsub("[^[:alnum:][:space:]'-]", " ", x)
    x <- gsub("(\\w['-]\\w)|[[:punct:]]", "\\1", x)
    # compress and trim whitespace
    x <- gsub("\\s+"," ",x)
    x <- gsub("^\\s+|\\s+$", "", x)
    return(x)
  }

  ## Function that returns the last N words of cleaned phrase, in a char vec
  getlastwords <- function(phrase, n) {
    phrase <- cleanphrase(phrase)
    words <- unlist(strsplit(phrase, " "))
    if (n < 1) {
      stop("getlastwords() error: invalid n")
    }
    tail(words,n)
  }

  selectCheckNGram <- function ( phrase, frequencyData, nRows, ngram){
    # get last words in a phrase
    words <- getlastwords(phrase, ngram-1)
    # cases: bigram, trigram, etc
    if ( ngram ==2 ) {
      match <- subset(frequencyData, word1 == words[1])
      match <- subset(match, select=c(word2, freq))
    } else if ( ngram == 3 ) {
      match <- subset(frequencyData, word1 == words[1] & word2 == words[2])
      match <- subset(match, select=c(word3, freq))
    } else if ( ngram == 4 ) {
      match <- subset(frequencyData, word1 == words[1] & word2 == words[2] & word3 == words[3])
      match <- subset(match, select=c(word4, freq))
    } else if ( ngram == 5 ) {
      match <- subset(frequencyData, word1 == words[1] & word2 == words[2] & word3 == words[3] & word4 == words[4])
      match <- subset(match, select=c(word5, freq)) 
    }
    sumfreq <- sum(match$freq)
    match$freq <- round(match$freq / sumfreq * 100)
    columnName <- paste("n",toString(ngram),".MLE", sep = '');
    colnames(match) <- c("nextword",columnName)
    if (nrow(match) < nRows) {
      nRows <- nrow(match)
    }
    match[1:nRows, ]
  }

  ## Function that computes stupid backoff score
  SBScore <- function(alpha=0.4, x5, x4, x3, x2) {
    score <- 0
    if (x5 > 0) {
      score <- x5
    } else if (x4 >= 1) {
      score <- x4 * alpha
    } else if (x3 > 0) {
      score <- x3 * alpha * alpha
    } else if (x2 > 0) {
      score <- x2 * alpha * alpha * alpha
    }
    return(round(score,1))
  }
  
  ## Function that combines the nextword matches into one dataframe
  ScoreNgrams <- function(phrase, nrows=20) {
    # get dfs from parent env
    words5Formatted.match <- selectCheckNGram(phrase,n5,nrows,5)
    words4Formatted.match <- selectCheckNGram(phrase,n4,nrows,4)
    words3Formatted.match <- selectCheckNGram(phrase,n3,nrows,3)
    words2Formatted.match <- selectCheckNGram(phrase,n2,nrows,2)
    
    # merge dfs, by outer join (fills zeroes with NAs)
    merge5n4 <- merge(words5Formatted.match, words4Formatted.match, by="nextword", all=TRUE)
    merge4n3 <- merge(merge5n4, words3Formatted.match, by="nextword", all=TRUE)
    merge3n2 <- merge(merge4n3, words2Formatted.match, by="nextword", all=TRUE)
    df <- subset(merge3n2, !is.na(nextword))  # rm any zero-match results
    #print(df$nextword)
    #print(df$score)
    #wordcloud(df$nextword, max.words=100, scale=c(2, .1))
    
    if (nrow(df) > 0) {
      df <- df[order(-df$n5.MLE, -df$n4.MLE, -df$n3.MLE, -df$n2.MLE), ]
      df[is.na(df)] <- 0  # replace all NAs with 0
      # add in scores
      df$score <- mapply(SBScore, alpha=0.4, df$n5.MLE, df$n4.MLE,
                         df$n3.MLE, df$n2.MLE)
      df <- df[order(-df$score), ]
    }
    return(df)  # dataframe
  }

  

  StupidBackoff <- function(phrase, alpha=0.4, getNrows=20, showNresults=1,
                            removeProfanity=TRUE) {
    phrase <- strsplit(phrase, " ")
    nextword <- ""
    if (phrase == "") {
      return("the")
    }
    df <- ScoreNgrams(phrase, getNrows)
    if (nrow(df) == 0) {
      return("and")
    }
    
    if (showNresults > nrow(df)) {
      showNresults <- nrow(df)
    }
    if (showNresults == 1) {
      # check if top overall score is shared by multiple candidates
      topwords <- df[df$score == max(df$score), ]$nextword
      # if multiple candidates, randomly select one
      nextword <- sample(topwords, 1)
    } else {
      nextword <- df$nextword[1:showNresults]
    }
    #if (removeProfanity) {
    #  if (nextword %in% profaneWords) {
    #    nextword <- "#@?!"
    #  }
    #}
    return(nextword)
  }