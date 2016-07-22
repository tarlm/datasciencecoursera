corr <- function(directory, threshold = 0){
    
    completed_obs_data <- complete(directory)
    
    sub_completed_obs_data <- subset(completed_obs_data, nobs > threshold)
    sub_ids <- sub_completed_obs_data$id
    correlation <- numeric()
    
    for(i in sub_ids){
        
        my_data <- read.csv(file = paste(directory, "/", formatC(i, width = 3, format = "d", flag = "0"), ".csv" , sep = ""))
        
        compl_data <- subset(my_data, complete.cases(my_data))
        
        correlation <- c(correlation, cor(compl_data$sulfate, compl_data$nitrate))
        
    }
    
    correlation
}