
#1. Import the customer data into R using read.csv, read.table etc.
setwd("C:/Users/al325478/Desktop/SASStudyPDfs/r/R_Assignment_Case_Study/Case study 1")
customers<-read.csv("Customers.csv")
View(customers)

#2.Understand the data using different functions like View, head, tail, str, names, nrow, ncol, summary, duplicates, describe etc.
View(customers)
head(customers)
tail(customers)
str(customers)
names(customers)
nrow(customers)
ncol(customers)
summary(customers)
require(psych)
describe(customers)
duplicated(customers)

#3.What is percentage of missing values for customer Value variable?
miss=sum(is.na(customers$Customer.Value))
miss_percent=mean(is.na(customers$Customer.Value))

#4.Create two subsets with unique and duplicate values.
customers_1<-unique(customers)
View(customers_1)
customers_2<-customers[duplicated(customers),]
View(customers_2)

#5. Create data set with list of customers whose customer value greater than 10000.
customers_3<-subset(customers,Customer.Value>10000)
View(customers_3)

# 6. In customer table, create a new variable called "customer value segment" using customer value as follows.
# - High Value Segment - > 25000
# - Medium Value Segment - Between 10000 and 25000
# - Low Value Segment - less than or equal to 10000
customers$customer_val_seg[customers$Customer.Value>25000]<-"High Value Segment"
customers$customer_val_seg[customers$Customer.Value>10000 & customers$Customer.Value<25000 ]<-"Medium Value Segment"
customers$customer_val_seg[customers$Customer.Value<=10000]<-"Low Value Segment"
View(customers)


#9. Calculate percentage of sales by each last city, state and region.
install.packages("dplyr") 
library(dplyr)
x<-na.omit(customers)
options(scipen = 999)
View(x)
gg<- group_by(customers, Last_state,Last_city)
View(gg)
cdata<- summarise(gg, TotalSales=sum(CustomerValue))
customer_360 <- transform(cdata,percentage_sales=TotalSales*100/sum(TotalSales))
View(cdata)

#10. What is the count of customers, average number of purchases and average purchase transaction value by last state and city
x %>% group_by(Last_state,Last_city) %>% summarise(count=sum(as.numeric(Customer.ID)), avg_no_pur=mean(buy.times), avg_pur_tran=(sum(Customer.Value)/count)) 
