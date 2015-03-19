# Exploratory Data Analysis Project 2
# File Name : plot1.R

setwd("c:/Coursera/Exdata-Proj2")
library("plyr")


# Load data
if(!exists("NEI")) {
  NEI <- readRDS("data/summarySCC_PM25.rds")
}

if(!exists("SCC")) {
  SCC <- readRDS("data/Source_Classification_Code.rds")
}


#Process data
data<-transform(NEI,year=factor(year))
data$Emissions <- data$Emissions/1000
head(data)
sumData <- ddply(data,c("year"),summarize,Emissions=sum(Emissions))
head(sumData)

#Generate plot1.png
png("plot1.png")
plot(sumData$year,sumData$Emissions,type="p",xlab="Year",ylab="Emissions (thousands of tons)",main="Total US PM2.5 Emissions",boxwex=0.1)
lines(sumData$year,sumData$Emissions)
dev.off()

