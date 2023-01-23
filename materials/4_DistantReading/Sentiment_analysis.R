# Sentiment analysis

# Welcome!
# This is an R script file, created by Simone
# Everything written after an hashtag is a comment
# Everything else is R code
# To activate the code, place the cursor on the corresponding line
# (or highlight multiple lines/pieces of code) 
# ...and press Ctrl+Enter (or Cmd+Enter for Mac)
# (the command will be automatically copy/pasted into the console)

# before you start, install the required packages
# (if a warning is shown above)

# set the working directory
setwd("materials/4_DistantReading/")

### 1. Basic Syuzhet analysis

# load the package
library(syuzhet) # you will have to do it every time you restart R

# read a text in the folder
# to read another text in the "corpus" folder, you have to change the title
# tip: you can help yourself by using the "Tab" key (autocomplete)
text <- readLines("corpus/Doyle_Study_1887.txt") 
# you might get a warning here (please disregard it!)

# R reads the text line by line. To simplify Syuzhet's work, let's collapse it in a single string
text <- paste(text, collapse = "\n")

# here Syuzhet comes into action: it splits the text into sentences
sentences_vector <- get_sentences(text)

# ...and calulates the sentiment for each sentence
syuzhet_vector <- get_sentiment(sentences_vector, method="syuzhet")

# let's visualize the results
syuzhet_vector

# put them in a graph
plot(
  syuzhet_vector, 
  type="l", 
  main="Sentiment Arc", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence"
)

# ...it is still too noisy: we'll need to use some filters
simple_plot(syuzhet_vector, title = "Sentiment arc")

# we can save the plot as a png file
png("Sentiment_arc.png", height = 900, width = 1600, res = 100)
simple_plot(syuzhet_vector, title = "Sentiment arc")
dev.off()

# we can also look at the basic emotions (Plutchik)
syuzhet_emotions <- get_nrc_sentiment(sentences_vector)

# and visualize the result (in a matrix)
View(syuzhet_emotions)

# to have an overview, we can calculate the mean for each emotion (i.e. the columns of the matrix)
colMeans(syuzhet_emotions)

### 2. Opening the Syuzhet box

# load the sentiment dictionaries included in Syuzhet
my_dictionary <- get_sentiment_dictionary("syuzhet")
View(my_dictionary)

my_dictionary <- get_sentiment_dictionary("afinn")
View(my_dictionary)

my_dictionary <- get_sentiment_dictionary("bing")
View(my_dictionary)

my_dictionary <- get_sentiment_dictionary("nrc")
View(my_dictionary)

# let's test different dictionaries on one sentence
my_sentence <- "It's beautiful to be nice and happy!"
get_sentiment(my_sentence, method="syuzhet")
get_sentiment(my_sentence, method="afinn")
get_sentiment(my_sentence, method="bing")
get_nrc_sentiment(my_sentence)

# let's test syuzhet on tough sentences
my_sentence <- "Well, he was like a potato!"
get_sentiment(my_sentence, method="syuzhet")
get_sentiment(my_sentence, method="afinn")
get_sentiment(my_sentence, method="bing")
get_nrc_sentiment(my_sentence)

# give me one sentence!
my_sentence <- "..."
get_sentiment(my_sentence, method="syuzhet")
get_sentiment(my_sentence, method="afinn")
get_sentiment(my_sentence, method="bing")
get_nrc_sentiment(my_sentence)
