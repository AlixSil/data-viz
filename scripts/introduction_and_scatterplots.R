library(datasets)
library(tidyverse)
library(gridExtra)

data(iris)
iris <- as_tibble(iris)

## scatterplot : length and width of petals depending on species
p <- ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Petal.Length,
    color = Species
  )
)
p <- p + geom_point()
p <- p + theme_bw()
p <- p + xlab("Sepal Length")
p <- p + ylab("Petal Length")
p <- p + theme(
  legend.text = element_text(size = 12),
  legend.title = element_text(size = 14),
  axis.title = element_text(size = 14),
  axis.text = element_text(size = 12)
)
p <- p + scale_colour_brewer(palette = "Set1")

## boxplot : length of petals depending on species
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
  legend.text = element_text(size = 12),
  legend.title = element_text(size = 14),
  axis.title = element_text(size = 14),
  axis.text = element_text(size = 12)
)
q <- q + scale_fill_brewer(palette = "Set1")


png("plots/png/intro.png", width = 960)
grid.arrange(p, q, nrow = 1)
dev.off()


png("plots/png/scatterplot_example.png")
print(p)
dev.off()


## scatterplot : length and width of petals depending on species
p <- ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Petal.Length,
    color = Species
  )
)
p <- p + geom_point()
p <- p + theme_bw()
p <- p + xlab("Sepal Length")
p <- p + ylab("Petal Length")
p <- p + theme(
  legend.text = element_text(size = 12),
  legend.title = element_text(size = 14),
  axis.title = element_text(size = 14),
  axis.text = element_text(size = 12)
)
p <- p + scale_colour_brewer(palette = "Set1")

q <- p
q <- q + xlim(c(0,8)) + ylim(c(0,7))

png("plots/png/scatterplot_orthonormal.png", width = 960)
grid.arrange(p, q, nrow = 1)
dev.off()


p <- ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Petal.Length,
    color = Species,
    group = Species
  )
)
p <- p + geom_smooth(method = "lm")
p <- p + geom_point()
p <- p + theme_bw()
p <- p + xlab("Sepal Length")
p <- p + ylab("Petal Length")
p <- p + theme(
  legend.text = element_text(size = 12),
  legend.title = element_text(size = 14),
  axis.title = element_text(size = 14),
  axis.text = element_text(size = 12)
)
p <- p + scale_colour_brewer(palette = "Set1")

png("plots/png/scatterplot_with_lm.png")
print(p)
dev.off()
