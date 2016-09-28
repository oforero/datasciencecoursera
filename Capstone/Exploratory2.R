library(tm)
library(RWeka)
library(RWekajars)
library(SnowballC)

Bigrams <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))

file2Corpus <- function(filename, dir=getwd()) {
  path <- paste(dir, filename, sep="/")
  print(path)
  con <- file(path, open="r", encoding="UTF-8")
  lines <- readLines(con)
  close(con)
  
  corpus <- Corpus(VectorSource(lines))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, content_transformer(tolower))
  
  # Do I want to remove stopwords all together? how do we will predict words like "I am"
  corpus <- tm_map(corpus, removeWords, stopwords)
  
  dict <- corpus
  corpus <- tm_map(corpus, stemDocument)
  corpus <- tm_map(corpus, stemCompletion, dictionary=dict)
  
  #dtm1ngram <- TermDocumentMatrix(corpus)
  #dtm2ngram <- TermDocumentMatrix(corpus, control=list(tokenize = Bigrams))
  return(corpus)
}

#blogs <- file2Corpus("en_US_sample/en_US.blogs.txt")
#news <- file2Corpus("en_US_sample/en_US.news.txt")
twitterC <- file2Corpus("en_US_sample/en_US.twitter.txt")

