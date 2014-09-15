#Hunter Carraway
#09.15.14
#CMDA 3654

getwd()
setwd("/Users/hunter/Desktop/CMDA 3456/R code")

load("phsample.RData")
#The dataset contains personal data including:occupation, level of education, personal income, and many other demographics variables

#Setting the variables as factors for better readability and ensure they are treated as characters
psub = subset(dpus,with(dpus,(PINCP>1000)&(ESR==1)& (PINCP<=250000)&
                  (PERNP>1000)&(PERNP<=250000)& (WKHP>=40)&(AGEP>=20)&(AGEP<=50)& (PWGTP1>0)&
                  (COW %in% (1:7))&(SCHL %in% (1:24))))

#Recoding 1/2 in 'sex' as M/F, better readability of 'class of worker' and 'education level'
psub$SEX = as.factor(ifelse(psub$SEX==1,'M','F')) 
psub$SEX = relevel(psub$SEX,'M')
cowmap <- c("Employee of a private for-profit",
            "Private not-for-profit employee",
            "Local government employee",
            "State government employee",
            "Federal government employee",
            "Self-employed not incorporated",
            "Self-employed incorporated")
psub$COW = as.factor(cowmap[psub$COW])
psub$COW = relevel(psub$COW,cowmap[1])
schlmap = c(
  rep("no high school diploma",15),
  "Regular high school diploma",
  "GED or alternative credential",
  "some college credit, no degree",
  "some college credit, no degree",
  "Associate's degree",
  "Bachelor's degree",
  "Master's degree",
  "Professional degree",
  "Doctorate degree")
psub$SCHL = as.factor(schlmap[psub$SCHL])
psub$SCHL = relevel(psub$SCHL,schlmap[1])
dtrain = subset(psub,ORIGRANDGROUP >= 500)
dtest = subset(psub,ORIGRANDGROUP < 500)

#gives the summary of the distribution of the category of work
> summary(dtrain$COW)
Employee of a private for-profit      Federal government employee
423                               21
Local government employee  Private not-for-profit employee
39
Self-employed incorporated
17
State government employee
24
55
Self-employed not incorporated
16

install.packages("XML")
library(XML)
url <- "http://www.repole.com/sun4cast/stats/cfb20130907.xml"
dataprob4 <- xmlToDataFrame(url)
