#' connect to mongo database and retrieve collection names
#' @import RMongo
#' @import rJava
#' @param db default database is txregnet
#' @export
mongoSource <- function(db="txregnet"){
	con <- mongoDbConnect(db)
        cat("Connection established to",db,"database successfully! \n")
        cat("The collections present on the",db,"are: \n")
        collList = dbShowCollections(con)
        return(collList)
} 
