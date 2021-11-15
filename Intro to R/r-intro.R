
# misc. but handy shortcuts ---------------------------------------------
# clear console: ctrl + l
# clear environment: rm(list = ls())
# use the up arrow in the console to access the command history
# use View > Panes to set up your window panes
# to put open and closing parentheses, highlight and then click open parenthesis (works with single and double quotes too)

# R is case sensitive
# separate commands by either ; or a new line
# if a command is incomplete R will give a +


# key terms ---------------------------------------------
# command: a line of code run through the console
# object: a named data structure


# objects ---------------------------------------------
# creating (i.e., assigning) objects requires two pieces of information
# 1. the object name (e.g., x)
# 2. the definition of the object (e.g., 1)

# whenever you assign an object name to something, it saves in your environment
# running nameless commands don't save
1+1 # this will calculate 1+1 but won't save it anywhere

# the following all do the same thing, add 1+1 
# and then save the result as a variable called x
x <<- 1+1
x <- 1+1 
x = 1+1
1+1 -> x 
1+1 ->> x
assign("x", 1+1)

# to print the contents of the object, use the name
x
# to print objects as you define them, surround commands with parentheses
(x <- 2)

# to create a vector (i.e., list) of numbers we use c()
x <- c(1, 2, 3, 4, 5, 6)

# generating lists of common sequences 
# these create a vector of numbers
(x <- seq(from = 1, to = 6)) # sequence 
(x <- 1:6) # another way to sequence

(y <- rep(x = 1, times = 6)) # replication

rep(x = 1, times = 6)
rep(1, 6)
rep(6, 1)
rep(times = 6, x = 1)



# vectors and matrices ---------------------------------------------
# vectors only have one dimension (i.e., "columns")
# matrices have 2 dimensions (i.e., rows & columns)
# to check dimensions
(m1 <- matrix(x, nrow = 2, ncol = 3, byrow = FALSE))
(m1 <- matrix(x, nrow = 2, ncol = 3, byrow = TRUE))
(m2 <- matrix(x, nrow = 6, ncol = 1))
# we can also check the dimensions using dim()
dim(m1)
dim(m2)

# dim() gives the nrow() X ncol()
nrow(m1)
ncol(m1)

nrow(m2)
ncol(m2)

# what happens if we try to find the dim(), nrow(), or ncol() of a vector?
dim(x)
nrow(x)
ncol(x)
# we get a NULL return because there is only one dimension
# length() returns the number of elements in a vector
length(x)

# what happens if we get the length() of a matrix?
length(m1)
length(m2)
# x, m1, m2 all have the same length, because they all were built from x and therefore have the same number of elements

# we can also create a matrix by combining two vectors together
# the vectors just need to have the same length
# two ways to combine, by rows or by columns
(m3 <- cbind(x, y)) # column bind
(m4 <- rbind(x, y)) # row bind

# we can also see the names of our vectors (x & y) appear as column names in m3 and row names in m4
colnames(m3)
rownames(m4)

# to reset column names, we can 
colnames(m3) <- c()
rownames(m4) <- c()


# referencing vectors and matrix elements ---------------------------------------------
# when you reset column and row names, they give you the reference information
m3[, 2] # will give you all rows in the 2nd column of m3
m3[3, ] # will give you all the columns in the 3rd row of m3  
m3[3, 2] # will give you element in the 3rd row, 2nd column

# missing values get flagged as NA with no quotes
# this allows R to recognize and treat NA's in functions
# we might insert an NA into an element
m3[3, 2] <- NA
m3


# characters ---------------------------------------------
# to create a list (i.e., vector) of characters we use c() again, but this use "" to identify characters
c <- c("a", "b", "c", "d", "e", "f")

# we can also replicate characters
c <- rep(x = "v", times = 6)
length(c)

# use paste() to combine character elements
c <- paste(c, 1:6, sep = "")

# as long as the dimensions are the same, we can add this as another column
m5 <- cbind(m3, c)
colnames(m5) <- c()
# notice what happens to the data type when we add a character column to our matrix
# in a matrix elements need to be the same type, so it changes our numbers to be characters as well


# data frames ---------------------------------------------
# if instead made m3 into a data.frame
m3 <- as.data.frame(m3)
# and then added the column we can incorporate different column structures
m6 <- cbind(m3, c)
m6

# to get the structure of any object use str()
str(m6) # we see we're now able incorporate numbers and characters

# we can reference elements the same ways we did in a matrix
m6[3, 2] # will still give us the 3rd row, 2nd column which is our NA
m6[, 2] # will still give us all the rows in the 2nd column which is our NA
# but now with a data frame, we can also reference elements by name using $
m6$V2 # will give us the column named V2
m6$V2[3] # will give us the 3rd element in the column V2, so the same as m6[3, 2]


# re-coding variables
# we might want to change a variable from a character to numeric or factor
m6$V2 <- as.factor(m6$V2)
str(m6)

m6$V2 <- as.character(m6$V2)
str(m6)

m6$V2 <- as.numeric(m6$V2)
str(m6)

# or we might want to re-code based on some conditions
m6$c[m6$c == "v1"] <- 1 # in the variable m6$c re-code all the rows where m6$c == "v1" to be 1
m6$c[m6$c == "v2"] <- 2 # now do the same with 2 - 6
m6$c[m6$c == "v3"] <- 3
m6$c[m6$c == "v4"] <- 4
m6$c[m6$c == "v5"] <- 5
m6$c[m6$c == "v6"] <- 6

m6$c <- as.numeric(m6$c)
str(m6)

# we can also create a new variable when re-coding
m6$V4[m6$V2 == 1] <- 2
m6$V4[is.na(m6$V2) == TRUE] <- 2


# packages ---------------------------------------------
# r is open source so package creation is de-centralized
# anyone can make a package and submit it to be used and downloaded
# here's all the R packages available: https://cran.r-project.org/web/packages/available_packages_by_name.html
# (this is also referred to as the CRAN repository)


# what is a package? 
# a bundle of reusable function(s)

# what's a function?
# an "instruction manual" where you give some inputs and do something with them
# we might create a function for the mean
# to do so we'd need to give it some list of numbers and tell R to add them up and divide by a count of the numbers
# we're going to create an function called "mean_function"
# when we use the function, we need to give it one input, list
# list becomes a temporary object we use to build our instruction manual
mean_function <- function(x) {
  sum(x)/length(x)
      }

mean_function(x = m6$V1)
mean(x = m6$V1) # let's check our work against the mean() function in base R

#now what happens if we try to calculate the mean of m6$V2?
mean(x = m6$V2) # it doesn't give us the mean because we have an NA

# ?function or ??package will give you the function/package documentation
# for example:
?mean

# when we look at the documentation it tells us we need to specify what the function should do with NA's
mean(x = m6$V2, na.rm = TRUE) # now it strips the NA before calculating the mean

# back to packages 
# to install a package use the function install.packages()
# the package names are characters and need to be entered as such
install.packages("psych")
install.packages(c("psych", "ggplot2"))

??psych # will give us the package documentation

# installing packages downloads them but you need to call them to your library in order to use them
# we can start using a package once it's installed but to use functions in it we need to reference the package
# in the package documentation, R tells you how to reference functions e.g.,
psych::describe(m6)
# but we can't just call functions in the package because it's not in our library
describe(m6) # this won't work until we add the psych package to our library

# when we use the library() function we can think of packages like objects and so we no longer need to use "" to reference them 
library(psych)

# now we can use the function without referencing the package
describe(m6)




# code from erics class
predict(mod1, data.frame(house2015 = 300), interval = "predict",level = 0.9)











