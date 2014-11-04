## Collecting a single indicators from an HDX scraper. 
# Dependencies
library(rjson)
library(RCurl)

# Deploy helper function
onSw <- function(a = F, b = 'tool/') {
  if (a == T) return(b)
  else return("")
}

# Helper functions
source(paste(onSw(), 'code/write_tables.R', sep=""))
source(paste(onSw(), 'code/sw_status.R', sep=""))

indicator_code = 'CHD.FUN.142'
sql_query = paste("select * from value where indID='", indicator_code, "'", sep="")
api_endpoint = 'https://ds-ec2.scraperwiki.com/m3gwddd/yhe8ykk1zhnnf04/sql?q='
q = paste(api_endpoint, sql_query, sep = "")
