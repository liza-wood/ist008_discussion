#Zoom ID: 92760406499
#Meeting passcode: 357462

# Tuesday discussion: 2-1-22
# ---------------------------------- 
## Small groups: What do you want to cover today?

# Why not load all packages at once?
# Reading in RDS
# Q6: indexing/calling the dataframe
# Q8B and C: same results for different subset methods 
# Writing conditions for Q8 and indexing +1
# Pushing and pulling with git


## Homework with the dogs data
# ---------------------------------- 
## HW Q6. Load the dogs data from the `dogs.rds` file provided in lecture.

# getwd() is like the pwd command in terminal
getwd()
# list.files() like ls command in terminal
list.files()

# get yourself to where you want to be. For the homework this might be somewhere different (i.e. your assignments file). Below I set my working directory to the best_in_show folder to make it easy to access the data, but you might want to set it to somewhere more general like your ist008_assignments fold

#setwd("ist008_working/jan_27/best_in_show/")

# This should read-out what you just set it to
getwd()
# You can check it here
list.files()

# Now I can read in dogs.rds easily. If you set the working directory to somewhere more general, list ist008_assignments, you can do a couple things to get the dogs data. You can copy it into your assignments directory -- that is fine! You can also use an absolute file path (begin with "~/") and write out exactly where you want to find the data
dogs <- readRDS("dogs.rds")

# 8. With the dogs data:
#
#     a. Write the condition to test which dogs need 
#       daily grooming (the result
#        should be a logical vector). Does it contain missing values?

# What does the code below do? Takes us to the grooming column, == is the condition that each element is equal to daily, in quotes because it is a character value
dogs$grooming == "daily"

# Remembering conditions. What would it be for not daily?
## conditions: ==, !=, <, <=
dogs$grooming != "daily"

#     b. Use the condition from part a to get the subset of all rows containing
#        dogs that need daily grooming. How many rows are there?
#

# square brackets when indexing/subsetting data frame: 
daily.grooming <- dogs[dogs$grooming == "daily", c("breed", "grooming")]
daily.grooming
nrow(daily.grooming)
length(daily.grooming) # does not work for data frame rows

# What does the first comma mean? Separates row and columns data[row, column]
# What does the second comma mean? It is in c() function to concatenate the columns we want

# This also works, you do not need to specify columns for the question
daily.grooming2 <- dogs[dogs$grooming == "daily", ]
nrow(daily.grooming2)

# What if we wanted to remove the NAs using conditional subsetting?
no.na <- dogs[!is.na(dogs$grooming) & dogs$grooming == "daily", c("breed", "grooming")]
no.na


#     c. Use the `table` function to compute the number of dogs in each
#        grooming category. You should see a different count than in part b for
#        daily grooming. What do you think is the reason for this difference?

# Compare the differences here (or if you don't have any differences). You need to understand the *why* behind this. If they're different, why? If they're not different, why? If they are different, how would you get them to not be different.
table(dogs$grooming)
nrow(daily.grooming)








