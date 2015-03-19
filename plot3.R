# Exploratory Data Analysis Project 2
# File Name : plot3.R

setwd("c:/Coursera/Exdata-Proj2")
library("plyr")
library("ggplot2")


# Load data
if(!exists("NEI")) {
  NEI <- readRDS("data/summarySCC_PM25.rds")
}

if(!exists("SCC")) {
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

#Process data
data<-transform(NEI,year=factor(year))
data <- data[data$fips=="24510",]
data$Emissions <- data$Emissions/1000
head(data)
sumData <- ddply(data,c("year","type"),summarize,Emissions=sum(Emissions))

#Generate plot1.png
png("plot3.png",width = 640, height = 480)
p <- ggplot(sumData,aes(x=year,y=Emissions)) + geom_point()
p  + facet_grid(.~type)+labs(title="Total PM2.5 Emissions in Baltimore city by Type and Year",
                                           y="Emissions (thousands of tons)", x = "Year")

dev.off()
