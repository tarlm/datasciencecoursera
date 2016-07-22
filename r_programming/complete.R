complete <- function(directory, id = 1:332){
    currentFolder <- getwd()
    
    all_file_list <- list.files(path = paste(currentFolder,"/",directory, sep = "")) # build a list of all files in the folder 

    #my_id <- numeric()
    nobs <- numeric()
    
    for(i in id){
        
        file_path <- paste(currentFolder,"/",directory,"/", all_file_list[i], sep = "")
        
        my_data <- read.csv(file = file_path, sep = ",") 
        nobs <- c(nobs, sum(complete.cases(my_data)))
        #my_id <- c(my_id, i)
    }
    
    #id <- my_id
    observed_data <- data.frame(id, nobs)
    observed_data
}