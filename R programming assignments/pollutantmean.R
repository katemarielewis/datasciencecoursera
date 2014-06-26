pollutantmean <- function(directory, pollutant, id = 1:332) {
  files <- as.character(list.files(path=directory))
  data <- data.frame(Date = numeric(0), sulfate = numeric(0), nitrate = numeric(0), ID = numeric(0))
  for(index in id){
    filename = files[index]
    y<-read.csv(paste(directory,"/",filename,sep="",collapse=""))
    data<-rbind(data,y)
    
  }
  mean(data[,pollutant], na.rm = TRUE)
}

#"datascience/coursera/specdata"
