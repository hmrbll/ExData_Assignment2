#Set file names
datafile <- "summarySCC_PM25.rds"
sources <- "Source_Classification_Code.rds"
#Read files
dataset <- readRDS(datafile)
source_codes <- readRDS(sources)
#Subset the data according to needs of question
subdata_selector <- source_codes %>%
        filter(grepl("Coal", Short.Name ) & grepl("Comb", Short.Name )) %>%
                select(SCC)
subdata_selector <- as.character(subdata_selector[ , 1])
subdata <- dataset %>% 
        filter(SCC %in% subdata_selector) %>%
                select(Emissions, year)
#Aggregate total emission by each year
aggdata <- subdata %>%
        group_by(year) %>%
                summarise(sum = sum(Emissions, na.rm = TRUE))
#Plotting
png("plot4.png", width = 480, height = 480)
with(aggdata, plot(year, sum, type = "l"))
with(aggdata, points(year, sum, col = "red", pch = 19))
dev.off()