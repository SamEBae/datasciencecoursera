rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  ## Read outcome data
  data <-read.csv("C:/Users/Sam.E/Google Drive/Assignments to do/Cousera Data Science/R Programming/outcome-of-care-measures.csv", colClasses = "character")
  options(warn=-1) # sets R warnings off for NA data
  
  #check for matching state
  if(!(state %in% data$State)) { 
    stop("invalid state")
  }
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
  
  ##Get matching
  matchedStates <- which(data['State']==state)
  data[, outcomeNumber] <- as.numeric(data[, outcomeNumber])
  #match the state and subset it 
  data<-subset(data,data$State==state) 
  minVal<-min(data[[outcomeNumber]],na.rm=TRUE) # best in this case = minimum
  
  #data<-data[order(data["Hospital.Name"]),]
  data<-data[order(data[outcomeNumber]),]
  
  if(num=="best"){
    data<-data[0,]
  }else if(num=="worst"){
    data<-data[nrow(data),]
  }else{
    data<-data[num-1,]
  }
  return (data['Hospital.Name'][1,1])
}

rankhospital("TX", "heart failure", 4)
rankhospital("MN", "heart attack", 5000)
rankhospital("MD", "heart attack", "worst")