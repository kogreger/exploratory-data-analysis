require(plyr)

# set working directory
setwd("~/Documents/Coursera/Data Science Specialization/Exploratory Data Analysis/exploratory-data-analysis")

# load data from RDS files
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# optimize variable names
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# main question: what are "coal combustion-related sources"?
# -> show all distinct ei.sectors from SCC data (59)
levels(SCC$ei.sector)
# => everything starting with "Fuel Comb" (fuel combustion), 
#    and ending in "Coal"
# filter for relevant SCCs (99)
q4.scc <- SCC[grep("^Fuel Comb .* Coal$", SCC$ei.sector), ]
# remove unnecessary factor levels
q4.scc$scc <- factor(q4.scc$scc)

# summarize all emissions per year for filtered SCCs
q4 <- ddply(NEI[NEI$scc %in% q4.scc$scc, ], ~ year, summarize, 
            total.emissions = sum(emissions))

# create base plot
png(filename = "plot4.png")
plot(q4, type = "b", 
     main = "Sum of Emissions from Coal\nCombustion-Related Sources per Year")
dev.off()