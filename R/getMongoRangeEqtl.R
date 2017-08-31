#'query eQTL from mongodb
#'@import GenomicRanges
#'@import mongolite
#'@param mychr chromosome
#'@param mystart start position
#'@param myend end position
#'@param mycoll collection name in mongodb
#'@param mydb database name in mongodb
#'@examples
#'\dontrun{
#' require(GenomicRanges)
#' require(mongolite)
#' mychrGo=17
#' mystartGo=41196312-500*1000
#' myendGo=41322262+500*1000
#' mycollGo = "Breast_Mammary_Tissue_Analysis.v6p.all_snpgene_pairs_eQTL"
#' mydbGo="txregnet"
#' res_eqtl=getMongoRangeEqtl(mychrGo,mystartGo,myendGo,mycollGo,mydbGo)
#' res_eqtl
#' }
#' @export
getMongoRangeEqtl<-function(mychr,mystart,myend,mycoll,mydb){
  require(mongolite)
  require(GenomicRanges)
  my_collection = mongo(collection = mycoll, db = mydb) # connect
  myquery=paste0('{',
                 '"snp_chr":',mychr,',',
                 '"snp_pos" : {"$gte":',mystart,'},',
                 '"snp_pos" : {"$lte":',myend,'}}')
  res=my_collection$find(myquery)
  myrange=GRanges(res$snp_chr, IRanges(res$snp_pos, width = 1), mcols=res)
  myrange
}
