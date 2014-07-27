require(plyr)

# set working directory
setwd("~/Documents/Coursera/Data Science Specialization/Exploratory Data Analysis/exploratory-data-analysis")

# load data from RDS files
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# optimize variable names
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# summarize all emissions per year in Baltimore
q2 <- ddply(NEI[NEI$fips == "24510", ], ~ year, summarize, 
            total.emissions = sum(emissions))

# create base plot
png(filename = "plot2.png")
plot(q2, type = "b", 
     main = "Sum of Emissions per Year, Baltimore")
dev.off()