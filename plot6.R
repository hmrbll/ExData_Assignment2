#Set file name
datafile <- "summarySCC_PM25.rds"
#Read file
dataset <- readRDS(datafile)
#Subset the data according to needs of question
library(dplyr)
subdata <- dataset %>%
        filter((fips == "24510" | fips == "06037") & type == "ON-ROAD") %>%
                select(fips, Emissions, year)
#Aggregate total emission by each year
aggdata <- subdata %>%
        group_by(fips, year) %>%
                summarise(sum = sum(Emissions, na.rm = TRUE))
aggdata$fips <- gsub("24510", "Baltimore City", aggdata$fips)
aggdata$fips <- gsub("06037", "Los Angeles County", aggdata$fips)
#Plotting
png("plot6.png", width = 480, height = 480)
ggplot(aggdata, aes(year, sum)) +
        geom_line(aes(color = fips))
dev.off()