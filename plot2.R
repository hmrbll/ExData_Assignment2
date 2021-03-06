#Set file name
datafile <- "summarySCC_PM25.rds"
#Read file
dataset <- readRDS(datafile)
#Subset the data according to needs of question
library(dplyr)
subdata <- dataset %>%
        filter(fips == "24510") %>%
                select(Emissions, year)
#Aggregate total emission by each year
aggdata <- subdata %>%
        group_by(year) %>%
                summarise(sum = sum(Emissions, na.rm = TRUE))
#Plotting
png("plot2.png", width = 480, height = 480)
with(aggdata, plot(year, sum, type = "l"))
with(aggdata, points(year, sum, col = "red", pch = 19))
dev.off()