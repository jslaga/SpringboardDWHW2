#install and load packages
install.packages( "tidyr")

library(dplyr)
library(tidyr)

##load file into dataframe
titanic_df <- data.frame(read.csv("~/Documents/School/Springboard/DataWranglingHW2/HW2/titanic3.csv"))

## 1: Port of embarkation: Find the missing values and replace them with S. 
titanic_df <- titanic_df %>% mutate(embarked = gsub("^$", "S", embarked))

## 2: Age: Calculate the mean of the Age column and use that value to populate the missing values

##  Think about other ways you could have populated the missing values in the age column. Why would you
## pick any of those over the mean (or not)? 
##  --Missing values could have been populated with NA, however this could lead to a very skewed representation
## of age if there are a lot of missing values. If there are a lot of outliers, median can be better for filling in 
## missing data.
titanic_df <- titanic_df %>% mutate(age = ifelse(is.na(age), trunc((mean(age, na.rm = TRUE))), age))

## 3: Lifeboat: Fill empty slots with 'NA'
titanic_df <- titanic_df %>% mutate(boat = gsub("^$", NA, boat))
                                                                                                                                                     
## 4: Cabin: Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.

## Does it make sense to fill missing cabin numbers with a value?	What does a missing value here mean?
## --A missing value could indicate crew or staff of the ship. Filling in a value for missing values 
## does not make sense to me without further information. Instead I would use the new column to 
## group passengers as needed.

titanic_df <- titanic_df %>% mutate(has_cabin_number = ifelse(cabin == "", 0, 1))

write.csv(refine_df, "~/Documents/School/Springboard/DataWranglingHW2/HW2/titanic_clean.csv")

