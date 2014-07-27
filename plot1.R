require(plyr)

# set working directory
setwd("~/Documents/Coursera/Data Science Specialization/Exploratory Data Analysis/exploratory-data-analysis")

# load data from RDS files
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# optimize variable names
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# summarize all emissions per year
q1 <- ddply(NEI, ~ year, summarize, total.emissions = sum(emissions))

# create base plot
png(filename = "plot1.png")
plot(q1, type = "b", 
     main = "Sum of Emissions per Year")
dev.off()