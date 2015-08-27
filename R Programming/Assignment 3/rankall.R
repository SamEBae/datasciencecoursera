rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <-read.csv("C:/Users/Sam.E/Google Drive/Assignments to do/Cousera Data Science/R Programming/outcome-of-care-measures.csv", colClasses = "character")
  options(warn=-1) # sets R warnings off for NA data
  
  #check for matching outcome
  outcomeNumber <- 0
  if(outcome=="heart attack"){
    outcomeNumber <- 11
  }else if(outcome=="heart failure"){
    outcomeNumber <- 17
  }else if(outcome=="pneumonia"){
    outcomeNumber <-23
  }else{
    stop("invalid outcome")
  }
  
  ## For each state, find the hospital of the given rank
    data <- data[order(data$State, data[outcomeNumber], data$Hospital.Name),]
    #each state
    state <- data$State
    state <- sort(unique(state))
    
    #array for hospital initialized with fixed size
    hospital <- rep("", length(state))
    
    #compute for each state
    for(i in 1:length(state)){
      tempData<- data[data$State==state[i],]
      numDeath <-as.numeric(tempData[,outcomeNumber])
      if(num=="best"){
        num = 1
      }else if(num=="worst"){
        num = length(rank(numDeath, na.last=NA))
      }
      hospital[i] <- tempData$Hospital.Name[order(numDeath, tempData$Hospital.Name)[num]]
    }
  ## Return a data frame with the hospital names and the (abbreviated) state nam
  return(data.frame(hospital=hospital, state=state))
}

#testcases
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)