# -*- coding: utf-8 -*-
"""
Created on Tue Aug 27 22:49:36 2024

@author: digui
"""

from leia import SentimentIntensityAnalyzer

# Initialize the analyzer
s = SentimentIntensityAnalyzer()

# Examples of sentiment analysis
examples = [
    "Eu estou feliz",
    "Eu estou feliz :)",
    "Eu não estou feliz",
    "Este produto é incrível!",
    "O atendimento foi horrível.",
    "Estou indiferente ao resultado."
]

# Analyzing the sentiment of each example
for text in examples:
    sentiment = s.polarity_scores(text)
    print(f"Frase: {text}")
    print(f"Sentimento: {sentiment}\n")

#%% 

from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score

# Example dataset
texts = ["I love this product", "This is the worst experience ever", "Not bad", "Absolutely fantastic", "Would not recommend"]
labels = [1, 0, 1, 1, 0]  # 1 = Positive, 0 = Negative

# Split data
X_train, X_test, y_train, y_test = train_test_split(texts, labels, test_size=0.2, random_state=42)

# Vectorize text (you can use either CountVectorizer or TfidfVectorizer)
vectorizer = TfidfVectorizer()
X_train_vec = vectorizer.fit_transform(X_train)
X_test_vec = vectorizer.transform(X_test)

# Naive Bayes
nb_model = MultinomialNB()
nb_model.fit(X_train_vec, y_train)
nb_predictions = nb_model.predict(X_test_vec)
print("Naive Bayes Accuracy:", accuracy_score(y_test, nb_predictions))

# SVM
svm_model = SVC(kernel='linear')
svm_model.fit(X_train_vec, y_train)
svm_predictions = svm_model.predict(X_test_vec)
print("SVM Accuracy:", accuracy_score(y_test, svm_predictions))
