scc<-readRDS("summarySCC_PM25.rds")
Source_Classification<-readRDS("Source_Classification_Code.rds")

total_Emissions<-scc%>% group_by(year)%>% summarize(sum_of_Emissions=sum(Emissions))

png(filename = "C:/Users/mahmo/Documents/plot1.png",width = 1300,height=1000)
plot(total_Emissions$year,total_Emissions$sum_of_Emissions,type="l",col="red",main="Total Emissions per year",xlab="Year",ylab="Total Emissions")
dev.off()