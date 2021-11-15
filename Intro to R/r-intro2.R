

# packages ------------------------------------------------------
# to install a package use the function install.packages()
# the package names are characters and need to be entered as such
install.packages("psych")
install.packages(c("psych", "ggplot2")) # can install multiple packages at a time

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


# i typically start all r files with the following section:

# install & load packages ------------------------------------------------------
#install.packages(c("psych", "ggplot2"))


# load packages 
library(psych)
library(ggplot2)


# working directory ------------------------------------------------------

# when you start reading data into R you want to be aware of the directory you're in
getwd() # get working directory
setwd("/Users/bah17005/Dropbox/Intro to R") # set working directory

# read in data set
# since we know our working directory we don't need to specify the path
data <- read.csv("approval_polllist.csv", header = TRUE) # headers = TRUE uses row 1 to set column names

# alternatively we can point to a direct path
# e.g., a file outside of our working directory
# also mac users use / for paths while windows use \
data <- read.csv("/Users/bah17005/Dropbox/Intro to R/approval_polllist.csv", header = TRUE)


# check our data ------------------------------------------------------
View(data)

names(data)
colnames(data)

# to delete an object
rm(object)

# show a sample of data
head(data) # default shows the first 6 rows but we can change that
head(data, n = 10)

# we can do the same but with the last 6 rows
tail(data) 
tail(data, n = 10)

# this is also the same as:
data[1:6, ]
# and
data[1823:1828, ]


# set up data ------------------------------------------------------
# re-coding variables
# want to create one variable with 2 groups and another with 3
table(data$population)

# 2 groups
data$pop2[data$population == "a"] <- 0
data$pop2[data$population == "lv"] <- 1
data$pop2[data$population == "rv"] <- 1
data$pop2[data$population == "v"] <- 1

# 3 groups
data$pop3[data$population == "a"] <- 0
data$pop3[data$population == "lv"] <- 1/2
data$pop3[data$population == "rv"] <- -1/2
data$pop3[data$population == "v"] <- -1/2

# creating subsets of each group
data[1, ]


sub_a1 <- data[which(data$pop2==0), ] # variable with 2 groups, group 1
sub_a2 <- data[which(data$pop2==1), ] # variable with 2 groups, group 2

sub_b1 <- data[which(data$pop3==0), ] # variable with 3 groups, group 1
sub_b2 <- data[which(data$pop3==1/2), ] # variable with 3 groups, group 2
sub_b3 <- data[which(data$pop3==-1/2), ] # variable with 3 groups, group 3

ggplot() +
  geom_density(aes(x = sub_a1$approve), na.rm=TRUE, color="#660066") +
  geom_density(aes(x = sub_a2$approve), na.rm=TRUE, color="#D11149") +
  labs(x = "Approval Rate", y = "Density", title= "") 

ggplot() +
  geom_density(aes(x = sub_b1$approve), na.rm=TRUE, color="#660066") +
  geom_density(aes(x = sub_b2$approve), na.rm=TRUE, color="#D11149") +
  geom_density(aes(x = sub_b3$approve), na.rm=TRUE, color="#FF634D") +
  labs(x = "Approval Rate", y = "Density", title= "") 


# t-test vs anova with 2 groups
# is group 1 different than group 2 in their approval ratings?

# t-test
tt_a2 <- t.test(approve ~ pop2, data = data)
tt_a2

t <- tt_a2$statistic # grabs the t value

mean(sub_a1$approve)
mean(sub_a2$approve)


# anova
aov_a2 <- aov(approve ~ pop2, data = data)
summary(aov_a2)

f <-  summary(aov_a2)[[1]][1,4] # grabs the f value from summary output

# f = t*t
f
t*t


# regression
lm_a2 <- lm(approve ~ pop2, data = data)
summary(lm_a2)

# t here  = -5.874
mean(sub_a1$approve) - mean(sub_a2$approve)


# anova with 3 groups
# are the 3 groups different?
aov_a3 <- aov(approve ~ pop3, data = data)
summary(aov_a3)

pairwise.t.test(data$approve, data$pop3)


# now lets recode again to look into these pairwise comparisons
data$pop3d1[data$pop3 == 0] <- 1
data$pop3d1[data$pop3 == 1/2] <- 2
data$pop3d1[data$pop3 == -1/2] <- NA

data$pop3d2[data$pop3 == 0] <- NA
data$pop3d2[data$pop3 == 1/2] <- 2
data$pop3d2[data$pop3 == -1/2] <- 3

data$pop3d3[data$pop3 == 0] <- 1
data$pop3d3[data$pop3 == 1/2] <- NA
data$pop3d3[data$pop3 == -1/2] <- 3


t.test(approve ~ pop3d1, data = data)
t.test(approve ~ pop3d2, data = data)
t.test(approve ~ pop3d3, data = data)

# is group 1 different from group 2?
# is group 2 different from group 3?
# is group 1 different from group 3?


# create a new csv file
write.csv(x = sub_a1, file = "subset.csv")

















