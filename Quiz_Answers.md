## Week 4 Quiz

## Question 1

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

"" "15"

"w" "15"

"wgtp" "15"

"15"

### Answer

```
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
destfile <- "Idaho.csv"
setwd("/Users/toniromero/Google Drive/Coursera/1_Data Science - Johns Hopkins/3_Getting and Cleaning Data/Week 4/Quizz")
getwd()
download.file(url, destfile, mode = "w", method = "curl")
idaho_data <- read.csv("Idaho.csv")
varNames <- names(idaho_data)
varNamesSplit <- strsplit(varNames, "wgtp")
varNamesSplit[[123]]

[1] ""   "15"
```

## Question 2

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table

377652.4

387854.4

381668.9

379596.5

### Answer

```
setwd("/Users/toniromero/Google Drive/Coursera/1_Data Science - Johns Hopkins/3_Getting and Cleaning Data/Week 4/Quizz")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
destfile <- "GDP.csv"
download.file(url, destfile, mode = "w", method = "curl")
## Have to skip first 4 lines because contain no data
## Then, there are only 190 rows with data in the GDP column
data <- read.csv(destfile, skip = 4, nrows = 190, stringsAsFactors = FALSE)
## GDP data that we need is in column 5
gdp_data <- data[,5]
## Eliminate commas
clean_gdp_data <- as.numeric(gsub(",", "", gdp_data))
result <- mean(clean_gdp_data, na.rm = TRUE)
result

[1] 377652.4
```

## Question 3

In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

grep("*United",countryNames), 2   

grep("^United",countryNames), 3

grep("United$",countryNames), 3

grep("*United",countryNames), 5

## Answer



```
setwd("/Users/toniromero/Google Drive/Coursera/1_Data Science - Johns Hopkins/3_Getting and Cleaning Data/Week 4/Quizz")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
destfile <- "GDP.csv"
download.file(url, destfile, mode = "w", method = "curl")
## Have to skip first 4 lines because contain no data
## Then, there are only 190 rows with data in the GDP column
data <- read.csv(destfile, skip = 4, nrows = 190, stringsAsFactors = FALSE)
## Country Names data that we need is in column 4
gdp_data <- data[,4]
length(grep("^United", gdp_data))

[1] 3
```

## Question 4

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table

http://data.worldbank.org/data-catalog/ed-stats

16

7

15

13

### Answer

```
setwd("/Users/toniromero/Google Drive/Coursera/1_Data Science - Johns Hopkins/3_Getting and Cleaning Data/Week 4/Quizz")

## Variables for URLs
url_gdp <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url_educational <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

## Destfiles
destfile_gdp <- "GDP.csv"
destfile_educational <- "educational.csv"

## Download files
download.file(url_gdp, destfile_gdp, mode = "w", method = "curl")
download.file(url_educational, destfile_educational, mode = "w", method = "curl")

## Read files
data_educational <- read.csv(destfile_educational)
data_gdp <- read.csv(destfile_gdp, skip = 4, nrows = 190, stringsAsFactors = FALSE)

## Change name of columns to match "CountryCode" after
colnames(data_gdp) <- c("CountryCode", "NA", "ranking", "CountryName", "GDP")

## Merge data by matching "CountryCode" of both tables
merged_data <- merge(data_educational, data_gdp, all = TRUE, by = c("CountryCode"))

## Find the ones with Fiscal Year info available (in Special.Notes column)
fiscal_year <- grepl("fiscal year end", tolower(merged_data[,10]))
june <- grepl("june", tolower(merged_data[,10]))
table(fiscal_year, june)

           june
fiscal_year FALSE TRUE
FALSE   200    3
TRUE     19   13

## Answer is 13 because fiscal_year = TRUE and june = TRUE
```

## Question 5

You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.

```
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
```


library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
How many values were collected in 2012? How many values were collected on Mondays in 2012?

252, 50

251,51

365, 52

250, 47

### Answer

```
install.packages('quantmod') # To install package quantmod
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN", auto.assign=FALSE)
sampleTimes = index(amzn)

## subset for year 2012
year_2012 <- subset(sampleTimes, year(sampleTimes) == 2012)

## How many values were collected in 2012?
length(year_2012)

[1] 250

## How many values were collected on Mondays in 2012?
length(which(wday(year_2012, label = TRUE) == "Mon"))

[1] 47
```
