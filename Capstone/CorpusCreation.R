library(tm)
library(tm.plugin.dc)

buildCorpusFrom <- function(dir, base=getwd()) {
  stD <- paste0(base, "/", dir, "_ST")
  src <- paste0(base, "/", dir)
  
  if(! file.exists(stD)) {
    dir.create(stD)
  }
  
  st <- DStorage(type="LFS", stD)
  src <- DirSource(src)
  
  corpus <- DCorpus(src)
  return(corpus)
}

basicPreProcessing <- function(corpus) {
  corpus <- tm_map (corpus, removePunctuation)
  corpus <- tm_map (corpus, removeNumbers)
  corpus <- tm_map (corpus, stripWhitespace)
  return(corpus)
}

removeStopWords <- function(corpus) {
  corpus <- tm_map (corpus, removeWords, stopwords("english"))
  return(corpus)  
}

stemCorpus <- function(corpus) {
  dict <- corpus
  corpus <- tm_map (corpus, stemDocument, language = "english")
 
  corpusC <- stemCompletion(corpus, dict, type = "prevalent")

  return(list(corpus=corpusC, stemedCorpus=corpus, dictionary=dict))
}


buildTDM <- function(corpus, spThresold=0.05) {
  tdm <- TermDocumentMatrix(corpus, control = list(minWordLength = 3))
  tdm <- removeSparseTerms(tdm, 0.2)
  return(tdm)
}