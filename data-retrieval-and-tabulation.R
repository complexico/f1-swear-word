library(tidyverse)

# source("gsheetlinks.R")
# 
# f1_data <- googlesheets4::read_sheet(gsheetslink,
#                                      sheet = "Sheet1")

# write_tsv(f1_data,
#           file = "data-raw/f1-data.tsv")

f1_data <- read_tsv("data-raw/f1-data.tsv")

sw_cat_df <- f1_data |> 
  count(Swear_Words_Category) |> 
  mutate(prop = n/sum(n)) |> 
  mutate(prop = round(prop, digits = 2)) |> 
  arrange(desc(n))

sw_cat_df

write_tsv(sw_cat_df, "data-out/sw_cat_df.tsv")

sw_term_df <- f1_data |> 
  count(Swear_Words_Term, name = "n_term") |> 
  mutate(lemma = str_replace(Swear_Words_Term,
                             "(ed|ing)$",
                             ""),
         lemma = str_to_upper(lemma)) |> 
  group_by(lemma) |> 
  mutate(n_lemma = sum(n_term)) |> 
  ungroup()

write_tsv(sw_term_df, "data-out/sw_term_df.tsv")

sw_term_lemma <- sw_term_df |> 
  select(matches("lemma")) |> 
  distinct() |> 
  ungroup() |> 
  arrange(desc(n_lemma)) |> 
  mutate(prop_lemma = n_lemma/sum(n_lemma)) |> 
  mutate(prop_lemma = round(prop_lemma, digits = 2))

write_tsv(sw_term_lemma, "data-out/sw_term_lemma.tsv")
