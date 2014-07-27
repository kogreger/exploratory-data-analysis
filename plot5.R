require(plyr)

# set working directory
setwd("~/Documents/Coursera/Data Science Specialization/Exploratory Data Analysis/exploratory-data-analysis")

# load data from RDS files
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# optimize variable names
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# main question: what are "motor vehicle sources"?
# -> show all distinct ei.sectors from SCC data (59)
levels(SCC$ei.sector)
# => everything starting with "Mobile - On-Road", 
#    and ending in "Vehicles" (1,138)
# filter for relevant SCCs
q5.scc <- SCC[grep("^Mobile - On-Road .* Vehicles$", SCC$ei.sector), ]
# remove unnecessary factor levels
q5.scc$scc <- factor(q5.scc$scc)

# summarize all emissions per year for filtered SCCs in Baltimore
q5 <- ddply(NEI[NEI$scc %in% q5.scc$scc & NEI$fips == "24510", ], ~ year, 
            summarize, 
            total.emissions = sum(emissions))

# create base plot
png(filename = "plot5.png")
plot(q5, type = "b", 
     main = "Sum of Emissions from Motor Vehicle\nSources per Year in Baltimore")
dev.off()