# Text-mining NLP
introduction
This project aims to apply text analysis, classification, and clustering methods to a real-world corpus. The code is implemented in two programming languages: R for the first part and Python for the second part. The project deadline is June 18th, 2023.

Dataset
The dataset used for this project is the Reuters collection of documents provided. It is already split into a training set and a test set. Each subset contains 91 topics or subfolders.

Part 1: R

Objectives
Clean the data: Write the R code to clean the data and provide an example of its application to a subset of the data.
Statistics:
Demonstrate the high dimensionality and sparsity of the data.
Select specific topics from the training and test sets and represent them using wordclouds. Comment on the results.
Represent each document in a subset of the data as a vector of TF-IDF values and measure similarity between document pairs using these vectors.
Classification: Create and test a Bayesian classifier for the data.
Represent each document as a bag of words.
Apply classification to a subset of the data containing less than 10 topics.
Recommended R Libraries
Use the following R libraries:

read text
sub
Any other libraries necessary for the project (whether covered during the course or not).

Part 2: Python
Objectives
Clean, tokenize, and lemmatize the data: Write the Python code to perform these tasks on the entire dataset.
Statistics:
Compute the number of occurrences of each word in the entire corpus and the number of documents containing each word.
Clustering: Apply a clustering method where a cluster is defined as a set of documents containing a common frequent termset.
Find the frequent termsets.
Find the set of documents (cluster candidate) that includes a given frequent termset.
