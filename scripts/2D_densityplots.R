##Load librairies and datasets
library(tidyverse)
library(gridExtra)

#We will here use the diamonds dataset included in ggplot2
#str(diamonds)

## 2D density plots
p <- ggplot(
  faithful,
  aes(
    x = eruptions,
    y = waiting,
  )
)
p <- p + geom_density_2d()
p <- p + theme_classic()
p <- p + xlab("Eruption length")
p <- p + ylab("Wait Length")
p <- p + theme(
  legend.text = element_text(size = 12),
  legend.title = element_text(size = 14),
  axis.title = element_text(size = 14),
  axis.text = element_text(size = 12)
)


png("plots/png/2D_density_map.png")
print(p)
dev.off()

p <- ggplot(
  faithful,
  aes(
    x = eruptions,
    y = waiting,
  )
)
p <- p + geom_density_2d_filled()
p <- p + theme_classic()
p <- p + xlab("Eruption length")
p <- p + ylab("Wait Length")
p <- p + theme(
  legend.text = element_text(size = 12),
  legend.title = element_text(size = 14),
  axis.title = element_text(size = 14),
  axis.text = element_text(size = 12)
)

png("plots/png/2D_density_filled.png")
print(p)
dev.off()
