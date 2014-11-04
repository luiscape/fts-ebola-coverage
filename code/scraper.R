## Collecting a single indicators from an HDX scraper. 
# Dependencies
library(rjson)
library(RCurl)

# Deploy helper function
onSw <- function(a = T, b = 'tool/') {
  if (a == T) return(b)
  else return("")
}

# Helper functions
source(paste(onSw(), 'code/write_tables.R', sep=""))
source(paste(onSw(), 'code/sw_status.R', sep=""))


# Function to get a single indicator value from ScraperWiki
getIndicator <- function(api_endpoint = NULL, indicator_code = NULL) {
  # building sql query
  sql_query = paste("select * from value where indID='", indicator_code, "'", sep="")
  q = paste(api_endpoint, sql_query, sep = "")
  
  # getting and parsing the data
  doc <- fromJSON(getURL(q))
  cat('Fetching data | ')
  for(i in 1:length(doc)) {
   it <- unlist(doc[[i]])
   if(i == 1) output <- it
   else output <- rbind(output, it)
  }
  
  cat('done!\n')
  # done
  return(output)
}

# Data frame with single indicator
data <- getIndicator('https://ds-ec2.scraperwiki.com/m3gwddd/yhe8ykk1zhnnf04/sql?q=', 'CHD.FUN.142')
sub <- as.data.frame(data)
row.names(sub) <- NULL

# cleaning
sub$dsID <- NULL
sub$region <- NULL
sub$is_number <- NULL
sub$source <- NULL
names(sub) <- c('CHD_Indicator_Code', 'Date', 'Value')
sub$Indicator_Name <- 'Ebola Virus Outbreak - Overview of Needs and Requirements (inter-agency plan for Guinea, Liberia, Sierra Leone, Region) (Coverage)'
sub <- sub[sort(sub$Date, decreasing = T), ]


## Writing output
write.csv(sub, paste(onSw(), 'http/fts-ebola-coverage.csv', sep=""), row.names = F)

