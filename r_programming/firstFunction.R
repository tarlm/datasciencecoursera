add2 <- function(x, y){
    x + y 
}

above10 <- function(x){
    used <- x > 10
    x[used]
}

above <- function(x, n = 10){
    used <- x > n
    x[used]
}

colummnean <- function(y, removeNA = TRUE){
    
    nc <- NCOL(y)
    means <- numeric(nc) 
    
    for (i in 1:nc) {
        means[i] <- mean(y[, i], na.rm = removeNA)
    }
    
    means
}
