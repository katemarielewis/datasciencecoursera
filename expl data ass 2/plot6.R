setwd("C:/Users/kate/Documents/datascience/coursera")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge the NEI and SCC data frames
NEISCC<-merge(NEI, SCC, by="SCC", all.x=TRUE)

#Subset the NEISCC dataset to include only Baltimore data
baltimore<-subset(NEISCC, NEISCC$fips=="24510")
#find the values of SCC.Level.Two column that contains "Vehicle"
neiscc<-grep("Vehicle", baltimore$SCC.Level.Two, value=TRUE)
#subset the merged data frame based on the Short.Name values that contain "Vehicle"
subnei<-subset(baltimore, baltimore$SCC.Level.Two==neiscc)
#Sum the emissions values for each year and then make a data table with the year values
data<-rowsum(subnei$Emissions, subnei$year)
table<-data.frame(c(1999, 2002, 2005, 2008), data[,1])


#Subset the NEISCC dataset to include only LA data
la<-subset(NEISCC, NEISCC$fips=="06037")
#find the values of SCC.Level.Two column that contains "Vehicle"
neiscc2<-grep("Vehicle", la$SCC.Level.Two, value=TRUE)
#subset the merged data frame based on the Short.Name values that contain "Vehicle"
subnei2<-subset(la, la$SCC.Level.Two==neiscc2)
#Sum the emissions values for each year and then make a data table with the year values
data2<-rowsum(subnei2$Emissions, subnei2$year)
table2<-data.frame(c(1999, 2002, 2005, 2008), data2[,1])

#make the tables containing the baltimore values and LA values into a single long data frame
table$place<-c("Baltimore", "Baltimore","Baltimore","Baltimore")
table2$place<-c("LA", "LA", "LA", "LA")
colnames(table)=(c("Year", "Emissions", "Place"))
colnames(table2)=(c("Year", "Emissions", "Place"))
tablecombined<-rbind(table, table2)

library(ggplot2)
#plot data using ggplot and save as PNG file
g<-ggplot(tablecombined, aes(x=tablecombined$Year, y=tablecombined$Emissions, colour=Place))
g<-g+geom_line()
g<-g+xlab("years")
g<-g+ylab("PM2.5 emissions(Tons)")
g<-g+ggtitle("Emissions from motor vehicles in Baltimore and LA 1999-2008")
ggsave(filename="plot6.png")