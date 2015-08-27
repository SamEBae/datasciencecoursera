proper <- function(x){
  paste0(toupper(substr(x, 1, 1)), tolower(substring(x, 2)))
}

properCase <-function(x){
  properString <- ""
  words <-strsplit(x," ")
  #lapply and return 
  concated <-lapply(words,proper)
  paste0("",unlist(concated),collapse=" ")
}

best <- function(state, outcome) {
  ## Read outcome data
  data <-read.csv("C:/Users/Sam.E/Google Drive/Assignments to do/Cousera Data Science/R Programming/outcome-of-care-measures.csv", colClasses = "character")
  options(warn=-1) # sets R warnings off for NA data
  
  ## Check that state and outcome are valid
    
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
    
  ## Return hospital name in that state with lowest 30-day death
    data<-subset(data,data[outcomeNumber]==minVal)
    data<-data[order(data[["Hospital.Name"]]),]
    return(data[1,"Hospital.Name"]) # return best hospital name
  ## rate
}