setwd("C:/Users/kate/Documents/datascience/coursera")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the NEI dataset to include only Baltimore data
NEI<-subset(NEI, NEI$fips=="24510")

#merge the NEI and SCC data frames
NEISCC<-merge(NEI, SCC, by="SCC", all.x=TRUE)

#find the values of SCC.Level.Two column that contains "Vehicle"
neiscc<-grep("Vehicle", NEISCC$SCC.Level.Two, value=TRUE)
#subset the merged data frame based on the Short.Name values that contain "Vehicle"
subnei<-subset(NEISCC, NEISCC$SCC.Level.Two==neiscc)
#Sum the emissions values for each year and then make a data table with the year values
data<-rowsum(subnei$Emissions, subnei$year)
table<-data.frame(c(1999, 2002, 2005, 2008), data[,1])

#open PNG device, make plot of data and then close device
png(file="plot5.png")
plot5<-plot(table[,1], table[,2], type="b", col="blue", main="Emissions from motor vehicles in Baltimore 1999-2008", xlab="Year", ylab="PM2.5 emissions(Tons)")
dev.off()