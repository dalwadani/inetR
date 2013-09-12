require(omnetpp)
require(stringr)
x <- loadDataset("results/*.sca")
sc <- x$scalars[x$scalars$value != 0,]
sc$runid <- NULL
sc$resultkey <- NULL
head(sc)
routers <- sc[ grepl("routers",ignore.case = TRUE,sc$module),]
clients <- sc[ grepl("Clients",ignore.case = TRUE,sc$module),]

wc <- reshape(clients,
              timevar = "name",
              idvar = c("file","module"),
              direction = "wide")
names(wc)
head(wc)
wc[1,] 
c0 <- wc[ grepl("Clients\\[0\\]",ignore.case = TRUE,wc$module),]
c0 <- data.frame(c0)
names(c0)
head(c0)
c0[1,] 

c0 <- c0[,colSums(is.na(c0))<nrow(c0)]
c0[1,"value.sentPk.count"]

c0[(c0$value.sentPk.count  >  1),]
csent <- c0[, c("file","module","value.sentPk.count")]
csent <- c0[, c("file","module","value.IGMPnumQueriesRecvSignal.count")]
csent <- csent[!is.na( csent$value.IGMPnumQueriesRecvSignal.count),]
csent <- csent[grepl("udpApp",csent$module),]
csent$module <- NULL
csent$Scenario <-gsub("results/","",csent$file)
csent$Scenario <-gsub(".sca","",csent$Scenario)
csent$run <- as.numeric(str_split_fixed(csent$Scenario, "-", 2)[,2])
csent$Scenario <-str_split_fixed(csent$Scenario, "-", 2)[,1]

csent$file<-NULL
out  <- reshape(csent,
              timevar = "Scenario",
              idvar = "run",
              direction = "wide")

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






















