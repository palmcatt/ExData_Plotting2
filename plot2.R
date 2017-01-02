### PLOT-2 ###

## Load data tables
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# " Baltimore City, Maryland (fips == "24510") "
baltimoreNEI <- subset(NEI, fips == "24510")

## total PM2.5 emissions from in the Baltimore City, Maryland
totalEmissionsBaltimore  <- aggregate(Emissions ~ year, baltimoreNEI, sum)

## Generate diagram
plot(
  totalEmissionsBaltimore$year,
  totalEmissionsBaltimore$Emissions,
  xaxt = "n",
  type = "o",
  xlab = "Year",
  ylab = "PM2.5 Emissions (Tons)",
  main = "Total PM2.5 Emissions from Baltimore City, Maryland [1999-2008]",
)
axis(1, at = totalEmissionsBaltimore$year,)

## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file = "plot2.png", width=480, height=480)
  
dev.off()
