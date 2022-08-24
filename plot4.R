scc<-readRDS("summarySCC_PM25.rds")
Source_Classification<-readRDS("Source_Classification_Code.rds")

coal <- Source_Classification[grepl("coal", Source_Classification$Short.Name, ignore.case = TRUE),]
coal2 <- scc[scc$SCC %in% coal$SCC,]
totalCoal <- aggregate(Emissions ~ year + type, coal2, sum)

png(filename = "C:/Users/mahmo/Documents/plot4.png",width = 1300,height=1000)
ggplot(totalCoal, aes(year, Emissions, type)) + geom_point() + geom_line()
dev.off()