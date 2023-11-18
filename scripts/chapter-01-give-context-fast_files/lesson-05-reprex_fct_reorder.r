# The point of the function is to create values to sort by
# Basically, that's what `fct_reorder()` behind the scenes
# Check out the values it would compute:

library(tidyverse)
data_we_have_anyway <- palmerpenguins::penguins |> 
  filter(!is.na(sex)) |> 
  mutate(
    group_median_bill_length = median(bill_length_mm),
    .by = c(species, sex)
  )

data_we_have_anyway |> 
  # now apply function on desired column
  summarise(
    value_to_sort_by = unique(group_median_bill_length) |> diff() |> abs(),
    .by = 'species'
  )




# By modifying the values that are computed, you can change the sorting
# For example, making all of those values negative will flip the order 
# of those values
data_we_have_anyway |> 
  # now apply function on desired column
  summarise(
    value_to_sort_by = -(
      unique(group_median_bill_length) |> diff() |> abs()
    ),
    .by = 'species'
  )


# Using that in fct_reorder()
penguins <- palmerpenguins::penguins |> 
  filter(!is.na(sex)) |> 
  mutate(
    group_median_bill_length = median(bill_length_mm),
    .by = c(species, sex)
  ) |> 
  mutate(
    species = fct_reorder(
      species,
      group_median_bill_length,
      .fun = \(x) -(unique(x) |> diff() |> abs())
    )
  )
dev.new()
dev.off()
penguins |> 
  ggplot(aes(species, bill_length_mm, fill = sex)) +
  geom_point(
    size = 3,
    alpha = 0.75,
    shape = 21,
    col = 'black',
    position = position_jitterdodge(seed = 34543)
  ) +
  theme_minimal(base_size = 16)  +
  labs(
    x = element_blank(),
    y = 'Bill Length',
    fill = 'Sex',
    title = 'Measurements of Different Penguin Species'
  ) +
  scale_fill_discrete(labels = \(x) str_to_title(x)) +
  scale_y_continuous(labels = scales::label_number(suffix = 'mm'))
