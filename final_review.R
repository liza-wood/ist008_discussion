
# -------- WEBSCRAPING AND DATA CLEANING -----------

# Take a look at this record of a melon from the USDA plant repository:
# https://npgsweb.ars-grin.gov/gringlobal/accessiondetail?id=1063116

# 1. Scraping practice
# From the Summary tab: 
## Scrape the Top Name, Amarillo Canario Liso, and assign this to an object called 'name'
## Scale the Received by NPGS, 18 Aug 1987, and assign this to an object called 'date'
# From the Observation tab: 
## Scrape the table embedded in the page
## Put this table into a data frame


# 2. Data cleaning practice
## Name: Remove the part of the name that is inside the parentheses (so name should
## just be Amarillo oro)
## Date: Once you have the date received, convert this into a Date data type in R
## Table: Remove the Availability column


# -------- # DATES AND VISUALIZATION -----------

# 1. Date manipulation
## Here are two vectors, date and temp, but the date vector is not uniformly formatted.
## Use code to manipulate the date vector so that all of the dates are uniform
## Hint: remember the package/date functions we learned, and indexing skills

# 2. Visualization
## Once the dates are uniform, plot the temperatures across months with a line graph
## Change the x axis ticks so that every month is shown


# 3. Data manipulation
## If you have time, separate your date column in your data frame into three columns:
## year, month, and date. Do this using regular expressions. Hint: use the lookaround 
## and anchors section of the stringr cheat sheet to differentiate between day and month


# ----- SCRAPING API AND VISUALIZATION -----

# 1. Reading an API
## Using API from fishwatch, extract the data embedded in the API
## from this URL: "https://www.fishwatch.gov/api/species" 

# 2. Visualization
## A. Choose two continuous variables to plot (or at least, variables that *should* be continuous). 
## Hint: You will actually need to convert these yourself
## Plot these two continuous variables using ggplot() -- you can choose how you
## Would plot it, but be prepared to justify.
## How many NAs are in the data you selected to plot?


## B. Make a categorical plot (count up the values with a bar grpah) of the variable:
## `NOAA Fisheries Region` 
## Let's pretend like we're only interested in fish that are from *only one region*
## So remove the fish from multiple regions (or put another way, keep only the fish 
## exclusively from Alaska, Greater Atlantic, Pacific Islands, Southeast, and West Coast)

## 3. If you have time, think about how you might "clean" this data to better represent
## the fish that are from multiple regions

# ----- REGULAR EXPRESSIONS PRACTICE -----

# Here are some strings to play with
s1 <- c("data@lab.com", "student@ucdavis.edu")
s2 <- "You can call me at (123) 456-7890. (098) 765-4321 also works."
s3 <- "Either https://datalab.ucdavis.edu or http://datalab.ucdavis.edu will take you to the DataLab website."

# s1
## Extract the three parts of the email address: name (e.g. data or students), 
## host (e.g. lab or ucdavis), using regular expressions
## Hint: Use the anchor and look around sections of the cheat sheet
## Another hint: it would be productive to think about how a few different patterns would 
## make the matches below. Start with "brittle" patterns (exact character matches) 
## and generalize to more abstract ones

## s2 
## Extract the two phone numbers, keeping the area code in brackets and the hyphen.
## Next, remove the parentheses around the area code
## Last, assign these two numbers into a new *vector*, then extract only the last 4 digits
## and assign it to a new vector called last_four

## s3
## Extract the url

