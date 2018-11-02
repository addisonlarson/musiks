rm(list=ls())
library(tuneR); library(ggplot2)
setwd("D:/AP LARSON/musiks")
l <- list.files("."); l <- sample(l, 10, replace = FALSE)
res <- data.frame()
for (i in 1:length(l)){
  vid <- readMP3(l[i])
  leftChannel <- vid@left
  time <- (0:(length(leftChannel)-1)) / vid@samp.rate
  # simplify elements (too many obs to plot)
  sub <- seq(0, length(leftChannel), 10000)
  leftSample <- leftChannel[sub]; timeSample <- time[sub]
  obs <- cbind(rep_len(l[i], length(leftSample)), leftSample, timeSample)
  res <- rbind(res, obs)
}
# clean
res$leftSample <- as.numeric(as.character(res$leftSample))
res$timeSample <- as.numeric(as.character(res$timeSample))
# type 1: original elements
res$order <- 1:length(res$leftSample)
# cols <- c("#1d3b1b", "#21421e", "#375434", "#4d674a", "#637a61",
#           "#798d78", "#90a08e", "#a6b3a5", "#bcc6bb", "#d2d9d2")
# p <- ggplot(res, aes(x = order, y = leftSample, group = V1, color = V1)) + geom_line() +
# coord_polar(start = 120) + scale_color_manual(values = cols) +
p <- ggplot(res, aes(x = order, y = leftSample, group = V1)) + geom_line(color = "#a6b3a5") +
  coord_polar() +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank())
tiff("D:/AP LARSON/musiks/musiks/p.tiff", units = "in", width = 10, height = 10, res = 600, compression = "lzw")
plot(p)
dev.off()
