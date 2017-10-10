## INTRODUCTION
## Pick three of your favorite books on one of your favorite subjects. At least one of the books should have more than one author. For each book, include the title, authors, and two or three other attributes that you find interesting.
## Take the information that you’ve selected about these three books, and separately create three files which store the book’s information in HTML (using an html table), XML, and JSON formats (e.g. “books.html”, “books.xml”, and “books.json”). To help you better understand the different file structures, I’d prefer that you create each of these files “by hand” unless you’re already very comfortable with the file formats.
## Write R code, using your packages of choice, to load the information from each of the three sources into separate R data frames. Are the three data frames identical?
## Your deliverable is the three source files and the R code. If you can, package your assignment solution up into an .Rmd file and publish to rpubs.com. [This will also require finding a way to make your three text files accessible from the web].

## PREPARE
#### Load required libraries. 
library(XML)
library(R2HTML)
library(jsonlite)
library(RCurl)
library(DT)

## XML
#### Read in the table from the XML file. 
xml_url <- getURL("https://raw.githubusercontent.com/jillenergy/Week-7-Books/master/Books-JCA-xml.xml")
xml_books <- xmlParse(xml_url)
xml_books

#### Use xmlSApply to convert the table to a more readable format in R.
xml_new <- xmlRoot(xml_books)
xmlSApply(xml_new, function(x) xmlSApply(x, xmlValue))

#### Convert XML to a dataframe.
xml_new_df <- data.frame(t(xmlSApply(xml_new, function(x) xmlSApply(x, xmlValue))), row.names = NULL)
datatable(xml_new_df)

## HTML
#### Read in table from the HTML file.
html_url <- getURL("https://raw.githubusercontent.com/jillenergy/Week-7-Books/master/Books-JCA-html.html")
html_books <- readHTMLTable(html_url, header = TRUE)
html_books

#### Convert HTML to a dataframe.
html_books_df <- as.data.frame(html_books)
colnames(html_books_df) <- c("Title", "Author", "Author", "ISBN", "Publisher", "Date Published", "Length_Pages")
datatable(html_books_df)

## JSON
#### Read in table from JSON file. 
json_url <- getURL("https://raw.githubusercontent.com/jillenergy/Week-7-Books/master/Books-JCA-json.json")
json_books <- fromJSON(json_url)
json_books

#### Convert JSON to a dataframe.
json_books_df <- data.frame(json_books$`Business Books Read in 2017`)
datatable(json_books_df)
