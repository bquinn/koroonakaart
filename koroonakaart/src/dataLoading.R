library(dplyr)
library(jsonlite)
tests <- jsonlite::fromJSON("https://opendata.digilugu.ee/opendata_covid19_test_results.json")
tests <- as.data.frame(tests)
tests$ResultTime <- as.Date(tests$ResultTime)
tests$AnalysisInsertTime <- as.Date(tests$AnalysisInsertTime)
tests_gender <- tests %>% group_by(ResultValue) %>%  count(Gender)
tests_age <- tests %>% group_by(ResultValue) %>% count(AgeGroup)
tests_positive_day <- tests %>% group_by(ResultTime, ResultValue) %>% count(.)
tests_by_county <- tests %>% group_by(County, ResultValue) %>% count(.)
tests_by_age_gender <- tests %>% group_by(AgeGroup, Gender, ResultValue) %>% count(.)
tests_pos_neg <- tests %>% group_by(ResultValue) %>% count(.)
list_df <- list(gender = tests_gender,age_group = tests_age,tests_by_day = tests_positive_day,tests_county = tests_by_county,age_gender = tests_by_age_gender,total_po_neg = tests_pos_neg)
jsonlite::write_json(list_df,"data2.json")
