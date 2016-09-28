Shiny Text Prediction
========================================================
author: Oscar Forero
date: December 14, 2014

## JHU Capstone

Prediction Algorithm
========================================================

1. The application uses a model of NGrams (1,2,3), Next Word, Probability.
2. Clean up the input: remove non alphanumeric characters, make lowercase
3. Search the resulting NGram in the table using regular expressions 
4. Sort the results in descending probability order
5. Return the the Next Word column from the first returned row

Building the Model
========================================================

1. The first steps was to clean up the data (line endings, etc)
2. Use the TM package to create a corpus
3. Transform the input (make all lowercase, remove numbers)
4. Build Term Document Matrices for 2, 3 and 4 NGrams
5. Combine the TDMs
6. Transform the input into a table of NGram, Next Word, Probability
   The NGram is the firs n-1 words of each NGram
   The Next word is the last word of each NGram

Using the application:
========================================================

The application is running in [shinyapps.io](https://oforero.shinyapps.io/JHUCapstone/)

1. Input phrase in the text field
2. Press the "I'm feeling lucky" button
3. The predicted phrase will be written to the right of the output
4. The predicted word is the last one of the output phrase
5. Other possible words are shown in the bar plot below

Conclusion
========================================================

- The biggest challenge was to deal with a data set too big to be easily managed in my laptop
  * Loading all the data in memory resulted in computer hanging
  * Using a Directory Data Source improved the situation but the processing was too slow
  * I tried different parallel processing approaches but I was unable to make any work reliably enough

- The TM library does supports parallel processing
  * It requires to setup a cluster using makeCluster
  * Not all operations scale with increased number of cores
    Document stemming does not executes in parallel
