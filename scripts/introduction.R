library(datasets)
library(tidyverse)
library(gridExtra)

data(iris)
iris = as_tibble(iris)

##scatterplot : length and width of petals depending on species

print(iris)

p <- ggplot(
  iris,
  aes(
    x = Petal.Length,
    y = Sepal.Length,
    color = Species)
  )
p <- p + geom_point()
p <- p + theme_bw()
p <- p + xlab("Petal Length")
p <- p + ylab("Sepal Length")
p <- p + theme(
  legend.text = element_text(size=12),
  legend.title = element_text(size=14),
  axis.title = element_text(size = 14),
  axis.text = element_text(size = 12)
)
p <- p + scale_colour_brewer(palette = "Set1")

##boxplot : length of petals depending on species
q <- ggplot(
  iris,
  aes(
    x = Species,
    y = Petal.Length,
    fill = Species
  )
)
q <- q + geom_boxplot()
q <- q + theme_bw()
q <- q + xlab("Species")
q <- q + ylab("Petal Length")
q <- q + theme(
  legend.text = element_text(size=12),
  legend.title = element_text(size=14),
  axis.title = element_text(size = 14),
  axis.text = element_text(size = 12)
)
q <- q + scale_fill_brewer(palette = "Set1")


png("plots/intro.png", width = 960)
grid.arrange(p,q, nrow=1)
dev.off()

png("plots/intro_onlyboxplot.png", width = 480)
print(q)
dev.off()
