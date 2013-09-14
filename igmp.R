require(omnetpp)
require(stringr)
x <- loadDataset("results/*.sca")
sc <- x$scalars[x$scalars$value != 0,]
sc$runid <- NULL
sc$resultkey <- NULL
head(sc)
routers <- sc[ grepl("routers",ignore.case = TRUE,sc$module),]
#clients <- sc[ grepl("Clients",ignore.case = TRUE,sc$module),]

wc <- reshape(routers,
              timevar = "name",
              idvar = c("file","module"),
              direction = "wide")
names(wc)
wc <- data.frame(wc)
names(wc)
wc <- wc[,colSums(is.na(wc))<nrow(wc)]

igmp_stats<- wc[grepl("igmp",wc$module), c("file","module","value.IGMPnumGeneralQueriesRecvSignal.count","value.IGMPnumGeneralQueriesSentSignal.count","value.IGMPnumQueriesRecvSignal.count","value.IGMPnumQueriesSentSignal.count","value.IGMPnumReportsRecvSignal.count")]

names(igmp_stats) <- c("file","module","numGeneralQueriesRecv","numGeneralQueriesSent","numQueriesRecv","numQueriesSent","numReportsRecv")
names(igmp_stats)
igmp_stats <- droplevels(igmp_stats)

levels(igmp_stats$module)

head(igmp_stats)

igmp_stats$Scenario <-gsub("results/","",igmp_stats$file)
igmp_stats$Scenario <-gsub(".sca","",igmp_stats$Scenario)
igmp_stats$run <- as.numeric(str_split_fixed(igmp_stats$Scenario, "-", 2)[,2])
igmp_stats$Scenario <-str_split_fixed(igmp_stats$Scenario, "-", 2)[,1]

igmp_stats$file<-NULL


nrow(igmp_stats)
out <- aggregate(igmp_stats$numGeneralQueriesRecv,by=list(igmp_stats$run, igmp_stats$module),FUN = mean,na.rm = TRUE)
write.table(igmp_stats,file = "igmp.dat",sep = "\t")
igmp_stats <- read.table(file = "igmp.dat",sep = "\t",header = TRUE)
igmp_stats$X <- NULL
igmp_stats$module <-  NULL
igmp_stats$Scenario <-  NULL
str(igmp_stats)
head(igmp_stats)
igmp_stats[,"Group.1"]
igmp_stats <- aggregate(igmp_stats,by = list( igmp_stats$run) ,FUN = sum,na.rm = TRUE)
nrow(igmp_stats)


par(pch=22, col="red") # plotting symbol and color
par(mfrow=c(2,4)) # all plots on one page


      heading = "IGMP States"
        plot(igmp_stats$Group.1, igmp_stats$numQueriesRecv, type="n", main=heading)
lines(igmp_stats$Group.1 , igmp_stats$numReportsRecv, type="o")


igmp_stats[,"numReportsRecv"]









