setwd("C:/Users/kate/Documents/datascience/coursera")
NEI <- readRDS("summarySCC_PM25.rds")

library(ggplot2)
#Subset the NEI dataset to include only Baltimore data
NEI<-subset(NEI, NEI$fips=="24510")

#Subset the NEI data based on the type-POINT and sum the emissions values for each year
NEIpoint<-subset(NEI, NEI$type=="POINT")
datapoint<-rowsum(NEIpoint$Emissions, NEIpoint$year)
#Subset the NEI data based on the type-NONPOIN and sum the emissions values for each year
NEInonpoint<-subset(NEI, NEI$type=="NONPOINT")
datanonpoint<-rowsum(NEInonpoint$Emissions, NEInonpoint$year)
#Subset the NEI data based on the type-ON-ROAD and sum the emissions values for each year
NEIonroad<-subset(NEI, NEI$type=="ON-ROAD")
dataonroad<-rowsum(NEIonroad$Emissions, NEIonroad$year)
#Subset the NEI data based on the type-NON-ROAD and sum the emissions values for each year
NEInonroad<-subset(NEI, NEI$type=="NON-ROAD")
datanonroad<-rowsum(NEInonroad$Emissions, NEInonroad$year)

#make a data table with the year values and the sum emission values for each type
table<-data.frame(c(1999, 2002, 2005, 2008), datapoint[,1], datanonpoint[,1], dataonroad[,1], datanonroad[,1])
colnames(table)=c("Year", "Point", "Nonpoint", "Onroad", "Nonroad")
#reshape dataframe to long format
table<-reshape(table, varying=c("Point", "Nonpoint", "Onroad", "Nonroad"), v.names="Type", timevar="Emissions", times=c("Point", "Nonpoint", "Onroad", "Nonroad"), new.row.names = 1:16, direction="long")

#plot data using ggplot and save as PNG file
g<-ggplot(table, aes(x=table$Year, y=table$Type, colour=Emissions))
g<-g+geom_line()
g<-g+xlab("years")
g<-g+ylab("PM2.5 emissions(Tons)")
g<-g+ggtitle("Emissions PM2.5 in Baltimore City, Maryland 1999-2008 by type")
ggsave(filename="plot3.png")