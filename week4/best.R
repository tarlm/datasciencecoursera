best <- function(state, outcome) {
    
    bestHospital = character()
    
    
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
    
    ### search for the best ### 
    
    sub_outcome_death_data <- subset(outcome_df, outcome_df$State == state, select = c(2, numCol)) # subset by state keep columns hospital name and outcome
    
    sub_outcome_death_data[, 2] <- as.numeric(sub_outcome_death_data[, 2]) 
    
    sub_outcome_death_data <- sub_outcome_death_data[!is.na(sub_outcome_death_data[, 2]) ,] # Remove NA value observations
    
    ## Return hospital name in that state with lowest 30-day death
    sub_outcome_death_data[order(sub_outcome_death_data[2], sub_outcome_death_data$Hospital.Name), ][1, "Hospital.Name"]
    
    ## rate
}
