#Meeting ID: 952 2430 7254
#Passcode: 896273

# Tuesday discussion: 2-1-22
# ---------------------------------- 

# Things I want to cover (homework hiccups and themes):
## Vector math
## Data types and coercion
## Useful functions
## Indexing with conditionals and NAs -- Q8
## Apply functions
## Q9 order function vs sort
## Conditional: if else vs. for loop -- a "conditional statement" is just the if else part, but because if else control structures are usually not vectorized, they are often pair with for loops to make them work, if they have any kind of fancy stuff going on. 

# ---------------
# Vector math: 
## How would you find the speed (distance per miles) of the vectors below
distance <- c(1,12,80,3,5)
miles <- c(10,50,300,8,15)

speed <- distance/miles
speed
 
c(distance/miles)

c(1/10, 12/50, 80/300)

## What will happen when you use the same solution for vectors of uneven lengths?
distance <- c(distance, 10)
length(distance)
length(miles)

# you get a warning but still a result
speed2 <- distance/miles
speed2
 # How did we get this result? Vector recycling starts back at the beginning of the shorter vector -- this can cause major headaches if you don't realize it happened, so be careful to do vector math on vectors of the same length
distance
miles
speed2

# ---------------
# Data types and coercion
## What is the data type of the vector below? Why?
vector <- c("table", T, F, 40, "40")

# What are the data types in R? character, logical, integers/numeric
# What is a data frame? it is tabular data (vectors of the same length and each vector has the same data type)
# What is a list? It can hold different data types, they can be different length

# Characters/string are the most accepting -- anything can be a character if you put quotation marks around it
typeof(vector)
class(vector)

# Most accepting data types: character > integers > logical
vector2 <- c(1, T, 5)
class(vector2)
typeof(vector2)

sum(1, 5, T)

# ---------------
# Useful functions
cl <- read.csv("../../../ist008_assignments/cl_rentals.csv")
class(cl)

## How long/how many rows?
## nrow for data.frames, usually
nrow(cl) # see how many rows are in a data.frame
nrow(cl$city) # nrow does not want to be given a vector, it wants a data.frame
NROW(cl$city) # apparently this works -- signals to nrow() function that the input is a vector
?nrow

# length for vectors
length(cl) # length wants a vector, not a data.frame
length(cl$city)
?length

# dim() input needs to have at least 2 dimensions (rows and columns)
dim(cl)
dim(cl$city)
?dim

## Count how many NAs?

sum(is.na(cl$city))

# which() function does NOT count them, it just tells you the row number of where NA is TRUE
which(is.na(cl$city))
## But you could use length, then
length(which(is.na(cl$city)))
## Make a table...

# You can also use table to count up the true and false values for is.na()
table(is.na(cl$city))

# And generally if we ask for a table, we want this
table(cl$shp_city)

## Do something *for every column*?
# for loops or apply functions

# ---------------
# Indexing
#cl <- read.csv("cl_rentals.csv")
str(cl)
summary(cl$sqft)
summary(cl$price)
## I want apartments that are greater than 680 square feet but less than 1470

# df[rows,column]
cl[cl$sqft > 680 & cl$price < 1470, c("sqft", "price")]

# Can we "soft code" the value instead of writing it out
?quantile # you need to write the percentage
firstq <- quantile(cl$sqft, .25, na.rm = T)

# can replace 680 with the firstq object
cl[cl$sqft > firstq & cl$price < 1470, c("sqft", "price")]

# how to get rid of nas? -- use !is.na(df$colname) **as its own condition**
cl[!is.na(cl$sqft) & cl$sqft > firstq & cl$price < 1470 & !is.na(cl$price), c("sqft", "price")]

# This will not compute because there are NAs
mean(cl$sqft)
# Make sure you use na.rm = T inside functions that 
mean(cl$sqft, na.rm = T)

# complete cases? this only gives a logical vector as an output -- don't recommend
cl.completecases <- complete.cases(cl)
cl.completecases

# But many of you have come across na.omit(), which looks at complete coases and removes any of the values where complete.cases is FALSE
cl.naomit <- na.omit(cl)
# This shows how dangerous na.omit can be because it takes the data frame from almost 3000 to basically 300 -- so I would NOT USE NA.OMIT unless you are being very careful about what columns you are including
nrow(cl.naomit)

## Now of those apartments, which ones are not in Sacramento
table(cl$shp_city)

# ---------------
# Apply functions
# https://www.guru99.com/r-apply-sapply-tapply.html

## Why does this not work?
sapply(cl, sum) # you cannot get a sum for character columns, so it doens't make sense to apply the sum function across every column

# you could pull out just the numeric columns
str(cl)
cl_numeric <- cl[,c("price", "sqft", "bedrooms", "bathrooms")]

# Then this would ALMOST work, but we get the same issue as we did with the mean() function earlier
sapply(cl_numeric, sum)

# So we can specify the function inside the apply function, kind of like when we write a function, but without the curly brackets. In this case we always have to use the argument x, and sapply knows to make each column of cl_numeric the x value to apply to the sum function
sapply(cl_numeric, function(x) sum(x, na.rm = T))

# Q9: Order and sort
# ---------------
x <- c("order", "in", "this") # we want to print x as "in" "this" "order", so the 2nd, 3rd, then 1st element
y <- c(2,3,1) # we want them to be in this order, and if we use these two vectors we can get the result
x[y]
# BUT, we want to use order, which prints out the location of the items, in order. 
order(y) # so this says 3, 1, 2, meaning that the 3rd element of y (1) should come first, then the 1st element of y (2) comes second, then the 2nd element of y (3) should come third.
# So how do we change y to get the order we want? In other words, if we want the result of order(y) to be 2,3,1, how do we accomplish that?
## Using the what we learned from a few lines of code ago, we can say: if we want 2,3,1, that means meaning that the 2nd element of y  should come first, then the 3rd element of y should comes second, then the 1st element of y should come third.
## For the second element in y to come first, that means we need the second value to have the lowest numner
## For the third element in y to come second, it needs to be second-lowest number
## For the first element in y to come last, it needs to be the highest numner
y <- c(3,1,2) # order returns positions 
# We can check this here:
order(y) # we now have the order to want to order x by
x[order(y)]

# but if we use this logic, these numbers can be anything, as long as they follow the same logic
y <- c(100,1,50)
order(y) # we now have the order to want to order x by
x[order(y)]

