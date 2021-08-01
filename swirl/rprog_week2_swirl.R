### Practical R Exercises in swirl Part 2 ###
# Goals: 1) Logic, 2) Functions, 3) Dates and Times

library(swirl)
swirl()
## Swirl Lesson 1: Logic ##

# Notes:
# boolean values: TRUE and FALSE
# Logical operators: +, -, *, /, ==, <, >, <= (less-than-or-equal-to), >=, &, &&, OR '|'
# Equality operator: == # Compares if values are equal.
# Inequality operator: != # ! is not

# For & and && operators: 
## if the right and left operands are TRUE, the entire expression is TRUE
## if one is TRUE and one is FALSE, the entrie expression is FALSE
# You can use the & operator to evaluate AND across a vector
# The left operand is recycled across every element of the vector of the right operand
# TRUE & c(TRUE, FALSE, FALSE) is the same as c(TRUE, TRUE, TRUE) & c(TRUE, FALSE, FALSE)

# The && version only evaluates the first member of a vector
# The left operand is only evaluated with the first member of the right operand and the rest aren't evaluated
# TRUE && c(TRUE, FALSE, FALSE)

# The OR '|' operator, evaluates OR across an entire vector
# The OR '||' operator, evaluates only the first member of the vector

# Combining logical operators in arithmetic
# Order of operations: All AND operators are evaluated before OR operators
5 > 8 || 6 != 8 && 4 > 3.9
# First, left and right operands of AND are evaluated
# 6 != 8, 4 > 3.9, therefore both operands are TRUE, so the result 'TRUE && TRUE' is TRUE
# Then, the left operand of OR is eval, 5 is not greater than 8 so the entire expression is FALSE || TRUE
# Since the right operand of this expression is TRUE, the entire expression is TRUE

# isTRUE()

# identical() will return TRUE if the objects are identical

# xor() takes two arguments, exclusive OR
# If one argument evaluates to TRUE and one argument evals to FALSE, then this function will return TRUE, otherwise it will return FALSE
xor(5 == 6, !FALSE)

# which() funtion takes a logical vector as an argument and returns indices of vector that are TRUE
# all() function will return every TRUE element in a logical vector
# any() see if any elements are


## Swirl Lesson 2: Functions ##
# Functions are usually characterized by the name of the function, followed by parentheses.
Sys.Date() # Today's Date based on your computer's environment
mean(c(2, 4, 5))

# First Function:
# You're about to write your first function! Just like you would assign a value 
# to a variable with the assignment operator, you assign functions in the following
# way:
#
# function_name <- function(arg1, arg2){
#	# Manipulate arguments in some way
#	# Return a value
# }
#
# The "variable name" you assign will become the name of your function. arg1 and
# arg2 represent the arguments of your function. You can manipulate the arguments
# you specify within the function. After sourcing the function, you can use the 
# function by typing:
# 
# function_name(value1, value2)
#
# Below we will create a function called boring_function. This function takes
# the argument `x` as input, and returns the value of x without modifying it.
# Delete the pound sign in front of the x to make the function work! Be sure to 
# save this script and type submit() in the console after you make your changes.

boring_function <- function(x) {
  x
}
submit()

# Testing our first function
boring_function("My first function!")
# [1] "My first function!"

# Definitions: 
# Object: Everything that exists in R.
# Function call: Everything that happens in R.

# To see the source code of any function, just type the funciton name without any arguments or parentheses.
boring_function

## GOAL: Replicate the functionality of mean() by creating a function called my_mean(
# You're free to implement the function my_mean however you want, as long as it
# returns the average of all of the numbers in `my_vector`.
#
# Hint #1: sum() returns the sum of a vector.
# 	Ex: sum(c(1, 2, 3)) evaluates to 6
#
# Hint #2: length() returns the size of a vector.
# 	Ex: length(c(1, 2, 3)) evaluates to 3
#
# Hint #3: The mean of all the numbers in a vector is equal to the sum of all of
#		   the numbers in the vector divided by the size of the vector.
#
# Note for those of you feeling super clever: Please do not use the mean()
# function while writing this function. We're trying to teach you something 
# here!
#
# Be sure to save this script and type submit() in the console after you make 
# your changes.

my_mean <- function(my_vector){
  sum(my_vector)/length(my_vector)
}
submit()

my_mean(c(4, 5, 10))
