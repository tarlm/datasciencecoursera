rankhospital <- function(state, outcome, num = "best") {
    
    result = character()
    
    ## call best function for num = best
    if(num ==  "best"){
        source("best.R")
        result <- best(state, outcome)
        return(result)
    }
    
    ## Read outcome data
    outcome_df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    
    ## Check that state and outcome are valid
    
    if(!is.element(state, outcome_df$State))
        
        stop("invalid state")
    
    if (outcome != "heart attack" && outcome != "heart failure" && outcome != "pneumonia")
        
        stop("invalid outcome")
    
    
    ## select the colomn to be used
    colNumSelector <- function(my_outcome){
        if (outcome == "heart attack")
            return(11)
        
        if (outcome == "heart failure")
            return(17)
        
        if (outcome == "pneumonia")
            return(23)
    }
    
    numCol = colNumSelector(outcome)
    
    
    ### Return hospital name in that state with the given rank
    
    sub_outcome_death_data <- subset(outcome_df, outcome_df$State == state, select = c(2, numCol)) # subset by state keep columns hospital name and outcome
    
    ## If the num is larger than the number of hospitals in that state, or num is character diferent from "worst" and "best" then the function should return NA
    num_numeric <- as.numeric(num)
    
    if((!is.na(num_numeric) && num_numeric > nrow(sub_outcome_death_data)) || (is.na(num_numeric) && num != "worst"))
        
        return(NA)
    
    if(num == "worst" || is.numeric(num_numeric)) {
        nb_row <- numeric()
        
        sub_outcome_death_data[, 2] <- as.numeric(sub_outcome_death_data[, 2]) # convert outcome in numeric
        
        sub_outcome_death_data <- sub_outcome_death_data[!is.na(sub_outcome_death_data[, 2]) ,] # Remove NA value observations
        
        if(num == "worst"){
            nb_row <- nrow(sub_outcome_death_data)
        }else{
            nb_row <- num_numeric
        }
        
        sub_outcome_death_data[order(sub_outcome_death_data[2], sub_outcome_death_data$Hospital.Name), ][nb_row, "Hospital.Name"]
        
    }   
    
    ## 30-day death rate
}