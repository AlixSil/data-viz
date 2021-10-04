library(tidyverse)

dir.create("plots/png/", recursive = T)
dir.create("plots/pdf")

### Load data and make the name of the columns workable"
data_student <- read_delim("../data/modified_students_performance.csv", delim = ";")

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


## One idea per graph
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
q <- q + guides(shape = guide_legend(title = "Has slept"))

print_fig("only_one_idea", q)

### Dark side of data viz###
data_student <- data_student %>%
  mutate(favorite_musical = factor(favorite_musical, levels = c("Dr. Horrible", "Hadestown", "Hamilton", "Exit", "Galavant")))

## Truncated axis
p <- ggplot(data_student, aes(x = favorite_musical, fill = favorite_musical))
p <- p + geom_bar()
p <- p + coord_cartesian(ylim = c(85, 320))
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

data_student_count <- data_student %>%
  group_by(favorite_musical) %>%
  summarise(count = n())

p <- ggplot(data_student_count, aes(x = favorite_musical, y = count, fill = favorite_musical))
p <- p + geom_bar(stat = "identity") + geom_line(group = "") + geom_point()
p <- p + theme_bw()
p <- p + xlab("Favourite musical")
p <- p + scale_fill_brewer(palette = "Set1")
p <- p + theme(
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20),
  legend.position = "None"
)

print_fig("barplot_line", p)

## Do not hide distribution
replace_name <- tibble(
  "type" = c("math_score", "writing_score", "reading_score"),
  "subject" = c("Maths", "Writing", "Reading")
)

data_long <- data_long %>%
  left_join(replace_name, by = "type")

data_median <- data_long %>%
  group_by(subject) %>%
  summarize(median_score = median(score, na.rm = TRUE))

p <- ggplot(data_median, aes(x = subject, y = median_score, fill = subject))
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

p <- ggplot(data_long, aes(x = subject, y = score, fill = subject))
p <- p + geom_boxplot(notch = T)
p <- p + theme_bw()
p <- p + scale_fill_brewer(palette = "Set2")
p <- p + theme(
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20),
  legend.position = "None"
)
p <- p + ylab("Scores")
print_fig("boxplot_scores", p)

p <- ggplot(data_long, aes(x = subject, y = score, fill = subject))
p <- p + geom_violin(width = 0.5)
p <- p + theme_bw()
p <- p + scale_fill_brewer(palette = "Set2")
p <- p + theme(
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20),
  legend.position = "None"
)
p <- p + ylab("Scores")
print_fig("violin_scores", p)

p <- ggplot(data_long, aes(x = subject, y = score, fill = subject))
p <- p + geom_violin(width = 0.5) + geom_boxplot(width = 0.1, notch = T)
p <- p + theme_bw()
p <- p + scale_fill_brewer(palette = "Set2")
p <- p + theme(
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20),
  legend.position = "None"
)
p <- p + ylab("Scores")
print_fig("violin_and_box_scores", p)

# Colors rainbow

counts_heros <- data_student %>%
  group_by(hero) %>%
  summarize(n_count = n()) %>%
  arrange(n_count)

data_student <- data_student %>%
  mutate(hero = factor(hero, levels = pull(counts_heros, hero)))

palette_to_use <- c("#FF0018", "#FFA52C", "#FFFF41", "#008018", "#0000F9", "#86007D")
names(palette_to_use) <- levels <- rev(pull(counts_heros, hero))

p <- ggplot(data_student, aes(y = hero, fill = hero))
p <- p + geom_bar()
p <- p + scale_fill_manual(values = palette_to_use)
p <- p + theme_bw()
p <- p + ylab("Personal hero")
p <- p + theme(
  legend.position = "none",
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 20)
)

print_fig("rainbow", p)

## Pie plots, and dougnut plots
data_student_perc <- data_student %>%
  group_by(favorite_musical) %>%
  summarize(count_favorite_musical = n()) %>%
  arrange(desc(favorite_musical)) %>%
  mutate(
    perc = 100 * count_favorite_musical / sum(count_favorite_musical),
    lab.pos = cumsum(perc) - 0.5 * perc
  )

p <- ggplot(data_student_perc, aes(x = "", y = perc, fill = favorite_musical))
p <- p + geom_bar(width = 1, stat = "identity")
p <- p + coord_polar("y", start = 0)
p <- p + geom_text(aes(y = lab.pos, label = paste(round(perc, 1), "%", sep = "")), color = "white", size = 5)
p <- p + ylab("") + xlab("")
p <- p + theme_void()
p <- p + scale_fill_brewer(palette = "Set1", name = "Favorite musical")
p <- p + theme(
  legend.text = element_text(size = 16),
  legend.title = element_text(size = 16)
)

print_fig("pie_plot", p)

p <- ggplot(data_student_perc, aes(x = 2, y = perc, fill = favorite_musical))
p <- p + geom_bar(width = 0.25, stat = "identity")
p <- p + coord_polar("y", start = 0)
p <- p + geom_text(aes(y = lab.pos, label = paste(round(perc, 1), "%", sep = "")), col = "white", size = 5)
p <- p + ylab("") + xlab("")
p <- p + theme_void()
p <- p + scale_fill_brewer(palette = "Set1", name = "Favorite musical")
p <- p + theme(
  legend.text = element_text(size = 16),
  legend.title = element_text(size = 16)
)
p <- p + xlim(1.4, 2.5)

print_fig("dougnut_plot", p)
