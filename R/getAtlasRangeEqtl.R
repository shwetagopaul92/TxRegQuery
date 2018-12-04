#'query eQTL from MongoDB Atlas
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
#' mychrGo=17
#' mystartGo=41196312-500*1000
#' myendGo=41322262+500*1000
#' mycollGo = "Whole_Blood_allpairs_v7_eQTL"
#' mydbGo="txregnet"
#' url="mongodb+srv://test:test123!@cluster1-ag7nd.mongodb.net/test"
#' res_eqtl=getAtlasRangeEqtl(mychrGo,mystartGo,myendGo,mycollGo,mydbGo,url)
#' res_eqtl
#' }
#' @export
getAtlasRangeEqtl<-function(mychr,mystart,myend,mycoll,mydb,url){
  require(mongolite)
  require(GenomicRanges)
  my_collection = mongo(collection = mycoll, db = mydb, url=url) # connect
  myquery=paste0('{',
                 '"chr":',mychr,',',
                 '"snp_pos" : {"$gte":',mystart,'},',
                 '"snp_pos" : {"$lte":',myend,'}}')
  res=my_collection$find(myquery)
  myrange=GRanges(res$chr, IRanges(res$snp_pos, width = 1), mcols=res)
  myrange
}
