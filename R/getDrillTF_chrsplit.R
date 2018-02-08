# Data
#Trascription Factor Binding Site Data from
#/udd/rekrg/EpiPANDA/FIMO_results/ScanBedResults/

# TF Files
tfFiles=dir("/udd/reshg/chrfiles_tf/")    #Files are on capecod 
tfDir="/udd/reshg/chrfiles_tf/"
#tfFiles=paste0(tfDir,tfFiles)
#tfFiles[1:10]


# Drill Function
#This function is slightly modified from TxRegQuery
#getDrillTF<-function(mychr, mystart, myend, myfile, myip=myip, myport=8047, workspace="bed"){
  #require(DrillR)
  #require(GenomicRanges)
  #mydrill=rdrill(myip,myport)
  #myquery=paste0("select FILENAME,columns[0] as chr, columns[1] as `start`, columns[2] as `end`, columns[6] as pvalue FROM ",workspace,".`",myfile,"` where columns[1] >= ",mystart," and columns[2] <=",myend," and columns[0]='chr",mychr,"'");
  #myres=rd_query(mydrill,myquery)
  #myres$start=as.numeric(myres$start)
  #myres$end=as.numeric(myres$end)
  #myres$pvalue=as.numeric(myres$pvalue)
  #myres$FILENAME=as.character(myres$FILENAME)
  #myres$chr=as.character(myres$chr)
  #myrange=GRanges(myres$chr, IRanges(myres$start,myres$end ), mcols=myres[,c("FILENAME","pvalue")])
  #return(myrange)
#}

#Batch Function
myf = function(myfile){
  tfDir="/udd/reshg/chrfiles_tf/"
  getDrillTF<-function(mychr, mystart, myend, myfile, myip=myip, myport=8047, workspace="bed"){
  require(DrillR)
  require(GenomicRanges)
  myfile2 = paste0(tfDir,myfile,"/","chr",mychr,".bed")
  mydrill=rdrill(myip,myport)
  myquery=paste0("select FILENAME,columns[0] as chr, columns[1] as `start`, columns[2] as `end`, columns[6] as pvalue FROM ",workspace,".`",myfile2,"` where columns[1] >= ",mystart," and columns[2] <=",myend,"");
  myres=rd_query(mydrill,myquery)
  myres$start=as.numeric(myres$start)
  myres$end=as.numeric(myres$end)
  myres$pvalue=as.numeric(myres$pvalue)
  myres$FILENAME=as.character(myres$FILENAME)
  myres$chr=as.character(myres$chr)
  myrange=GRanges(myres$chr, IRanges(myres$start,myres$end ), mcols=myres[,c("FILENAME","pvalue")])
  return(myrange)
}
  myoff=100*1000
  mystartGo=38077296-myoff
  myendGo=38083884+myoff
  mychrGo=17
  res=getDrillTF(mychrGo,mystartGo,myendGo, myfile)
  return(res)
}


library(BatchJobs)
reg = makeRegistry("checkAllTF_bychr", packages=c("DrillR","GenomicRanges"))
batchMap(reg, myf,tfFiles)
submitJobs(reg=reg, job.delay=function(n,i) runif(1,1,3))
