# Meeting ID: 929 8941 8770
# Passcode: 090136

# Week 9 Discussion
# ---------------------------

library(httr)
library(jsonlite)
library(rvest)
library(xml2)

# To cover
# ---------------------------
# var path of URL
## URLs look like filepaths, formatted like when we search for files in the command line;
## var/www/adventures-in-data-science/file-names...
## ? can help you query a page in a *dynamic* pages, but you don't have these in *static* pages


# What is Xpath? 
## We want to get 'stuff' out of a file (webpage) ; written in xml, shaped like a tree; xpaths help us find the stuff

# What are the different parts of an Xpath? How are they written?
## parts of the xml we want to identify: tags/elements; attributes; text; comments
## tags/element: such as div, script, p, header, h2
## attributes: such as class, id, name, desc, value
## text: data that we actually want

# Xpath syntax: 
## xml_find_all(xml, "tag[attribute = text]")


# Where in the Swirlz menu html do you want to be pulling from? What are the elements/tags and what are the attributes?

doc <- read_html("https://coffeehouse.ucdavis.edu/stores/swirlzbakery/")
doc

## Start with the highest level tag
div <- xml_find_all(doc, "//div")

## Dig into the class attributes above the items we want (coho-menu but maybe also coho-menu-item-container)
menus <- xml_find_all(div, "//*[@class = 'coho-menu']")
## // means: look anywhere below
## * is a wildcard; any kind of tag or element (so tell xml to look inside all the tags -- divs, ps, headers, etc)
## You can replace wildcard with a more specific tag by naming that tag explicitly. For example:
xml_find_all(div, "//div[@class = 'coho-menu']")

# What's inside these coho-menu divs?
html_text(menus) # looks like we're in the right place
html_text(menus[1]) # looks like menu 1 is baked goods

## One way to double check? I want to pull out the menu headers. By looking at the website, it seems like I want to look at the h2 elements
xml_find_all(doc, "//h2") # These are likely the menu orders

# How to get out the names and values outside of the menu? 
## Note: make sure you use the . to cue you in to start at the argument you start with. Otherwise it starts at the top of the document
menu1.names <- xml_find_all(menus[1], ".//*[@class = 'name']")
html_text(menu1.names)

## Will it start at the top without a .? Yes
names.doc <- xml_find_all(doc, "//*[@class = 'name']")
html_text(names.doc) # This takes all of the names

# Notes we didn't get into class:
## Once you get the names and values for baked goods you can repeat for the other attributes. 
## But, there is some trickiness with the values of the espresso drinks. You'll need to 
## google around how to manipulate the string a bit to remove the $, but be aware that in many
## "pattern" related functions in code, the dollar sign ($) is a special character and needs to
## be "escpaed" by using the pattern "\\$" in stead of the pattern "$" in functions you might
## come across, such as gsub() or str_extract() in the stringr package









