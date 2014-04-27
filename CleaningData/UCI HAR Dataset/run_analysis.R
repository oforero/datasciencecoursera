setwd(UCIFolder)

loadDataFromFolder <- function(folder, activityLabelFile="activity_labels.txt", featureNamesFile="features.txt",
                               subjectFile=paste(folder, "/subject_", folder, ".txt", sep=""),
                               activityFile=paste(folder, "/y_", folder, ".txt", sep=""),
                               featureFile=paste(folder, "/X_", folder, ".txt", sep="")) {
  
  # Load the labels of the main directory
  activityLabels = read.csv(activityLabelFile, sep="", header=FALSE, stringsAsFactors=FALSE)
  colnames(activityLabels) <- c("Levels", "Labels")
  
  
  #Laod and process the subjects file
  subjects = read.csv(subjectFile, sep="", header=FALSE, stringsAsFactors=FALSE)
  colnames(subjects) <- c("SubjectID")
  
  # Load and process the activity file
  testActivity = read.csv(activityFile, sep="", header=FALSE, stringsAsFactors=FALSE)
  colnames(testActivity) <- c("Activity")
  testActivity$Activity = cut(testActivity$Activity, nrow(activityLabels), activityLabels$Labels)
  
  # Load and process the features file
  testFeatures = read.csv(featureFile, sep="", header=FALSE, stringsAsFactors=FALSE)
  # Load the name of the features and name the columns
  featureNames = read.csv(featureNamesFile, sep="", header=FALSE, stringsAsFactors=FALSE)
  colnames(testFeatures) <- featureNames[,2]
  
  # Select only the relevant features
  pattern = "*mean\\(\\)|*std\\(\\)"
  importantFeatureNames = grep(pattern, featureNames$V2)
  importantFeatures = featureNames[importantFeatureNames, 2]
  testFeatures = testFeatures[, importantFeatures]

  # Merge all the data sets into one and return
  result = cbind(subjects, testActivity, testFeatures)
  return(result)
}

# Load the training dataUCI 
train = loadDataFromFolder("train")
# Load the testing data
test = loadDataFromFolder("test")

# Merge both data sets 
merged = rbind(train, test)

# Write the final data set as a CSV file
write.csv(merged, "mergedDataSets.csv", quote=FALSE, row.names=FALSE)
