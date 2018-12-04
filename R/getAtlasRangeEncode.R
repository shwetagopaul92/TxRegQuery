#'query Encode GRange from MongoDB Atlas
#'@import GenomicRanges
#'@import mongolite
#'@param mychr chromosome
#'@param mystart start position
#'@param myend end position
#'@param mycoll collection name in mongodb
#'@param mydb database name in mongodb
#'@param url character string with connection url to MongoDB Atlas cluster
#'@examples
#'\dontrun{
#' require(GenomicRanges)
#' require(mongolite)
#' mychrGo="chr11"
#' mystartGo=41196312-500*1000
#' myendGo=41322262+500*1000
#' mycollGo = "encode690"
#' mydbGo="encode"
#' url="mongodb+srv://test:test123!@cluster1-ag7nd.mongodb.net/test"
#' res=getAtlasRangeEncode(mychrGo,mystartGo,myendGo,mycollGo,mydbGo,url)
#' res
#' }
#' @export
getAtlasRangeEncode<-function(mychr,mystart,myend,mycoll,mydb,url){
  require(mongolite)
  require(GenomicRanges)
  my_collection = mongo(collection = mycoll, db = mydb, url=url) # connect
  myquery=paste0('{',
                 '"seqnames":"',mychr,'",',
                 '"start" : {"$gte":',mystart,'},',
                 '"end" : {"$lte":',myend,'}}')
  res=my_collection$find(myquery)
  myrange=GRanges(res$seqnames, IRanges(res$start, res$end), mcols=res)
  myrange

}
