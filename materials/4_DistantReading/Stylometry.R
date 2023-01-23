# Stylometry

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

### 1. Delta analysis

# Call the packages
library(stylo)
library(networkD3)
# ...you'll have to do it each time you re-start the project

# Important note:
# Stylo will work by default with the files in the "corpus" folder

# First analysis (...with eyes closed...)
stylo()

# notice that stylo has generated a number of new files...
# including "stylo_config.txt", which tells all the features used

# Second analysis (specify the analysis features)
stylo(mfw.min=200, 
      mfw.max=200)
# for an explanation of all features, see the appendix below

# Third analysis (Consensus tree with 2000 MFW and Cosine Delta distance)
stylo(mfw.min=200, 
      mfw.max=2000,
      mfw.incr=200,
      distance.measure="dist.wurzburg",
      analysis.type="BCT",
      write.jpg.file=T,
      plot.custom.height=7,
      plot.custom.width=7)

# Fourth analysis (network)
stylo.network(mfw.min=200, 
              mfw.max=2000,
              mfw.incr=200,
              distance.measure="dist.wurzburg")

### 2. Zeta analysis

# first, we need to prepare the corpus by dividing it into two parts

# first, we list all the files in the "corpus" folder
all_files <- list.files("corpus", full.names = T)
all_files

# now we can create two groups (males and females)
male_files <- all_files[4:9]
female_files <- all_files[c(1:3, 10:12)]

# then we create two new folders
dir.create("primary_set")
dir.create("secondary_set")

# we create new names for the files to be copied
female_files_new <- gsub(pattern = "corpus/", replacement = "primary_set/", female_files, fixed = T)
male_files_new <- gsub(pattern = "corpus/", replacement = "secondary_set/", male_files, fixed = T)

# then we copy the files!
file.copy(male_files, male_files_new)
file.copy(female_files, female_files_new)

# now that everything is set...
# we can run the Zeta analysis (it's called "oppose" in stylo)
oppose(text.slice.length = 3000)

# remember to delete the created folders, if you want do do a different analysis 
unlink("primary_set/", recursive = T)
unlink("secondary_set/", recursive = T)

# Appendix

# Here is an overview of the options to put between the brackets
# 
# # Type of the corpus
# 
# corpus.format = ...
# - you can choose between "plain", "xml", "xml.drama", "html", and many others
# [Example]
# stylo(corpus.format = "plain")
#
# # Language of the corpus
# 
# corpus.lang = ...
# - you can choose between "English", "German", "Italian", "Latin", and many others
# [Example]
# stylo(corpus.format = "plain", corpus.lang = "Italian")
# 
# # Most frequent words
# 
# mfw.min = ...
# - any integer number
# mfw.max = ...
# - any integer number
# mfw.incr = ...
# - any integer number
# 
# [Example]
# stylo(corpus.format = "plain", corpus.lang = "Italian", mfw.min = 100, mfw.max = 1000, mfw.incr = 100)
# - (this will perform 10 analyses with 100, 200, 300, etc. MFW)
# 
# # Distance measures 
# 
# distance.measure = "..."
# - you can choose between the following:
#   - "dist.delta"
#   - "dist.euclidean"
#   - "dist.manhattan"
#   - "dist.argamon"
#   - "dist.eder"
#   - "dist.simple"
#   - "dist.canberra"
#   - "dist.cosine"
#   - "dist.wurzburg"
#   - "dist.minmax"
# 
# [Example]
# stylo(corpus.format = "plain", corpus.lang = "Italian", mfw.min = 100, mfw.max = 1000, mfw.incr = 100, distance.measure = "dist.wurzburg")
# - (this will perform 10 analyses with 100, 200, 300, etc. MFW, using the Wurzburg distance, i.e., Cosine Delta)
# 
# # Analysis type (i.e. visualization)
# 
# analysis.type = 
# - you can choose between the following:
#   - "CA"
#     - (that is cluster analysis, i.e. dendrograms)
#   - "BCT"
#     - (that is bootstrap consensus tree)
# 
# [Example]
# stylo(corpus.format = "plain", corpus.lang = "Italian", mfw.min = 100, mfw.max = 1000, mfw.incr = 100, distance.measure = "dist.wurzburg", analysis.type = "BCT")
# - (this will perform 10 analyses with 100, 200, 300, etc. MFW, using the Wurzburg distance, i.e., Cosine Delta, and will use them to generate a single consensus tree)
# 
# Much more details are available here: https://github.com/computationalstylistics/stylo_howto/blob/master/stylo_howto.pdf
# Note that if you will install Rstudio in your laptop, stylo will also have a graphical interface to set up these features
