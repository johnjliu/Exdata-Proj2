# Exploratory Data Analysis Project 2
# File Name : plot2.R

setwd("c:/Coursera/Exdata-Proj2")
library("plyr")


# Load data
if(!exists("NEI")) {
  NEI <- readRDS("data/summarySCC_PM25.rds")
}

if(!exists("SCC")) {
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

data<-transform(NEI,year=factor(year))
data <- data[data$fips=="24510",]
data$Emissions <- data$Emissions/1000
head(data)
sumData <- ddply(data,c("year"),summarize,Emissions=sum(Emissions))
head(sumData)

#Generate plot1.png
png("plot2.png")
plot(sumData$year,sumData$Emissions,type="n",xlab="Year",ylab="Emissions (thousands of tons)",
     main="Total PM2.5 Emissions in Baltimore City",boxwex=0.05)
lines(sumData$year,sumData$Emissions)
dev.off()
