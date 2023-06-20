library(readtext)
library(tm)
library(Matrix)
library(wordcloud)
library(SnowballC)
library(textTinyR)
library(dplyr)
library(naivebayes)

# Load Reuters dataset
training_set_path <- "C:\\Users\\CYTech Student\\OneDrive\\Desktop\\Reuters_Dataset\\Reuters_Dataset\\training"
test_set_path <- "C:\\Users\\CYTech Student\\OneDrive\\Desktop\\Reuters_Dataset\\Reuters_Dataset\\test"


# Read the training files and extract the data
train_df <- data.frame(subject = character(), content = character(), stringsAsFactors = FALSE)
train_files <- list.files(training_set_path, recursive = TRUE, full.names = TRUE)

for (file in train_files) {
  text <- readLines(file) %>% paste(collapse = " ")
  subject <- basename(dirname(file))
  train_df <- train_df %>% 
    add_row(subject = subject, content = text)
}

# Read the test files and extract the data
test_df <- data.frame(subject = character(), content = character(), stringsAsFactors = FALSE)
test_files <- list.files(test_set_path, recursive = TRUE, full.names = TRUE)

for (file in test_files) {
  text <- readLines(file) %>% paste(collapse = " ")
  subject <- basename(dirname(file))
  test_df <- test_df %>% 
    add_row(subject = subject, content = text)
}

# selected topics
selected_topics <- c("cocoa", "alum", "barley", "tea", "wpi", "ship")

# Pre steps for the train corpus
train_corpus <- Corpus(VectorSource(subset_train$content))
train_corpus <- tm_map(train_corpus, content_transformer(tolower))
train_corpus <- tm_map(train_corpus, removeNumbers)
train_corpus <- tm_map(train_corpus, removePunctuation)
train_corpus <- tm_map(train_corpus, stripWhitespace)
train_corpus <- tm_map(train_corpus, removeWords, stopwords("english"))
train_corpus <- tm_map(train_corpus, stemDocument)

# Pre steps for the test corpus
test_corpus <- Corpus(VectorSource(subset_test$content))
test_corpus <- tm_map(test_corpus, content_transformer(tolower))
test_corpus <- tm_map(test_corpus, removeNumbers)
test_corpus <- tm_map(test_corpus, removePunctuation)
test_corpus <- tm_map(test_corpus, stripWhitespace)
test_corpus <- tm_map(test_corpus, removeWords, stopwords("english"))
test_corpus <- tm_map(test_corpus, stemDocument)

# wordcloud for the training set
train_tdm <- TermDocumentMatrix(train_corpus, control = list(removeNumbers = TRUE, stopwords = stopwords("english")))
train_freq <- rowSums(as.matrix(train_tdm))

#  wordcloud for the test set
test_tdm <- TermDocumentMatrix(test_corpus, control = list(removeNumbers = TRUE, stopwords = stopwords("english")))
test_freq <- rowSums(as.matrix(test_tdm))

# Plot wordclouds for training set
wordcloud(names(train_freq), train_freq, random.order = FALSE)

# Plot wordclouds for test set
wordcloud(names(test_freq), test_freq, random.order = FALSE)

# Create bag of words representation for training set
train_dtm <- DocumentTermMatrix(train_corpus)

# Convert the document-term matrix to a matrix
train_data <- as.matrix(train_dtm)

# Create bag of words representation for test set
test_dtm <- DocumentTermMatrix(test_corpus, control = list(dictionary = Terms(train_dtm)))
test_data <- as.matrix(test_dtm)

# Subset the data containing less than 10 topics
subset_train <- subset(train_df, subject %in% selected_topics)
subset_test <- subset(test_df, subject %in% selected_topics)

if (!require(e1071)) {
  install.packages("e1071")
}

# Load the e1071 package
library(e1071)


# Create and train the Bayesian classifier
classifier <- naiveBayes(subject ~ ., data = subset_train)

# Make predictions on the test set
predicted_topics <- predict(classifier, subset_test)

# Calculate accuracy
accuracy <- sum(predicted_topics == subset_test$subject) / nrow(subset_test)

# Print the accuracy
print(accuracy)

# Check dimensionality of the data
train_dim <- dim(train_data)
test_dim <- dim(test_data)

print("Dimensionality of Training Data:")
print(train_dim)

print("Dimensionality of Test Data:")
print(test_dim)

# Check sparsity of the data
train_sparsity <- sum(train_data == 0) / length(train_data)
test_sparsity <- sum(test_data == 0) / length(test_data)

print("Sparsity of Training Data:")
print(train_sparsity)

print("Sparsity of Test Data:")
print(test_sparsity)
