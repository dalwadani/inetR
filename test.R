require(omnetpp)

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
c0 <- wc[ grepl("Clients\\[0\\]",ignore.case = TRUE,wc$module),]


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






















