library(tm)
library(wordcloud)

# bw <- readLines("en_US_sample/words.blogs.txt")
# bC <- Corpus(VectorSource(bw))
# bC <- tm_map(bC, removeWords, stopwords)
# 
# nw <- readLines("en_US_sample/words.twitter.txt")
# nC <- Corpus(VectorSource(nw))
# nC <- tm_map(nC, removeWords, stopwords)
# 
# tw <- readLines("en_US_sample/words.twitter.txt")
# tC <- Corpus(VectorSource(tw))
# tC <- tm_map(tC, removeWords, stopwords)


blogCount <- read.csv("en_US_sample/count.blogs.txt", header=FALSE)
names(blogCount) <- c("Count", "Word")
blogS <- blogCount[!(blogCount$Word %in% stopwords()), ]
blogWC <- blogS[1:500,]
#wordcloud(inverse.rle(list(lengths=blogWC$Count, values=blogWC$Word)))

newsCount <- read.csv("en_US_sample/count.news.txt", header=FALSE)
names(newsCount) <- c("Count", "Word")
newsS <- newsCount[!(newsCount$Word %in% stopwords()), ]
newsWC <- newsS[1:500,]

twitterCount <- read.csv("en_US_sample/count.twitter.txt", header=FALSE)
names(twitterCount) <- c("Count", "Word")
twitterS <- twitterCount[!(newsCount$Word %in% stopwords()), ]
twitterWC <- twitterS[1:500,]
