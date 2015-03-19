# Exploratory Data Analysis Project 2
# File Name : plot6.R

setwd("c:/Coursera/Exdata-Proj2")
library("plyr")
library("ggplot2")
library(reshape2)


# Load data
if(!exists("NEI")) {
  NEI <- readRDS("data/summarySCC_PM25.rds")
}

if(!exists("SCC")) {
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

#Process data
if(!exists("NEI_SCC")) {
  df <- subset(SCC, select = c("SCC", "Short.Name"))
  NEI_SCC <- merge(NEI, df, by.x="SCC", by.y="SCC", all=TRUE)
}


plotData <- subset(NEI_SCC, (fips == "24510" | fips == "06037") & type =="ON-ROAD", c("Emissions", "year","type", "fips"))
plotData$City <- plotData$fips
plotData$City <- factor(plotData$City, levels=c("06037", "24510"), labels=c("Los Angeles, CA", "Baltimore, MD"))
plotData <- melt(plotData, id=c("year", "City"), measure.vars=c("Emissions"))
plotData <- dcast(plotData, City + year ~ variable, sum)
plotData[2:8,"Change"] <- diff(plotData$Emissions)
plotData[c(1,5),4] <- 0


#Generate plot6.png
png("plot6.png")
ggplot(data=plotData, aes(x=year, y=Change, group=City, color=City)) + geom_line() + 
  geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Change in Emissions (tons)") + 
  ggtitle("Motor Vehicle PM2.5 Emissions Changes: Baltimore vs. LA")
dev.off()