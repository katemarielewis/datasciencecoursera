#function takes argument 'x', a matrix object that can be inversed and cached
makeCacheMatrix <- function(x = numeric()) {
#initialize member variable m
  m <- NULL
#creates a function 'set' that takes the argument y and set the value of x to y and m to null
#x<<-y and m<<-Null so that x and m may be retrieved from the cache later
set <- function(y) {
    x <<- y
    m <<- NULL
  }
#creates a function 'get' that returns the cached value of x
  get <- function() x
#creates a function that assigns m the function of solve to be later used to invert the matrix
  setCacheMatrix <- function(solve) m <<- solve
#creates a function that returns the cached value of m
  getCacheMatrix <- function() m
  list(set = set, get = get,
       setCacheMatrix = setCacheMatrix,
       getCacheMatrix = getCacheMatrix)
}

#function computes inverse of the matrix returned by makeCacheMatrix. 
#If the inverse matrix alredy exists in the cache it will be returned.
#If the inverse matrix does not already exist then it will be computed.
cacheSolve <- function(x, ...) {
  m <- x$getCacheMatrix()
#checks to see if m is not equal to null and if not will get the cached data
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setCacheMatrix(m)
  m
}
