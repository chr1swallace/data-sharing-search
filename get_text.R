library(data.table)

if(!file.exists("data"))
  system("mkdir ~/scratch/carrots_files && ln -s ~/scratch/carrots_files data")
file="~/rds/rds-cew54-basis/Projects/gwas-sharing/data/Nonsharers_all.tsv"
data=fread(file)
data[,xml:=paste0("https://www.ncbi.nlm.nih.gov/research/bionlp/RESTful/pmcoa.cgi/BioC_xml/",PMID,"/unicode")]
data[,outfile:=paste0(PMID,".xml")]
data[,cmd:=paste0("cd data && wget -nc ",xml," -O ",outfile)]
files_found=list.files("data",full=FALSE,pattern=".xml$")
data[,downloaded:=outfile %in% files_found]
table(data$downloaded)

for(i in which(!data$downloaded)) {
  system(data$cmd[i])
}

## how many files successful?
files_found=list.files("data",full=TRUE,pattern=".xml$")
info=file.info(files_found)
sizes=file.info(files_found)$size
hist(log(sizes+1),breaks=1000)
files_nonempty= sizes > 0
message("found ",length(files_found)," / wanted ",nrow(data))
message("with data ",sum(files_nonempty)," / wanted ",nrow(data))

## library("XML")
## for(i in which(files_nonempty)) {
##   doc <- xmlParse(files_found[i])
## top <- xmlRoot(doc)
## top[["keyword"]]
## xmlValue(top[["start_date"]])
## xmlValue(top[["location"]])

##   df=xmlToDataFrame(nodes=getNodeSet(doc,"//attr"))
##   [c("attrlabl","attrdef","attrtype","attrdomv")]
