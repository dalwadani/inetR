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


out  <- reshape(igmp_stats,
              timevar = c("Scenario","module"),
              idvar = "run",
              direction = "wide")

out <- data.frame(out)

names(out) <- c("run" , "ALM", "Multicast")
out <- out[order(out$run),]
out
str(out )
head(csent)
nrow(csen)
routers  <- droplevels(routers)
levels(routers$module)
clients  <- droplevels(clients)
levels(clients$module)

c0 <- droplevels(c0)
levels(c0$module)
levels(c0$name)

nrow(c0[grepl("udpApp",c0$module),])
nrow(c0)
c0[100,]
head(c0)






















