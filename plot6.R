
scc<-readRDS("summarySCC_PM25.rds")
Source_Classification<-readRDS("Source_Classification_Code.rds")


compared <-subset(scc, scc$fips %in% c("24510", "06037") & scc$type == "ON-ROAD")
compared_total<-compared %>% group_by(year,fips) %>% summarize(total_Emissions=sum(Emissions))

png(filename = "C:/Users/mahmo/Documents/plot6.png",width = 1300,height=1000)
ggplot(data = compared_total,aes(year,total_Emissions,col=fips))+ geom_point() + geom_line()+ylab("Total Emissions")+ggtitle("Baltimore vs Los Angeles County Motor Vehicle Emissions")+ scale_colour_discrete(name = "Location", labels = c("Los Angeles County", "Baltimore"))

dev.off()