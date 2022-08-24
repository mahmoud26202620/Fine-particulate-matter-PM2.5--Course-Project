scc<-readRDS("summarySCC_PM25.rds")
Source_Classification<-readRDS("Source_Classification_Code.rds")

Emissions_Baltimore<-scc%>% group_by(year)%>% filter(fips == "24510")%>% summarize(total_e=sum(Emissions))

png(filename = "C:/Users/mahmo/Documents/plot2.png",width = 1300,height=1000)
plot(Emissions_Baltimore$year,Emissions_Baltimore$total_e,type="l",col="blue",main="Total Emissions per year in Baltimore",xlab="Year",ylab="Total Emissions")
dev.off()