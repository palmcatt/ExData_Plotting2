### PLOT-6 ###

## Load data tables
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# " Baltimore City, Maryland (fips == "24510") " & "emissions from motor vehicle sources"
# " Los Angeles County, California (fips == "06037")" 
baltimoreNEI  <- subset(NEI, fips == "24510" & type == 'ON-ROAD')
LANEI         <- subset(NEI, fips == "06037" & type == 'ON-ROAD')

## emissions from motor vehicle sources, across Baltimore City, Maryland
SCC.vehi = SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE),]

## Merge datatables by SCC; get new table by aggregated value, Baltimore City, Maryland
vehicleEmissionsBA <- merge(x = baltimoreNEI, y = SCC.vehi, by = 'SCC')
totalVehicleEmissionsBA <- aggregate(vehicleEmissionsBA[, 'Emissions'], by=list(vehicleEmissionsBA$year), sum)
colnames(totalVehicleEmissionsBA) <- c('Year', 'Emissions')

## Merge datatables by SCC; get new table by aggregated value, Los Angeles County, California
vehicleEmissionsLA <- merge(x = LANEI, y = SCC.vehi, by = 'SCC')
totalVehicleEmissionsLA <- aggregate(vehicleEmissionsLA[, 'Emissions'], by=list(vehicleEmissionsLA$year), sum)
colnames(totalVehicleEmissionsLA) <- c('Year', 'Emissions')

totalVehicleEmissions <- as.data.frame(rbind(totalVehicleEmissionsLA, totalVehicleEmissionsBA))

## Generate diagram
library(ggplot2)

ggplot(data = totalVehicleEmissions, aes(x = Year, y = Emissions)) + 
    geom_line () + 
	geom_point() +

	labs(x = "Year", y = "Motor vehicle  Emissions (Tons)") + 
	labs(title = "Total emissions from motor vehicle sources, Baltimore City & Los Angeles [1999-2008]")
	
#ggsave(filename="plot6.png")

## Construct the plot and save it to a PNG file with a width of 720 pixels and a height of 480 pixels.
dev.copy(png, file = "plot6.png", width=720, height=480)
  
dev.off()
