library(ElemStatLearn)
data(prostate)
str(prostate)
small = prostate[1:5,]
lm(lpsa ~.,data=small)