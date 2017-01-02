### PLOT-4 ###

## Load data tables
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# " Baltimore City, Maryland (fips == "24510") "
# baltimoreNEI <- subset(NEI, fips == "24510")

## emissions from coal combustion-related sources, across the United States
SCC.comb = SCC[grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE),]
SCC.coal = SCC.comb[grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE),]

## Merge datatables by SCC; get new table by aggregated value
coalEmissions <- merge(x = NEI, y = SCC.coal, by = 'SCC')
totalCoalEmissions <- aggregate(coalEmissions[, 'Emissions'], by=list(coalEmissions$year), sum)
colnames(totalCoalEmissions) <- c('Year', 'Emissions')

## Generate diagram
library(ggplot2)

ggplot(data = totalCoalEmissions, aes(x = Year, y = Emissions)) + 
    geom_line () + 
	geom_point()+
	labs(x = "Year", y = "Coal Combustion-related Emissions (Tons)") + 
	labs(title = "Total emissions from coal combustion-related sources across the United States [1999-2008]")
	
#ggsave(filename="plot4.png")

## Construct the plot and save it to a PNG file with a width of 720 pixels and a height of 480 pixels.
dev.copy(png, file = "plot4.png", width=720, height=480)
  
dev.off()
