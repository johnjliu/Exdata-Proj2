
# Exploratory Data Analysis Project 2
# File Name : plot4.R

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

data <- subset(NEI_SCC, grepl('Coal',NEI_SCC$Short.Name, fixed=TRUE), c("Emissions", "year","type", "Short.Name"))
data<-transform(data,year=factor(year))
data$Emissions <- data$Emissions/1000
plotdata<- aggregate(Emissions ~ year, data, sum)
head(plotdata)

#Generate plot4.png
png("plot4.png")
ggplot(plotdata, aes(x=year, y=Emissions,group=1)) + geom_line(size=1) + 
  geom_point( size=5, shape=21, fill="white") + xlab("Year") + 
  ylab("Emissions (thousands of tons)") + ggtitle("Total United States PM2.5 Coal Emissions")
dev.off()