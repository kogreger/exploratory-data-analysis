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

# main question: what are "motor vehicle sources"?
# -> show all distinct ei.sectors from SCC data (59)
levels(SCC$ei.sector)
# => everything starting with "Mobile - On-Road", 
#    and ending in "Vehicles" (1,138)
# filter for relevant SCCs
q6.scc <- SCC[grep("^Mobile - On-Road .* Vehicles$", SCC$ei.sector), ]
# remove unnecessary factor levels
q6.scc$scc <- factor(q6.scc$scc)

# summarize all emissions per year for filtered SCCs in Baltimore and LA County
q6 <- ddply(NEI[NEI$scc %in% q5.scc$scc & 
                    (NEI$fips == "24510" | NEI$fips == "06037"), ], 
            c("year", "fips"), 
            summarize, 
            total.emissions = sum(emissions))

# create ggplot plot
png(filename = "plot6.png")
qplot(year, total.emissions, data = q6, geom = "line", facets = ~ fips, 
      main = "Sum of Emissions from Motor Vehicle Sources per Year\nin Los Angeles County (left) and Baltimore (right)")
dev.off()