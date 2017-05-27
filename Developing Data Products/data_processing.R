# setwd("./Desktop/Online Coursera/Coursera-Developing-Data-Products/project/")
# Load required libraries
require(data.table)
library(dplyr)
library(ggplot2)
library(DT)
library(devtools)
#set the working directory
#setwd("C:/Users/Sam.E/Desktop/datasciencecoursera/Developing Data Products")

#data from crunchbase:
if(!file.exists("crunchbase-data/companies.csv")){
  download.file("https://raw.githubusercontent.com/notpeter/crunchbase-data/master/companies.csv", destfile = "crunchbase-data/companies.csv")
}

# Read data
crunchbaseCompanies<-read.csv("crunchbase-data/companies.csv", na.strings=c("NA",""),stringsAsFactors = FALSE)
#crunchbaseCompanies<-fread("crunchbase-data/companies.csv")
#head(crunchbaseCompanies)
setnames(crunchbaseCompanies, "category_list", "categories")
setnames(crunchbaseCompanies, "funding_total_usd", "totalFunding")
setnames(crunchbaseCompanies, "funding_rounds", "fundingRounds")
setnames(crunchbaseCompanies, "founded_at", "foundedAt")

# Exploratory data analysis
sum(is.na(crunchbaseCompanies)) # 65321
length(unique(crunchbaseCompanies$permalink)) # 61398
table(crunchbaseCompanies$foundedAt) #let's just use 1915 - 2015
length(table(crunchbaseCompanies$foundedAt)) # 3828

dataSubset<-crunchbaseCompanies[1:10,]

#helper variables
numQuery<-nrow(crunchbaseCompanies)
uniqueMarketCategories<-unique(crunchbaseCompanies$market)

maxFunding<-max(crunchbaseCompanies$totalFunding) 
minFunding<-min(crunchbaseCompanies$totalFunding)

minFundingRounds<-max(crunchbaseCompanies$fundingRounds)
maxFundingRounds<-min(crunchbaseCompanies$fundingRounds)


#' @param date in YY-MM-DD format
getYearFROMYYMMDD <- function(YYMMDD){
  return(substr(YYMMDD,0,4))
}

#' Aggregate dataset by year, piece and theme
#' 
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param numFunding
#' @param minFunding
#' @param marketInput
#' @param statusInput
#' @param nameInput
#' @param sortOrder
#' @return data.table
#'
queryData<- function(dt, minYear, maxYear,numFunding,minFunding,marketInput,statusInput, nameInput, sortOrder) {
  minFunding <- strtoi(minFunding)
  minYear <- getYearFROMYYMMDD(minYear)
  maxYear <- getYearFROMYYMMDD(maxYear)
  
  print("Name:")
  print(nameInput)
  print("Min Funding:")
  print(minFunding)
  print("Market:")
  print(marketInput)
  print("Status:")
  print(statusInput)
  print("Sort:")
  print(sortOrder)
  
  result <- dt %>% filter(foundedAt >= minYear, foundedAt <= maxYear,
                          fundingRounds >=numFunding, totalFunding >= minFunding,
                          market==marketInput,status == statusInput, grepl(nameInput, name))
  if(sortOrder=="ascending"){
    result <- result[order(result$totalFunding),] 
    print("sort asced")
  }else if(sortOrder=="descending"){
    result <- result[order(-result$totalFunding),]
    print("sort descend")
  }
  #print(result)
  #numQuery<-nrow(result)
  #print(nrow(result))
  return(result)
}

#' Aggregate dataset by year, piece and theme
#' 
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param numFunding
#' @param minFunding
#' @param market
#' @return data.table
#'
groupByYearAll <- function(dt, minYear, maxYear, numFunding,
                           minFunding, market) {
  result <- dt %>% filter(year >= minYear, year <= maxYear,
                          fundingRounds >= numFunding, totalFunding >= minFunding,
                          theme %in% themes) 
  return(result)
}

#' Aggregate dataset by Market
#' 
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param numFunding
#' @param minFunding
#' @param market
#' @return result data.table
#' 
groupByMarket <- function(dt, minYear, maxYear, 
                          numFunding, minFunding, market) {
  # use pipelining
  dt <- groupByYearAll(dt, minYear, maxYear, minPiece,
                       maxPiece, themes) 
  result <- datatable(dt, options = list(iDisplayLength = 50))
  return(result)
  
}