library(tidyverse)

data_student <- read_delim("data/StudentsPerformance.csv", delim = ",")
# data_student <- data_student %>%
#   rename_with(~ gsub(" ", "_", .x, fixed = TRUE)) %>%
#   rename(favorite_sandwich = gender,
#     favorite_musical = "race/ethnicity",
#     hero = parental_level_of_education,
#     slept = test_preparation_course)

replace_gender = tibble(gender = c("male", "female"),
  favorite_sandwich = c("Elvis sandwich", "Strawberry chicken"))
replace_ethnicity = tibble("race/ethnicity" = c("group A", "group B", "group C", "group D", "group E"),
  "favorite_musical" = c("Galavant", "Hamilton", "Dr. Horrible", "Hadestown", "Exit"))

 to_replace <- data_student %>%
   pull("parental level of education") %>%
   unique()

replace_parents = tibble("parental level of education" = to_replace,
  "hero" = c("Kirby", "Julie D'Aubigny", "Sonic", "Hercules", "Captain Marvel", "Peter Pan"))

to_replace <- data_student %>%
  pull("test preparation course") %>%
  unique()

replace_test = tibble("test preparation course" = to_replace,
  "Has_slept" = c("Yes", "No"))

data_student <- data_student %>%
  left_join(replace_gender, by = "gender") %>%
  left_join(replace_ethnicity, by = "race/ethnicity") %>%
  left_join(replace_parents, by = "parental level of education") %>%
  left_join(replace_test, by = "test preparation course")


data_student <- data_student %>%
  rename_with(~ gsub(" ", "_", .x, fixed = TRUE)) %>%
  select(favorite_sandwich, favorite_musical, hero, Has_slept, math_score, writing_score, reading_score)

write.table(data_student, file = "data/modified_students_performance.csv", sep = ";", quote = F, row.names = F)
