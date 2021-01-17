# Download ski data available from web
skiURL <- "https://gist.githubusercontent.com/Ewiseman/b251e5eaf70ca52a4b9b10dce9e635a4/raw/9f0100fe14169a058c451380edca3bda24d3f673/ski_resort_stats.csv"
skiData <- read.csv(url(skiURL))
