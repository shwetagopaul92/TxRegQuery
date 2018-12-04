#'query Footprint data from MongoDB Atlas
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
#' mychrGo="chr17"
#' mystartGo=41196312-500*1000
#' myendGo=41322262+500*1000
#' mycollGo="fSkin_fibro_bicep_R_DS19745_hg19_FP"
#' mydbGo="txregnet"
#' url="mongodb+srv://test:test123!@cluster1-ag7nd.mongodb.net/test"
#' res_fp=getAtlasRangeFp(mychrGo,mystartGo,myendGo,mycollGo,mydbGo,url)
#' res_fp
#' }
#' @export
getAtlasRangeFp<-function(mychr,mystart,myend,url,mycoll,mydb,url){
  require(mongolite)
  require(GenomicRanges)
  my_collection = mongo(collection = mycoll, db = mydb,url=url) # connect
  myquery=paste0('{',
                 '"chr":"',mychr,'",',
                 '"start" : {"$gte":',mystart,'},',
                 '"end" : {"$lte":',myend,'}}')
  res=my_collection$find(myquery)
  myrange=GRanges(res$chr, IRanges(res$start, res$end), mcols=res)
  myrange

}
