# Caches and solves for the inversion of a matrix

##Caches the inverted matrix

makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
        get <- function() x
        setinv <- function(solve) inv <<- solve
        getinv <- function() inv
        list ( set = set, get = get, setinv = setinv, getinv= getinv)
}


##solves the inverted matrix

cacheSolve <- function(x, ...) {
        inv <- x$getinv()
        if (!is.null(inv)) {
                message("getting cached inverse")
                return(inv)
        }
        data <- x$get
        inv <- solve(data)
        x$setinv(inv)
        inv
}
