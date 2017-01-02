### PLOT-5 ###

## Load data tables
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# " Baltimore City, Maryland (fips == "24510") " & "emissions from motor vehicle sources"
baltimoreNEI <- subset(NEI, fips == "24510" & type == 'ON-ROAD')

## emissions from motor vehicle sources
SCC.vehi = SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE),]


## Merge datatables by SCC; get new table by aggregated value
vehicleEmissions <- merge(x = baltimoreNEI, y = SCC.vehi, by = 'SCC')
totalVehicleEmissions <- aggregate(vehicleEmissions[, 'Emissions'], by=list(vehicleEmissions$year), sum)
colnames(totalVehicleEmissions) <- c('Year', 'Emissions')

## Generate diagram
library(ggplot2)

ggplot(data = totalVehicleEmissions, aes(x = Year, y = Emissions)) + 
    geom_line () + 
	geom_point()+
	labs(x = "Year", y = "Motor vehicle  Emissions (Tons)") + 
	labs(title = "Total emissions from motor vehicle sources across Baltimore City, Maryland [1999-2008]")
	
#ggsave(filename="plot5.png")

## Construct the plot and save it to a PNG file with a width of 720 pixels and a height of 480 pixels.
dev.copy(png, file = "plot5.png", width=720, height=480)
  
dev.off()
