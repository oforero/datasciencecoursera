setwd(UCIFolder)

loadDataFromFolder <- function(folder, activityLabelFile="activity_labels.txt", featureNamesFile="features.txt",
                               subjectFile=paste(folder, "/subject_", folder, ".txt", sep=""),
                               activityFile=paste(folder, "/y_", folder, ".txt", sep=""),
                               featureFile=paste(folder, "/X_", folder, ".txt", sep="")) {
  
  # Load the labels of the main directorz
  activityLabels = read.csv(activityLabelFile, sep="", header=FALSE, stringsAsFactors=FALSE)
  colnames(activityLabels) <- c("Levels", "Labels")
  
  # Load the name of the features
  featureNames = read.csv(featureNamesFile, sep="", header=FALSE, stringsAsFactors=FALSE)
  
  #Laod and process the subjects file
  subjects = read.csv(subjectFile, sep="", header=FALSE, stringsAsFactors=FALSE)
  colnames(subjects) <- c("SubjectID")
  
  # Load and process the activity file
  testActivity = read.csv(activityFile, sep="", header=FALSE, stringsAsFactors=FALSE)
  colnames(testActivity) <- c("Activity")
  testActivity$Activity = cut(testActivity$Activity, 6, activityLabels$Labels)
  
  # Load and process the features file
  testFeatures = read.csv(featureFile, sep="", header=FALSE, stringsAsFactors=FALSE)
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

# Load the training data
train = loadDataFromFolder("train")
# Load the testing data
test = loadDataFromFolder("test")

# Merge both data sets 
merged = rbind(train, test)

# Write the final data set as a CSV file
write.csv(merged, "mergedDataSets.csv", quote=FALSE)
