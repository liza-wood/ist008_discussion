# ------------------------------ ANNOUNCEMENTS -----------------------
#
# FINALS WEEK OFFICE HOURS -- VIA ZOOM
#        TUESDAY: 9:30-11 AM
#
# HOMEWORK GRADING -- MOST UPDATED GRADES UPLOADED SOON (BY WEDNESDAY)
#
# FINAL EXAM:
# WEB SCRAPING AND STRING PROCESSING
# VISUALIZATION
# DATA CLEANING AND DATA TYPES
#
# --------------------------------------------------------------------

# Meeting ID: 982 1619 5539
# Passcode: 925775
# ------
# Topics:
# regex
# Q1

# Reading in the Poe document
library(tesseract)
img <- "https://datalab.ucdavis.edu/adventures-in-datascience/poe_tell_tale_heart.pdf"
poe <- ocr(img)
poe
print(poe) # read as code and includes \n
cat(poe) # concatenates and interprets code convention to display layout

# ~ 19 minutes in the lecture video can tell you more about print v code convetions
# Quick notes on print v code conventions:
## print convention: looks how it does on the pdf -> layout features (rich text)
## code convention: all the 'features' that modify the text are not applied, but rather written out in-line

class(poe)
typeof(poe)
length(poe)

# Get the 5 pages of Poe into one vector (omit page 1)
## We can't subset here, but this still leaves us with 5 elements 
## (and the goal is just one!)
length(poe[2:6])

# How to get it into one element?
## One way to collapse parts 2-5 from Zoa
results <- c()
for(i in 2:length(poe)){
  pages <- poe[i]
  results <- paste(results, pages)
  #cat(results)
}
# Looks good
length(results)
results

## Using paste without a loop, and the collapse argument
length(paste(poe[2:6])) # not what we want -- paste alone won't *collapse*
?paste # somewhat useless help file
## use the collapse function to tell paste to please mash these up into one
paste(poe[2:length(poe)], collapse = " ")

# Digging deeper into the difference between sep and collapse in paste
## Using sep argument for multiple inputs ("hello" and "world")
## These are two separate object that we want to paste together, separated by a space
paste("Hello", "world", sep = "-")
## collapse doesn't work here, because collapse
paste("Hello", "world", collapse = "-")
## Inputing one object (indexed_poe), which has 5 elements
## The collapse argument pastes these elements together
indexed_poe <- poe[2:length(poe)]
length(indexed_poe)
poe_vec <- paste(indexed_poe, collapse = " ")
length(poe_vec)


# Q5B: Remove the headers

# Take a look
cat(poe_vec)
# Big goal: replace the headers with space, or empty non space: ""
library(stringr)
## Recommend doing this by replacing or removing
str_replace(poe_vec, PATTERN, "")
## Extract can help you identify that you have the right pattern, but it will show you
## *the thing you extracted*, not the text that remainds from the extraction
str_extract(poe_vec, PATTERN)

# What's the pattern?
## Example: The Tell-Tale Heart 95 or 94 EDGAR ALLAN POE
## page number with \\d to represent digit (\d for digit)
## What about 2 digits?

## We trialed a few of these, but important things to remember:
### Spaces matter in regex pattern; you only get one pattern -- to use the | operator
### you have to have it all together in one set of quotes; take a look at the quantifiers
### on the cheat sheet to get specific abot numbers; don't let white spaces trick you
### you can use \\s? to tell regex "maybe there is a space here, maybe there isn't"

## We got this far in class, but THIS WAS NOT FINISHED 
poe_clean <- str_replace_all(poe_vec, "\\d{2}\\s?EDGAR ALLAN POE|The Tell-Tale Heart\\s?\\d{2}", replacement = "")
## We can see that 92 is still there
poe_clean
### Are there any digits in there?
str_detect(poe_clean, "\\d+")
## Which ones?
str_extract(poe_clean, "\\d+")
### What about EDGAR ALLAN POE 
str_detect(poe_clean, "EDGAR ALLAN POE|")
### You could ask it all at once?
str_detect(poe_clean, "The Tell-Tale Heart")
str_extract(poe_clean, "The Tell-Tale Heart")

# Why?
poe_clean
## 92 was a stand alone number (you can see in the text as \n92\n), it was not next to 
## EDGAR ALLEN POE or The Tell-Tale Heart So we need to include that in our pattern. 
## You could use the or symbol and add \\d{2} or you could specify 92, since that is 
## the only culprit. There was also a stand alone The Tell-Tale Heart title

# ** so to finish this question make sure you also remove those added parts









