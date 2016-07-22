pollutantmean <- function(directory, pollutant, id = 1:332){
    
    currentFolder <- getwd()

    all_file_list <- list.files(path = paste(currentFolder,"/",directory, sep = "")) # build a list of all files in the folder 
    
    pollutant_vect <- numeric() # use to concatenate pollutant vector from each data
    
    for(i in id){
        
        file_path <- paste(currentFolder,"/",directory,"/", all_file_list[i], sep = "")
        
        my_data <- read.csv(file = file_path, sep = ",") 
        
        pollutant_vect <- c(pollutant_vect, my_data[, pollutant]) # add the pollutant value from current file to temp global vector

    }
    
    experiment_mean <- mean(pollutant_vect, na.rm = TRUE)
    experiment_mean
}