setwd("C:/Users/kate/Documents/datascience/coursera")
complete <- function(directory, id = 1:332) {
  added_index<-0
  files <- as.character(list.files(path=directory))
  table<-data.frame(id = numeric(0), nobs = numeric(0))
  for(index in id) {
    filename = files[index]
    data<-read.csv(paste(directory,"/",filename,sep="",collapse=""))
    counts<-0
    for(i in 1:nrow(data)) {
      row <- data[i,]
      if(rowSums(is.na(row))==0) {
        counts<-counts+1
      }
      
    }
    if(counts>0){
      
      added_index<-added_index+1
      table[added_index, ] <- c(index, counts)
      
    }
    
  }
  return(table)
}


corr<-function(directory, threshold=0) {
  files <- as.character(list.files(path=directory))
  listcorrelations<-list()
  for(index in 1:332) {
    completeresult<-complete("specdata", index)
    filename = files[index]
    data<-read.csv(paste(directory,"/",filename,sep="",collapse=""))
    data<-na.omit(data)
    if (completeresult[1,"nobs"]>threshold){
      correlation<-cor(data$sulfate, data$nitrate)
      listcorrelations<-append(listcorrelations, correlation)
    }  
  }
  return(listcorrelations)
}
