require(plyr)
require(ggplot2)

# set working directory
setwd("~/Documents/Coursera/Data Science Specialization/Exploratory Data Analysis/exploratory-data-analysis")

# load data from RDS files
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# optimize variable names
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# summarize all emissions per year and type in Baltimore
q3 <- ddply(NEI[NEI$fips == "24510", ], c("year", "type"), summarize, 
            total.emissions = sum(emissions))

# create ggplot plot
png(filename = "plot3.png")
qplot(year, total.emissions, data = q3, geom = "line", facets = ~ type, 
      main = "Sum of Emissions per Year and Type, Baltimore")
dev.off()