# loading libraries
library(plyr)

formatNGram <- function(n, freqRDS) {
	rownames(freqRDS) <- NULL
	words <- strsplit(as.character(freqRDS$word), " ", n)  # split col2 by space into 2
	# create another data frame from words
	df <- ldply(words)
	# combine the data frame
	freqRDSFormatted <- cbind(df, freqRDS$freq)
	# column vector
	columnNames <- c()
	for (i in 1:n){
	  temp <- paste("word",toString(i), sep='')
	  columnNames <-  append(columnNames,temp)
	}
	columnNames<-append(columnNames,"freq")
	# set column names
	colnames(freqRDSFormatted) <- columnNames
	fileTitle <- paste("words",toString(n),"Formatted.rds", sep = '');
	saveRDS(freqRDSFormatted, fileTitle)
}

twowordfreq  <- readRDS("twowordfreq.rds")
threewordfreq<- readRDS("threewordfreq.rds")
fourwordfreq <- readRDS("fourwordfreq.rds")
fivewordfreq <- readRDS("fivewordfreq.rds")

formatNGram(2,twowordfreq)
formatNGram(3,threewordfreq)
formatNGram(4,fourwordfreq)
formatNGram(5,fivewordfreq)