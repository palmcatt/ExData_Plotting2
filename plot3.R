### PLOT-3 ###

## Load data tables
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# " Baltimore City, Maryland (fips == "24510") "
baltimoreNEI <- subset(NEI, fips == "24510")

## total PM2.5 emissions from in the Baltimore City, Maryland
totalEmissionsBaltimore  <- aggregate(Emissions ~ type * year, baltimoreNEI, sum)
							
## Generate diagram
library(ggplot2)

ggplot(baltimoreNEI,aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat="identity") +
  facet_grid(.~type) + 
  labs(x = "Year", y = "PM2.5 Emissions (Tons)") + 
  labs(title = "Total PM2.5 Emissions from Baltimore City, Maryland [1999-2008]")

#ggsave(filename="plot3.png")

## Construct the plot and save it to a PNG file with a width of 960 pixels and a height of 480 pixels.
dev.copy(png, file = "plot3.png", width=960, height=480)
  
dev.off()
