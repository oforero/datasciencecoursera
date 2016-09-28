# Sample files from one directory and copy them to another

sampleNumDir <- function(src, tgt, max, percent=0.1) {
  samp_size <- round(max * percent)
  files <- sort(sample.int(max, size = samp_size, replace = FALSE))
  
  for(file in files) {
    srcF = paste(src, as.character(file), sep="/")
    tgtF = paste(tgt, as.character(file), sep="/")
    #print(srcF)
    file.copy(srcF, tgtF, overwrite = FALSE)
  }
  
}

#sampleNumDir("data/en_US_twitter", "data/en_US_twitter_sample-0.1", 2360148)
