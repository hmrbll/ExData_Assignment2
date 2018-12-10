#Set file name
datafile <- "summarySCC_PM25.rds"
#Read file
dataset <- readRDS(datafile)
#Subset the data according to needs of question
library(dplyr)
subdata <- dataset %>%
        filter(fips == "24510" & type == "ON-ROAD") %>%
                select(Emissions, year)
#Aggregate total emission by each year
aggdata <- subdata %>%
        group_by(year) %>%
                summarise(sum = sum(Emissions, na.rm = TRUE))
#Plotting
png("plot5.png", width = 480, height = 480)
ggplot(aggdata, aes(year, sum)) +
        geom_line() +
                geom_point(color = "red")
dev.off()