predict_next_word <- function (phrase, ngrams, grams = 3:1) {
  
  # sanity checks
  stopifnot (is.character (phrase))
  stopifnot (length (phrase) == 1)
  
  # clean the input phrase
  clean_phrase <- clean_sentences (split_sentences (phrase))
  
  # break the sentence into its component words
  words <- split_on_space (clean_phrase)
  
  # HACK only remove the 'end of sentence marker' if the phrase
  # did not end with a period.  currently difficult to tell if 
  # the phrase has an explicit sentence ending or if the clean_sentences
  # function is assuming there should be one.
  if (!stri_detect (phrase, regex = ".*[\\.!?][[:blank:]]*$"))
    words <- head (words, -1)
  
  predictions <- NULL
  for (g in grams) {
    
    # ensure there are enough previous words 
    # for example, a trigram ngrams needs 2 previous words
    if (length (words) >= g-1) {
      
      # grab the last 'g-1' words
      ctx <- tail (words, g-1)
      ctx <- paste (ctx, collapse = " ")
      
      # find the top 'N' predictions
      predictions <- ngrams [ context == ctx, list (word, p)]
      if (nrow (predictions) > 0) {
        
        # basic corrections for predictions that should not be made
        predictions [word == "$", word := "."]
        predictions [word == "###", word := NA]
        
        # exclude any missing predictions
        predictions <- predictions [complete.cases (predictions)]
        
        break
      }
    }
  }
  
  return (predictions)
}

#
# performs pre-processing on 1 or more sentences.
#
clean_sentences <- function (sentences, start_tag = "^", end_tag = "$") {
  
  # lower case
  sentences <- stri_trans_tolower (sentences)
  
  # remove anything that is not alpha, numeric, whitespace or ' (for contractions)
  sentences <- stri_replace_all_regex (sentences, "[^[:alnum:][:blank:]']+", " ")
  
  # replace all digits with a simple indicator flag
  sentences <- stri_replace_all_regex (sentences, "[[:digit:]]+", "###")
  
  # add starting/ending tag to each sentence
  sentences <- stri_paste (start_tag, sentences, end_tag, sep = " ")
  
  # trim whitespace
  sentences <- stri_trim_both (sentences)
  
  return (sentences)
}

#
# a useful function for when no starting or ending tags are needed
#
clean_sentences0 <- function (x) clean_sentences (x, start_tag = "", end_tag = "")

split_sentences <- function (phrase) {
  
  # split based on periods, exclams or question marks
  result <- unlist (strsplit (phrase, split = "[\\.!?]+"))
  
  # trim excess whitespace
  result <- stri_trim_both (result)
  
  # do not return empty strings
  result <- result [nchar (result) > 0]
  
  # ensure that something is always returned
  if (length (result) > 0)
    result
  else 
    ""
}

split_on_space <- function (x) {
  result <- unlist (strsplit (x, split = "[ ]+"))
  result [nchar (result) > 0]
}