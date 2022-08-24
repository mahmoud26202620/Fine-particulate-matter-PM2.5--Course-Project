scc<-readRDS("summarySCC_PM25.rds")
Source_Classification<-readRDS("Source_Classification_Code.rds")

Emissions_Baltimore2<-scc%>% group_by(year,type)%>% filter(fips == "24510")%>% summarize(total_e=sum(Emissions))

png(filename = "C:/Users/mahmo/Documents/plot3.png",width = 1300,height=1000)
ggplot(data = Emissions_Baltimore2,aes(year,total_e,col=type))+geom_point()+geom_line()+ggtitle("Total Emissions per year and type in Baltimore")
dev.off()