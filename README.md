# Fine-particulate-matter-PM2.5--Course-Project
This project is part of pre-graduate Assignment of "Data Science: Foundations using R Specialization" course

## Abstract

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

## Dataset
**- Dataset file :**

https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

**Descriptions of the variables :**

**fips:** A five-digit number (represented as a string) indicating the U.S. county

**SCC:** The name of the source as indicated by a digit string (see source code classification table)

**Pollutant:** A string indicating the pollutant

**Emissions:** Amount of PM2.5 emitted, in tons

**type:** The type of source (point, non-point, on-road, or non-road)

**year:** The year of emissions recorded

The main core of the project to answer the following 6 questions :

**1** Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

**2** Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510"|}fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

**3** Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

**4** Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

**5** How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

**6** Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

**Reading the data**

```
scc<-readRDS("summarySCC_PM25.rds")
Source_Classification<-readRDS("Source_Classification_Code.rds")
```

**Answering the first question**

Total emissions by year

```
total_Emissions<-scc%>% group_by(year)%>% summarize(sum_of_Emissions=sum(Emissions))
```

plotting the  Total emissions by year and save the graph at the PNG file called  "plot1"

```
png(filename = "C:/Users/mahmo/Documents/plot1.png",width = 1300,height=1000)
plot(total_Emissions$year,total_Emissions$sum_of_Emissions,type="l",col="red",main="Total Emissions per year",xlab="Year",ylab="Total Emissions")
dev.off()
```

![plot1](https://user-images.githubusercontent.com/41892582/186330144-87123872-655b-435d-9211-bdad1e9b2b95.png)

**Answering the second question**

Total emissions by year at Baltimore

```
Emissions_Baltimore<-scc%>% group_by(year)%>% filter(fips == "24510")%>% summarize(total_e=sum(Emissions))
```

plotting the  Total emissions by year at Baltimore and save the graph at the PNG file called  "plot2"

```
png(filename = "C:/Users/mahmo/Documents/plot2.png",width = 1300,height=1000)
plot(Emissions_Baltimore$year,Emissions_Baltimore$total_e,type="l",col="blue",main="Total Emissions per year in Baltimore",xlab="Year",ylab="Total Emissions")
dev.off()
```

![plot2](https://user-images.githubusercontent.com/41892582/186330787-20589cc7-3093-4ec3-a09d-87b897d63f5c.png)

**Answering the third question**

isolating the Baltimore data

```
Emissions_Baltimore2<-scc%>% group_by(year,type)%>% filter(fips == "24510")%>% summarize(total_e=sum(Emissions))
```
plotting the  Total emissions by year and type at Baltimore and save the graph at the PNG file called  "plot2"

```
png(filename = "C:/Users/mahmo/Documents/plot3.png",width = 1300,height=1000)
ggplot(data = Emissions_Baltimore2,aes(year,total_e,col=type))+geom_point()+geom_line()+ggtitle("Total Emissions per year and type in Baltimore")
dev.off()
```
![plot3](https://user-images.githubusercontent.com/41892582/186331354-d3f4b6a6-5382-4dfc-ab32-2f66294cea6a.png)

**Answering the fourth question**

```
coal <- Source_Classification[grepl("coal", Source_Classification$Short.Name, ignore.case = TRUE),]
coal2 <- scc[scc$SCC %in% coal$SCC,]
totalCoal <- aggregate(Emissions ~ year + type, coal2, sum)
```

```
png(filename = "C:/Users/mahmo/Documents/plot4.png",width = 1300,height=1000)
ggplot(totalCoal, aes(year, Emissions, type)) + geom_point() + geom_line()
dev.off()
```
![plot4](https://user-images.githubusercontent.com/41892582/186331694-d7188ed7-e605-4ddf-8053-bd46d5262858.png)

**Answering the fifth question**

```
Baltimore_vehicle<-subset(scc,scc$fips=="24510"& scc$type == "ON-ROAD")
Baltimore_vehicle_total<-Baltimore_vehicle %>% group_by(year)%>% summarize(total_Emissions=sum(Emissions))
```

```
png(filename = "C:/Users/mahmo/Documents/plot5.png",width = 1300,height=1000)
ggplot(data = Baltimore_vehicle_total,aes(year,total_Emissions))+ geom_point() + geom_line()+ylab("Total Emissions")+ggtitle("Baltimore Motor Vehicle Emissions")
dev.off()
```
![plot5](https://user-images.githubusercontent.com/41892582/186331838-4e578693-6c79-4e3a-8359-6b2a088c5684.png)

**Answering the sixth question**

```
compared <-subset(scc, scc$fips %in% c("24510", "06037") & scc$type == "ON-ROAD")
compared_total<-compared %>% group_by(year,fips) %>% summarize(total_Emissions=sum(Emissions))
```

```
png(filename = "C:/Users/mahmo/Documents/plot6.png",width = 1300,height=1000)
ggplot(data = compared_total,aes(year,total_Emissions,col=fips))+ geom_point() + geom_line()+ylab("Total Emissions")+ggtitle("Baltimore vs Los Angeles County Motor Vehicle Emissions")+ scale_colour_discrete(name = "Location", labels = c("Los Angeles County", "Baltimore"))
dev.off()
```
![plot6](https://user-images.githubusercontent.com/41892582/186331986-d0637e6a-637c-495d-854a-c9c05391acf3.png)
