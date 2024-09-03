# Read the CSV file as a dataframe
customer_data <- read.csv("synthetic_customer_data.csv")

# 1) Info Dataframe

# Display the first few rows of the dataframe
head(customer_data)

# Dataframe format
dim(customer_data)

# Info about the dataframe
str(customer_data)

# Statistics from the dataframe
summary(customer_data)

# 2) Data Cleaning

# 2.1) Missing Values

# Checking for missing values
colSums(is.na(customer_data))

# Numerical columns
numerical_columns <- c("Age", "Annual_Income", "Customer_Satisfaction_Score")

# Loop to replace NA values with the median for each column
for (column in numerical_columns) {
  customer_data[[column]][is.na(customer_data[[column]])] <- median(customer_data[[column]], na.rm = TRUE)
}

# Forward fill missing values in the "Purchase_Date" column
customer_data$Purchase_Date <- zoo::na.locf(customer_data$Purchase_Date, na.rm = FALSE)

# Checking for missing values in the entire dataframe
colSums(is.na(customer_data))

# 2.2) Wrong parameters

# Checking unique values in the "Gender" column
unique(customer_data$Gender)

# Replacing the values
# Replacing the values safely using ifelse
customer_data$Gender <- ifelse(customer_data$Gender == "M", "Male",
                               ifelse(customer_data$Gender == "F", "Female", customer_data$Gender))

# Checking if it worked
unique(customer_data$Gender)

# Checking unique values in the "Country" column
# Replacing the values safely using ifelse
# Replacing the values safely using ifelse
customer_data$Country <- ifelse(customer_data$Country == "USA", "United States",
                                ifelse(customer_data$Country == "US", "United States",
                                       ifelse(customer_data$Country == "GER", "Germany",
                                              ifelse(customer_data$Country == "CAN", "Canada",
                                                     customer_data$Country))))

# Checking if it worked
unique(customer_data$Country)

# Checking unique values in the "Favorite_Product_Category" column
unique(customer_data$Favorite_Product_Category)

# Replacing the wrong words
customer_data$Favorite_Product_Category <- gsub("Automtoive", "Automotive", customer_data$Favorite_Product_Category)
customer_data$Favorite_Product_Category <- gsub("Boks", "Books", customer_data$Favorite_Product_Category)
customer_data$Favorite_Product_Category <- gsub("Clthng", "Clothing", customer_data$Favorite_Product_Category)
customer_data$Favorite_Product_Category <- gsub("Toyz", "Toys", customer_data$Favorite_Product_Category)

# Checking if it worked
unique(customer_data$Favorite_Product_Category)

# 2.3) Data Type

# Convert "Age" to integer
customer_data$Age <- as.integer(customer_data$Age)

# Round "Annual_Income" to 2 decimal places
customer_data$Annual_Income <- round(customer_data$Annual_Income, 2)

# Ensure the "Subscription" column is logical
customer_data$Subscription <- as.logical(customer_data$Subscription)

# Convert "Subscription" to a dummy variable
customer_data$Subscription_dummy <- as.integer(customer_data$Subscription)

# Display the first few rows of the dataframe
head(customer_data)

# 3) EDA

# 3.1) Unique counts

# Count occurrences of each unique value in the "Gender" column
gender_counts <- table(customer_data$Gender)
# Display the result
print(gender_counts)

# Count occurrences of each unique value in the "Favorite_Product_Category" column
product_cateogry_counts  <- table(customer_data$Favorite_Product_Category)
# Display the result
print(product_cateogry_counts)

# Count occurrences of each unique value in the "Favorite_Product_Category" column
country_counts  <- table(customer_data$Country)
# Display the result
print(country_counts)

# Convert boolean to string labels
customer_data$Subscription <- ifelse(customer_data$Subscription, "Subscribed", "Not Subscribed")

# Count the occurrences of each label
subscription_counts <- table(customer_data$Subscription)
# Display the result
print(subscription_counts)

# 3.2) Grouped columns
# Purchases by category
product_category_purchases <- aggregate(customer_data$Number_of_Purchases, 
                                        by = list(Category = customer_data$Favorite_Product_Category), 
                                        FUN = sum)

# Rename the columns for clarity
names(product_category_purchases) <- c("Favorite_Product_Category", "Total_Purchases")
# Display the result
print(product_category_purchases)

# Find the category with the maximum number of purchases
max_purchase <- product_category_purchases[which.max(product_category_purchases$Total_Purchases), ]
# Display the result
print(max_purchase)

# Load necessary packages
library(dplyr)
library(tidyr)

# Summarize the total purchases by Gender and Product Category
product_category_gender <- customer_data %>%
  group_by(Gender, Favorite_Product_Category) %>%
  summarise(Total_Purchases = sum(Number_of_Purchases)) %>%
  pivot_wider(names_from = Gender, values_from = Total_Purchases)

# View the result
print(product_category_gender)

# Summing Annual Income by Gender using aggregate()
annual_salary_gender <- aggregate(Annual_Income ~ Gender, data = customer_data, sum)

# View the result
print(annual_salary_gender)

# Count the number of individuals by gender
gender_counts <- table(customer_data$Gender)

# Calculate the mean annual salary by gender
mean_annual_salary_gender <- round(annual_salary_gender$Annual_Income / gender_counts, 2)

# View the result
print(mean_annual_salary_gender)

# Calculate the mean age by gender and round to 2 decimal places
# Calculate the mean age by gender using dplyr and round to 2 decimal places
age_gender <- customer_data %>%
  group_by(Gender) %>%
  summarise(Mean_Age = round(mean(Age), 2))

# View the result
print(age_gender)

# Count the number of subscriptions by Gender using dplyr
subscription_gender_df <- customer_data %>%
  group_by(Gender, Subscription) %>%
  summarise(Count = n())

# View the result
print(subscription_gender_df)
