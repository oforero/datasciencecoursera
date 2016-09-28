library(tm)

preProcessInput <- function(input) {  
  # Remove the non-alphabatical characters
  inStr <- iconv(input, "latin1", "ASCII", sub=" ");
  inStr <- gsub("[^[:alpha:][:space:]]", "", inStr);
  print(inStr)
  if (nchar(inStr) > 0) {
    return(inStr); 
  } else {
    return("");
  }
}

findInNGrams <- function(input, ngrams=model, n=2) {
  inStr <- unlist(strsplit(preProcessInput(input), split=" "))
  inLen <- length(inStr)
  
  if(inLen >= n) {
    inGram <- paste(inStr[(inLen-n):inLen], collapse=" ")
    search <- paste("*", input, "*", sep = "");
    result <- ngrams[grep (search, ngrams$context, ignore.case=TRUE), ]  
    result <- result[grep("[^#$]", result$word), ]
    if(nrow(result) == 0) {
      return(NULL)
    } else {
      return(result[order(-result$p),])      
    }
  } else {
    return(NULL)
  }
  
}