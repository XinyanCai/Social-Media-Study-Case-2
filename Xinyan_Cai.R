rm(list=ls())
library(topicmodels)
library(tm)
library(wordcloud)


setwd("C:/Users/XINYAN CAI/Desktop/data")
mydic <- tolower(scan('ingredients.txt', character(), quote = "", sep = "\n"))

docs <- Corpus(DirSource(c("C:/Users/XINYAN CAI/Desktop/data/fb2011",
                           "C:/Users/XINYAN CAI/Desktop/data/fb2012",
                           "C:/Users/XINYAN CAI/Desktop/data/fb2013",
                           "C:/Users/XINYAN CAI/Desktop/data/fb2014",
                           "C:/Users/XINYAN CAI/Desktop/data/fb2015")))
dtm <- DocumentTermMatrix(docs, control=list(dictionary = mydic, tolower=T, removePunctuation=T, removeNumbers=T, 
                                             stripWhitespace=T, stopwords=c(stopwords("english"), stopwords("spanish"))))
dtm = removeSparseTerms(dtm,0.996)
m <- as.matrix(dtm) 
df = data.frame(m)

#Frequency of different words
data <- data.frame(year=as.numeric(substr(rownames(df),7,10)),
                   month=as.numeric(substr(rownames(df),12,13)), 
                   stringsAsFactors=FALSE); 
da <- cbind(df, data)
da <- aggregate(x = da, by = list(da$month, da$year),FUN = sort)

# Construct plots of different words
Word.search <- function(i) {
  i<- tolower(i)
  plot(da[ ,i], type='l',xlab = 'Month',ylab = 'Frequency', 
       main = c('Number of', i, 'in 60 months'))
} 

# Cauliflower Rice
Word.search('Cauliflower')
Word.search('Rice')

# Vegetables Noodles
Word.search('Vegetables')
Word.search('Noodles')

# Pumpkin Pie
Word.search('Pumpkin')
Word.search('Pie')
