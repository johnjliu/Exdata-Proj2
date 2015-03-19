# Exploratory Data Analysis Project 2
# File Name : plot5.R

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

data <- subset(NEI_SCC, fips == "24510" & type =="ON-ROAD", c("Emissions", "year","type"))
data <-transform(data,year=factor(year))

plotdata<- aggregate(Emissions ~ year, data, sum)

#Generate plot5.png
png("plot5.png")
ggplot(plotdata, aes(x=year, y=Emissions,group=1)) + geom_line(size=1) + 
  geom_point( size=5, shape=21, fill="white") + xlab("Year") + ylab("Emissions (tons)") + 
  ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore")
dev.off()