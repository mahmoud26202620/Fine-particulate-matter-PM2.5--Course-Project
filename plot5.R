scc<-readRDS("summarySCC_PM25.rds")
Source_Classification<-readRDS("Source_Classification_Code.rds")


Baltimore_vehicle<-subset(scc,scc$fips=="24510"& scc$type == "ON-ROAD")
Baltimore_vehicle_total<-Baltimore_vehicle %>% group_by(year)%>% summarize(total_Emissions=sum(Emissions))

png(filename = "C:/Users/mahmo/Documents/plot5.png",width = 1300,height=1000)
ggplot(data = Baltimore_vehicle_total,aes(year,total_Emissions))+ geom_point() + geom_line()+ylab("Total Emissions")+ggtitle("Baltimore Motor Vehicle Emissions")
dev.off()