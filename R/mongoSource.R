#' connect to mongo database and retrieve collection names
#' @import RMongo
#' @import rJava
#' @param dbName character with database name
#' @param host character variable with url
#' @param port port number
#' @export
mongoSource <- function(dbName,host,port){
	con <- mongoDbConnect(dbName=dbName,host=host,port=port)
        cat("Connection established to",dbName,"database successfully! \n")
        cat("The collections present on the",dbName,"are: \n")
        collList = dbShowCollections(con)
        return(collList)
} 
