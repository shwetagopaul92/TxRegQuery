#' connect to mongo database and retrieve collection names
#' @import RMongo
#' @import rJava
#' @param dbName character with database name  default database is txregnet
#' @param host character variable with url
#' @param port port number
#' @export
mongoSource <- function(dbName,host,port){
	con <- mongoDbConnect(dbName=db,host=url,port=port)
        cat("Connection established to",db,"database successfully! \n")
        cat("The collections present on the",db,"are: \n")
        collList = dbShowCollections(con)
        return(collList)
} 
