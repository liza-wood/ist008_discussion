
# QUESTION 10: Write a function that performs a simple math equation 
# with a variable. Run the function substituting the variable with 
# at least three different values by calling it in a loop. For 
# instance, if you write a function for a variable "x", Use a loop 
# call the function for at least three numbers as "x".

# Turning minutes to seconds
## Doing this without any functions or iteration... it takes a lot of 
## typing and is prone to error
10*60
30*60
100*60

## Remember: generic layout of a function
name <- function(argument){
  equation
}

# Writing the minutes to seconds function
## Note: including print is not necessary in this case but can be good practice
min_to_sec <- function(minutes){
  print(minutes*60)
}

# This works if we specify one value for minutes
min_to_sec(minutes = 10)
min_to_sec(minutes = 30)
min_to_sec(minutes = 100)

# Or you can create a vector and run the function with the vector as an argument
minutes_vector <- c(10, 30, 100)
min_to_sec(minutes = minutes_vector)
# So this means that this function is *vectorized* -- no iteration is necessary. 
# But the more complex of coding you get into, you will find that not everything
# is vectorized, so we will write out the loop anyways for practice

## Side note: multiple arguments are possible (I changed this from the class 
## example because the example I came up with off the top of my head was silly)
area_of_rectangle <- function(width, length){
  width*length
}

area_of_rectangle(width = 5, length = 10)

# Iterating through this function with for loops
## First, it can be good to check yourself on what you are feeding in. Is the 
## value of i what you think it is?
for(i in minutes_vector){
  print(i)
}
## Yep, good to go

## Next, iterate/loop through the values in minutes_vector and feed each value 
## of the vector (i) as the argument into the min_to_sec function -- THIS IS 
## GOOD ENOUGH TO ANSWER QUESTION 10!
for(i in minutes_vector){
  min_to_sec(minutes = i)
}

# But a reminder about scoping...
i
# Why does i = 100? Because for loops save only the last value of i -- for 
# loops are not good at saving objects in the global environment (which you 
# can see in the top right tab area). If you want to save outputs from a for 
# loop into the global environment for later use, then you will want to think 
# about assigning the results to a new, empty vector, which we sometimes call a
# return vector.
## Creating a return vector is useful because it helps you do things with that
## object later. You do not need to do this for the homework, but it is 
## important to bookmark and know this exists, because you will want the results
## from your for loop one day

return_vector <- c() # create an empty vector with any name
for(i in minutes_vector){
  result <- min_to_sec(minutes = i) # to really understand the steps, you can 
  # think of this as saving each iteration into an object called result
  return_vector <- rbind(return_vector, result) # then rbind or append the 
  # result to the empty vector (I think of this as stacking the results on 
  # top of each other through every iteration of the loop)
}
return_vector

# Also check out now the value of the object called result:
result
## Again, the for loop saves only the last value of an object assigned in the 
## loop. The only way to get all of the values out is by creating an empty 
## vector outside of the loop and appending or binding the results together.

# rbind vs append? For now they are about the same (and append is actually 
# cleaner), but when working with dataframes you might need to think more 
# critically about this

return_vector <- c()
for(i in minutes_vector){
  result <- min_to_sec(minutes = i)
  return_vector <- append(return_vector, result)
}
return_vector

# you don't actually need the results assignment step, you can put the function
# right into the append function. This is the "sleekest" way, but may be harder 
# to revisit and know what is happening here.
return_vector <- c()
for(i in minutes_vector){
  return_vector <- append(return_vector, min_to_sec(minutes = i))
}
return_vector





