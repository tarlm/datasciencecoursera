rankall <- function(outcome, num = "best") {
    
    
    
    # Check the parameters 
    if (outcome != "heart attack" && outcome != "heart failure" && outcome != "pneumonia")
        
        stop("invalid outcome")
    
    if(is.na(as.numeric(num)) && num != "best" && num != "worst" )
        stop("invalid num")
    
    ## Read outcome data
    outcome_df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    
    ## select the colomn to be used
    
    colNumSelector <- function(l_outcome){
        if (l_outcome == "heart attack")
            return(11)
        
        if (l_outcome == "heart failure")
            return(17)
        
        if (l_outcome == "pneumonia")
            return(23)
    }
    
    ## get ranked hospital for specific state and outcome
    
    getRank <- function(df, outcome, state, sort_order=FALSE, numRow ){
        
        numCol <- colNumSelector(outcome)
        
        sub_outcome_death_data <- subset(df, df$State == state, select = c(2, numCol)) # subset by state keep columns hospital name and outcome
        
        sub_outcome_death_data[, 2] <- as.numeric(sub_outcome_death_data[, 2]) 
        
        sub_outcome_death_data <- sub_outcome_death_data[!is.na(sub_outcome_death_data[, 2]) ,] # Remove NA value observations
        
        if(numRow > nrow(sub_outcome_death_data))
            return(NA)
        
        ## Return hospital name in that state with lowest 30-day death
        sub_outcome_death_data[order(sub_outcome_death_data[2], sub_outcome_death_data$Hospital.Name, decreasing = sort_order), ][numRow, "Hospital.Name"]
        
    }
    
    # build result object

    numRow <- 1
    decr <- FALSE
    
    if(num == "worst")
        decr <- TRUE
    
    else if(!is.na(as.numeric(num)))
        numRow <- as.numeric(num)
    
    state <- unique(outcome_df$State)
    state <- sort(state)
    
    hospital <- character()
    
    for (i in 1: length(state)) {
        hospital[i] <- getRank(outcome_df, outcome, state[i], decr, numRow)
        
    }
    
    result_df <- data.frame(hospital, state)
    
    rownames(result_df) <- state
    
    result_df
    
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
}