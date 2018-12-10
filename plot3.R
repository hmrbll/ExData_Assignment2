#Set file name
datafile <- "summarySCC_PM25.rds"
#Read file
dataset <- readRDS(datafile)
library(dplyr)
subdata <- dataset %>%
        filter(fips == "24510") %>%
                select(Emissions, type, year)
#Aggregate total emission by each year
aggdata <- subdata %>%
        group_by(type, year) %>%
                summarise(sum = sum(Emissions, na.rm = TRUE))
#Plotting
png("plot3.png", width = 480, height = 480)
ggplot(aggdata, aes(year, sum)) +
        geom_line(aes(color = type))
dev.off()