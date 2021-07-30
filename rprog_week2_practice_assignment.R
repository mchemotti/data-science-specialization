## Coursera Programming in R: Week 2 Practice Assignment ##
## Documented here: https://github.com/rdpeng/practice_assignment/blob/master/Practice_Assignment.pdf ##

# Step 1: Unzip the Data
dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir = "diet_data")

list.files("diet_data")
# [1] "Andy.csv"  "David.csv" "John.csv"  "Mike.csv"  "Steve.csv"

andy <- read.csv("diet_data/Andy.csv")

head(andy)
# Patient.Name Age Weight Day
# 1         Andy  30    140   1
# 2         Andy  30    140   2
# 3         Andy  30    140   3
# 4         Andy  30    139   4
# 5         Andy  30    138   5
# 6         Andy  30    138   6

> length(andy$Day)
# [1] 30
# 30 rows

# Dimensions of the Dataframe
dim(andy)
# [1] 30  4
# This tells use we have 30 rows and 4 columns in andy

# Structure of andy
str(andy)
# 'data.frame':	30 obs. of  4 variables:
# $ Patient.Name: chr  "Andy" "Andy" "Andy" "Andy" ...
# $ Age         : int  30 30 30 30 30 30 30 30 30 30 ...
# $ Weight      : int  140 140 140 139 138 138 138 138 138 138 ...
# $ Day         : int  1 2 3 4 5 6 7 8 9 10 ...

summary(andy)
names(andy)
# [1] "Patient.Name" "Age"          "Weight"       "Day"    
# Column names of andy

# Question 1: What is Andy's starting weight?
# Goal: Subset the data for the "Weight" column:
andy[1, "Weight"]
# [1] 140

# Question 2: What is Andy's final weight on Day 30:
andy[30, "Weight"]
# [1] 135

# Question 3: How to subset the "Weight" column where the data where "Day" is equal to 30?
andy[which(andy$Day == 30), "Weight"]
# OR using the subset()
subset(andy$Weight, andy$Day ==30)
# [1] 135

# Assign Andy's starting and ending weight to vectors:
andy_start <- andy[1, "Weight"]
andy_end <- andy[30, "Weight"]

# Calculate weight difference by subtracting vectors
andy_loss <- andy_start - andy_end
# [1] 5

# list.files() returns the contents of a directory in alphabetical order
files <- list.files("diet_data")
# [1] "Andy.csv"  "David.csv" "John.csv"  "Mike.csv"  "Steve.csv"

# Now that we know the list is in ABC order, can use the number order to subset it
files[1]
# [1] "Andy.csv"

files[3:5]
# [1] "John.csv"  "Mike.csv"  "Steve.csv"

# Quick look at John.csv
read.csv(files[3])
# Error, no file in working directory

# We need the full.names or file path included
files_full <- list.files("diet_data", full.names = TRUE)
files_full
# [1] "diet_data/Andy.csv"  "diet_data/David.csv" "diet_data/John.csv"  "diet_data/Mike.csv" 
# [5] "diet_data/Steve.csv"

head(read.csv(files_full[3]))
# Patient.Name Age Weight Day
# 1         John  22    175   1
# 2         John  22    175   2
# 3         John  22    175   3
# 4         John  22    175   4
# 5         John  22    175   5
# 6         John  22    175   6

# Goal: Create one big data frame with everyone's data in it!
# Using: rbind and a loop.

andy_david <- rbind(andy, read.csv(files_full[2]))
# This appended rows from David.csv to the end of our Andy data frame
# rbind needs 2 arguments: 1st an existing data frame, 2nd what you want to append to it
head(andy_david)
tail(andy_david)

# Question 4: Create a subset of the data frame that shows the 25th day for Andy and David
andy_david[andy_david$Day == 25,]
# Patient.Name Age Weight Day
# 25         Andy  30    135  25
# 55        David  35    203  25

# Another way to subset for day 25
day_25 <- andy_david[which(andy_david$Day == 25),]

# Goal: Append everybody's data to the same data frame
# Using rbind is do-able but not practical with lots of files
# Use: A loop
for (i in 1:5){print(i)}
# [1] 1
# [1] 2
# [1] 3
# [1] 4
# [1] 5

# for (i in 1:5){
#   dat <- rbind(dat, read.csv(files_fill[i]))
# }
# # Error in rbind(dat, read.csv(files_fill[i])) : object 'dat' not found
# You cannot rbind something into a file that doesn't yet exist

# Create an empty data frame called "dat" before running the loop:
dat <- data.frame()
for (i in 1:5){
  dat <- rbind(dat, read.csv(files_full[i]))
}
str(dat)
# 'data.frame':	150 obs. of  4 variables:
#   $ Patient.Name: chr  "Andy" "Andy" "Andy" "Andy" ...
# $ Age         : int  30 30 30 30 30 30 30 30 30 30 ...
# $ Weight      : int  140 140 140 139 138 138 138 138 138 138 ...
# $ Day         : int  1 2 3 4 5 6 7 8 9 10 ...

for (i in 1:5){
  dat2 <- data.frame()
  dat2 <- rbind(dat2, read.csv(files_full[i]))
}
str(dat2)
# Because we put dat2 <- data.frame() inside the loop, dat2 is being rewritten with each pass of the loop

# Question 5: Median weight for all the data?
median(dat$Weight)
# [1] NA
# This happens because some of the values in John are missing/NA
# We need to get rid of those NA's for calculating median

# Goal: Subset for complete.cases() or is.na(),
# OR use an argument in median, na.rm that removes NAs
median(dat$Weight, na.rm = TRUE)
# [1] 190

# Question 6: Median weight of day 30
day_30 <- dat[(dat$Day == 30),]
median(day_30$Weight)
# [1] 192

## Goal: Build a function that will return the median weight of a given day ##
# Step 1: Define the directory
# Step 2: Define the day
# Step 3: Take the median of the subset
# Use: list.files() and rbind()
weightmedian <-
  function(directory, day) {
  files_list <- list.files(directory, full.names = TRUE) # Creates a list of files
  dat <- data.frame() # Creates an empty data frame
  for (i in 1:5) {
    # loops through the files, rbinding them together
    dat <- rbind(dat, read.csv(files_list[i]))
  }
  dat_subset <- dat[which(dat[, "Day"] == day), ] #subsets rows that match "Day"
  median(dat_subset[, "Weight"], na.rm = TRUE) #identifies median weight, removes NAs
  }
# Testing our function: weightmedian()
weightmedian(directory = "diet_data", day = 20)
# [1] 197.5
weightmedian("diet_data", 4)
# [1] 188

# The above concepts for binding data work for smaller datasets
# For a more functional approach to review after more familiar with functions
# Visit http://adv-r.had.co.nz/Functionals.html

# The main issue with the function approach above is that the object inside of loop is growing
# by copying and recopying it. It works, but it will be slow with a lot of data.
# Step 1: Create an empty list
summary(files_full)
# files_full is our input object
tmp <- vector(mode = "list", length = length(files_full))
# temp is our empty list
summary(tmp)
# Step 2: Read in csv files and drop them into tmp
for ( i in seq_along(files_full)) {
  tmp[[i]] <- read.csv(files_full[[i]])
}
str(tmp)
# We just read in each csv file and placed them inside our list
# Now we have 5 elements called tmp, where each element of the list is a data frame containing 1 csv file
# What we just did is functionally identical to using lapply
str(lapply(files_full, read.csv))
# This is the power of the apply family functions
# Don't have to worry about looping
# The apply functions are more expressive, easier to understand what is happening and why

str(tmp[[1]])
head(tmp[[1]][,"Day"])

# Use function called do.call() to combine tmp into a single data frame
output <- do.call(rbind, tmp)
str(output)
# This approach avoids messy copying and recopying of data to build the final data frame