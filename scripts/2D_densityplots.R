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

q <- ggplot(
  faithful,
  aes(
    x = eruptions,
    y = waiting,
  )
)
q <- q + stat_density_2d(
  geom = "raster",
  aes(fill = after_stat(density)),
  contour = FALSE
) + scale_fill_viridis_c()
q <- q + theme_classic()
q <- q + xlab("Eruption length (s)")
q <- q + ylab("Wait Length (s)")
q <- q + theme(
  legend.text = element_text(size = 12),
  legend.title = element_text(size = 14),
  axis.title = element_text(size = 14),
  axis.text = element_text(size = 12)
)
q <- q + guides(fill = guide_colorbar())

png("plots/png/2D_density_filled.png")
print(q)
dev.off()


png("plots/png/density_map_and_filled.png", width = 960)
grid.arrange(p, q, nrow = 1)
dev.off()
