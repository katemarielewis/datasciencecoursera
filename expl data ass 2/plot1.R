##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

setwd("C:/Users/kate/Documents/datascience/coursera")
NEI <- readRDS("summarySCC_PM25.rds")
data<-rowsum(NEI$Emissions, NEI$year)
table<-data.frame(c(1999, 2002, 2005, 2008), data[,1])
png(file="plot1.png")
plot1<-plot(table[,1], table[,2], type="b", col="blue", main="Total emissions from PM2.5 in the US from 1999 to 2008", xlab="Year", ylab="PM2.5 emissions(Tons)")
dev.off()