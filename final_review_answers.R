
# -------- WEBSCRAPING AND DATA CLEANING -----------

# Take a look at this record of a melon from the USDA plant repository:
# https://npgsweb.ars-grin.gov/gringlobal/accessiondetail?id=1063116

# 1. Scraping practice
# From the Summary tab: 
## Scrape the Top Name, Amarillo oro (semilla blanca), and assign this to an object called 'name'
## Scale the Received by NPGS, 18 Aug 1987, and assign this to an object called 'date'
# From the Observation tab: 
## Scrape the table embedded in the page
## Put this table into a data frame

library(xml2)
library(rvest)
page <- read_html("https://npgsweb.ars-grin.gov/gringlobal/accessiondetail?id=1063120")
panel <- xml_find_all(page, "//div[@class = 'panel panel-default']")
panel
name_header <- xml_find_all(panel, ".//div[@id = 'MainContent_ctrlSum_rowTopName']//div[1]")
html_text(name_header)
name <- xml_find_all(panel, ".//div[@id = 'MainContent_ctrlSum_rowTopName']//span")
name <- html_text(name)
name

date_header <- xml_find_all(panel, ".//div[@id = 'MainContent_ctrlSum_rowReceived']//div[1]")
html_text(date_header)
date <- xml_find_all(panel, ".//div[@id = 'MainContent_ctrlSum_rowReceived']//span")
date <- html_text(date)
date

table <- xml_find_all(page, ".//table[@class = 'table table-borderless display']")
table <- data.frame(html_table(table))

# 2. Data cleaning practice
## Name: Remove the part of the name that is inside the parentheses (so name should
## just be Amarillo oro)
## Date: Once you have the date received, convert this into a Date data type in R
## Table: Remove the Availability column
library(stringr)
library(lubridate)
name <- str_remove(name, " \\(.*\\)")
date <- dmy(date)
colnames(table)
ncol(table)
table <- table[, 1:6]

# -------- # DATES AND VISUALIZATION -----------

# 1. Date manipulation
## Here are two vectors, date and temp, but the date vector is not uniformly formatted.
## Use code to manipulate the date vector so that all of the dates are uniform
## Hint: remember the package/date functions we learned, and indexing skills
date <- c("Jan 16 2021", "Apr 21 2021", "Feb 1 2021", "Jun 28 2021", 
          "2021-03-28", "2021-07-22", "2021-08-08", "2021-09-01",
          "10-10-2021 11:20:30", "11-01-2021 03:59:01", "05-31-2021 19:22:48", "12-31-2021 23:59:59")
temp <- c(28, 68, 32, 63, 35, 72, 101, 110, 63, 55, 59, 42)

date1 <- mdy(date[1:4])
date2 <- ymd(date[5:8])
date3 <- mdy_hms(date[9:12])
date3 <- as_date(date3)

date <- as_date(c(date1, date2, date3))
date
class(date)
data <- data.frame(date, temp)
class(data$date)

# 2. Visualization
## Once the dates are uniform, plot the temperatures across months with a line graph
library(ggplot2)
ggplot(data, aes(x = date, y = temp)) + 
  geom_line() 

# 3. Data manipulation
## If you have time, separate your date column in your data frame into three columns:
## year, month, and day. Do this using regular expressions. Hint: use the lookaround 
## and anchors section of the stringr cheat sheet to differentiate between day and month

# Separate this date into three columns: year, month, date *using a regular expression pattern*
# Hint: use the lookaround and anchors section of the stringr cheat sheet to differentiate between day and month
data$date
data$year <- str_extract(data$date, "\\d{4}") # 4 numbers in a row
data$day <- str_extract(data$date, "\\d{2}$") # the last two numbers
data$month <- str_extract(data$date, "(?<=-)\\d{2}(?=-)") # two numbrs that are preceded by a - and followed by a - (these are the "lookaround" regex)

data

# ----- SCRAPING API AND VISUALIZATION -----

# 1. Reading an API
## Using API from fishwatch, extract the data: "https://www.fishwatch.gov/api/species" 
response <- GET("https://www.fishwatch.gov/api/species")
body <- httr::content(response, "text") # be careful! may be masked by another NLP package, can use the :: to tell R, look in the httr package for this
data <- fromJSON(body)

# 2. Visualization
## A. Choose two continuous variables to plot (or at least, variable that *should* be continuous). 
## Hint: You will actually need to convert these yourself
## Plot these two continuous variables using ggplot() -- you can choose how you
## Would plot it, but be prepared to justify.
## How many NAs are in the data you selected to plot?
summary(data) 
View(data)

data$cals <- as.numeric(data$Calories)
data$fats_g <- as.numeric(str_remove_all(data$`Fat, Total`, " g"))

ggplot(data, aes(x = cals, y = fats_g)) +
  geom_point()

## B. Make a categorical plot (count up the values with a bar grpah) of the NOAA 
## Fisheries Region variable. 
## Let's pretend like we're only interested in fish that are from *only one region*
## So remove the fish from multiple regions (or keep only the fish from Alaska, Greater Atlantic, 
## Pacific Islands, Southeast, and West Coast)
table(data$`NOAA Fisheries Region`)

# This is a fancy way of doing it, but we can name all of the regions we want to filter by
single.region <- c("Alaska", "Greater Atlantic", "Pacific Islands", "Southeast", "West Coast")
# Then use the %in% operator within indexing backets to say: we want any row where NOAA Fisheries
# Region is equal to any of the values in the vector called single.region
# Note: you won't have to do this for the final
filtered.data <- data[data$`NOAA Fisheries Region` %in% single.region, ]

ggplot(filtered.data, aes(x = `NOAA Fisheries Region`)) +
  geom_bar()

# ----- REGULAR EXPRESSIONS PRACTICE -----


library(stringr)
s1 <- c("data@lab.com", "student@ucdavis.edu")
s2 <- "You can call me at (123) 456-7890. (098) 765-4321 also works."
s3 <- "Either https://datalab.ucdavis.edu or http://datalab.ucdavis.edu will take you to the DataLab website."

# 1. Picking out the patterns
## s1: extract the three parts of the email address: name (e.g. data or students), 
## host (e.g. lab or ucdavis), using regular expressions
## Hint: Use the anchor and look around sections of the cheat sheet
## Another hint: it would be productive to think about how a few different patterns would 
## make the matches below. Start with "brittle" patterns (exact character matches) 
## and generalize to more abstract ones

str_match(s1, "([^@]+)@(.+)\\.(.+)")
str_extract(s1, "(@(.+))")

## s2: Extract the two phone numbers, keeping the area code in brackets and the hyphen.
## Next, remove the parentheses around the area code
## Last, assign these two numbers into a new *vector*, then extract only the last 4 digits
## and assign it to a new vector called last_four
str_match_all(s2, "(\\([0-9]+\\)).([0-9]+.[0-9]+)")
numbers <- str_extract_all(s2, "(\\([0-9]+\\)).([0-9]+.[0-9]+)")
numbers <- numbers[[1]]
numbers <- str_remove_all(numbers, "\\(|\\)")
# Match only the last four digits
str_extract_all(numbers, "[0-9]{4}")

## s3: Extract the url
str_extract_all(s3, "http[s]?.//.+?(?=\\s)")
