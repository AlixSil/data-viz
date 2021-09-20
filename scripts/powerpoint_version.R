library(tidyverse)

### Load data and make the name of the columns workable"
data_student <- read_delim("data/modified_students_performance.csv", delim = ";")

data_long <- data_student %>%
  gather(type, score, c("math_score", "writing_score", "reading_score"))

### General plot function for this script
print_fig <- function(na, ggplot_object) {
  pdf(paste("plots/pdf/", na, ".pdf", sep = ""))
  print(ggplot_object)
  dev.off()

  png(paste("plots/png/", na, ".png", sep = ""))
  print(ggplot_object)
  dev.off()
}

### Prove quality of plots matter###
print(colnames(data_student))

q <- ggplot(data_student, aes(x = math_score, y = writing_score, color = Has_slept))
q <- q + geom_point()
q <- q + xlab("x") + ylab("y")
q <- q + scale_color_discrete(name = "z")

print_fig("basics_awfull", q)

p <- ggplot(data_student, aes(x = math_score, y = writing_score, color = Has_slept))
p <- p + geom_point()


print_fig("basics_easy", p)


q <- ggplot(data_student, aes(x = math_score, y = writing_score, color = Has_slept))
q <- q + geom_point()
q <- q + theme_bw()
q <- q + xlim(c(0, 100)) + ylim(c(0, 100))
q <- q + xlab("Math score") + ylab("Writting score")
q <- q + scale_color_brewer(name = "Has slept", palette = "Set1")
q <- q + theme(
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20),
  legend.text = element_text(size = 16),
  legend.title = element_text(size = 16),
  legend.justification = c(1, 0),
  legend.position = c(0.95, 0.05),
  legend.box.background = element_rect(colour = "black")
)

print_fig("basics_worked", q)


##One idea per graph

q <- ggplot(data_student, aes(x = math_score, y = writing_score, color = favorite_musical, shape = Has_slept))
q <- q + geom_point()
q <- q + theme_bw()
q <- q + xlim(c(0, 100)) + ylim(c(0, 100))
q <- q + xlab("Math score") + ylab("Writting score")
q <- q + scale_color_brewer(name = "Favorite musical", palette = "Set1")
q <- q + theme(
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20),
  legend.text = element_text(size = 16),
  legend.title = element_text(size = 16),
)
q <- q + guides(shape=guide_legend(title="Has slept"))

print_fig("only_one_idea", q)

###Dark side of data viz###

##Truncated axis

p <- ggplot(data_student, aes(x = favorite_musical, fill = favorite_musical))
p <- p + geom_bar()
p <- p + coord_cartesian(ylim=c(85,320))
p <- p + theme_bw()
p <- p + xlab("Favourite musical")
p <- p + scale_fill_brewer(palette = "Set1")
p <- p + theme(
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20),
  legend.position = "None"
)
print_fig("barplot_truncated", p)


p <- ggplot(data_student, aes(x = favorite_musical, fill = favorite_musical))
p <- p + geom_bar()
p <- p + theme_bw()
p <- p + xlab("Favourite musical")
p <- p + scale_fill_brewer(palette = "Set1")
p <- p + theme(
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20),
  legend.position = "None"
)
print_fig("barplot_normal", p)

##Do not hide distribution
replace_name = tibble(
  "type" = c("math_score", "writing_score", "reading_score"),
  "subject" = c("Maths", "Writing", "Reading")
)

data_long <- data_long %>%
  left_join(replace_name, by = "type")

data_median <- data_long %>%
  group_by(subject) %>%
  summarize(median_score = median(score, na.rm = TRUE))


p <- ggplot(data_median, aes( x = subject, y = median_score, fill = subject))
p <- p + geom_bar(stat = "identity")
p <- p + theme_bw()
p <- p + scale_fill_brewer(palette = "Set2")
p <- p + theme(
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20),
  legend.position = "None"
)
p <- p + ylab("Median scores")

print_fig("barplot_median", p)

p <- ggplot(data_long, aes( x = subject, y = score, fill = subject))
p <- p + geom_boxplot()
p <- p + theme_bw()
p <- p + scale_fill_brewer(palette = "Set2")
p <- p + theme(
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20),
  legend.position = "None"
)
p <- p + ylab("Scores")
print_fig("boxplot_scores", p)


p <- ggplot(data_long, aes( x = subject, y = score, fill = subject))
p <- p + geom_violin()
p <- p + theme_bw()
p <- p + scale_fill_brewer(palette = "Set2")
p <- p + theme(
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20),
  legend.position = "None"
)
p <- p + ylab("Scores")
print_fig("violin_scores", p)

#Barplots are bad
